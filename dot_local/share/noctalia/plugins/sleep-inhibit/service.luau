--!nonstrict

local pending = false

local function refresh()
    if pending then
        return
    end

    pending = true
    local accepted = noctalia.runAsync(
        { "systemctl", "--user", "is-active", "--quiet", "noctalia-sleep-inhibit.service" },
        function(result)
            pending = false
            noctalia.state.set("active", result.exitCode == 0)
        end
    )

    if not accepted then
        pending = false
        noctalia.state.set("active", false)
    end
end

noctalia.setUpdateInterval(2000)

function update()
    refresh()
end

function onIpc(event)
    if event == "refresh" then
        refresh()
    end
end

refresh()
