--!nonstrict

local active = noctalia.state.get("active") == true
local busy = false

local function render()
    shortcut.setLabel("保持唤醒")
    shortcut.setIcon("coffee")
    shortcut.setActive(active)
    shortcut.setEnabled(not busy)
end

local function notifyResult()
    if active then
        noctalia.notify(
            "保持唤醒已开启",
            "屏幕仍会按空闲计时熄灭，系统不会自动睡眠"
        )
    else
        noctalia.notify(
            "保持唤醒已关闭",
            "系统将在达到空闲超时后自动睡眠"
        )
    end
end

local function toggle()
    if busy then
        return
    end

    busy = true
    render()

    local targetActive = not active
    local action = targetActive and "start" or "stop"
    local accepted = noctalia.runAsync(
        { "systemctl", "--user", action, "noctalia-sleep-inhibit.service" },
        function(result)
            if result.exitCode == 0 then
                active = targetActive
                noctalia.state.set("active", active)
                local checking = noctalia.runAsync(
                    { "systemctl", "--user", "is-active", "--quiet", "noctalia-sleep-inhibit.service" },
                    function(status)
                        busy = false
                        if status.exitCode == 0 or status.exitCode == 3 then
                            active = status.exitCode == 0
                            noctalia.state.set("active", active)
                            if active == targetActive then
                                notifyResult()
                            else
                                noctalia.notifyError("保持唤醒状态已变化", "服务状态与请求不一致，请重试")
                            end
                        else
                            noctalia.notifyError("无法确认保持唤醒状态", status.stderr)
                        end
                        render()
                    end
                )
                if checking then
                    return
                end
                noctalia.notifyError("无法确认保持唤醒状态", "无法运行 systemctl")
            else
                noctalia.notifyError("无法切换保持唤醒", result.stderr)
            end

            busy = false
            render()
        end
    )

    if not accepted then
        busy = false
        render()
        noctalia.notifyError("无法切换保持唤醒", "无法运行 systemctl")
    end
end

noctalia.state.watch("active", function(value)
    active = value == true
    render()
end)

function onClick()
    toggle()
end

function onIpc(event)
    if event == "toggle" then
        toggle()
    end
end

render()
