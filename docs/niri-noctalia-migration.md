# 从 KDE Plasma 迁移到 niri + Noctalia

> 归档说明：这是家用笔记本迁移成功时的过程记录，不是当前公司 PC 的实时配置。
> 两台设备现在的有效配置和差异以仓库根目录的 `README.md` 和 chezmoi 模板为准。

本文适用于当时迁移的家用 EndeavourOS（Arch Linux 系）笔记本，内容于
2026-08-27 根据该机软件包和上游文档核对。

当前环境的主要条件：

- KDE Plasma Wayland，会话由 SDDM 启动
- NVIDIA RTX 3070 Mobile，使用 `nvidia-open` 和 `nvidia-utils 610`
- 已安装 PipeWire、WirePlumber、NetworkManager、BlueZ、UPower、
  power-profiles-daemon、Fcitx5、Papirus 和 Ghostty
- dotfiles 由 chezmoi 管理

建议分两个阶段迁移：先保留 Plasma 和 SDDM，让 niri 与 KDE 并存；确认 niri、
Noctalia、输入法、屏幕共享和电源管理稳定后，再删除 KDE 桌面组件。

目标结构如下：

```text
SDDM（迁移期间保留）
└─ niri-session
   ├─ niri：Wayland 合成器
   ├─ Noctalia v5：面板、启动器、通知、锁屏、壁纸
   ├─ GTK 应用与主题
   ├─ GTK portal：文件选择
   ├─ GNOME portal：录屏和屏幕共享
   └─ GNOME Keyring：密码和 Secret Service
```

> niri 不是 GTK 程序，Noctalia v5 也不是 GTK 程序。这里的“使用 GTK”是指
> 应用、主题、文件选择器和常用桌面工具以 GTK 为主。如果要求桌面壳本身必须
> 使用 GTK，就不能选用 Noctalia。

## 1. 保存当前状态

暂时不要删除 Plasma 或 SDDM。

```bash
cd ~/.local/share/chezmoi

git status --short
./dot_pkglist/help.sh
git diff -- dot_pkglist/home-laptop-pacman.txt dot_pkglist/home-laptop-aur.txt

cp -a ~/.config/gtk-3.0 ~/.config/gtk-3.0.before-niri
cp -a ~/.config/gtk-4.0 ~/.config/gtk-4.0.before-niri
```

`dot_pkglist/help.sh` 会更新 `home-laptop-*` 两份清单，与执行命令时的当前目录
无关。检查差异，确认快照内容正确后再提交。

如果新会话黑屏，可以按 `Ctrl+Alt+F3` 进入 TTY，然后恢复 SDDM：

```bash
sudo systemctl restart sddm
```

## 2. 安装组件

Noctalia v5 已进入 Arch 官方 `extra` 仓库，包名是 `noctalia`。不要按照旧教程
安装 `noctalia-shell`、`quickshell` 或 `noctalia-qs`。

截至本文核对日期，Arch 提供的是 `5.0.0_beta.9-3`，上游也明确说明 v5 仍处于
Beta 阶段。配置名称和行为仍可能调整；升级后应先运行 `noctalia config validate`，
并延长与 Plasma 并存测试的时间。可随时检查仓库中的当前版本：

```bash
pacman -Si noctalia
```

```bash
sudo pacman -Syu \
  niri noctalia xwayland-satellite \
  xdg-desktop-portal-gnome xdg-desktop-portal-gtk \
  gnome-keyring libsecret \
  adw-gtk-theme nwg-look
```

`xdg-desktop-portal-gnome` 当前会带入 Nautilus。GNOME portal 负责 niri 下的
屏幕共享；GTK portal 用于文件选择等基础功能。

Noctalia 已经提供面板、启动器、通知、锁屏、壁纸、音量和亮度控制，因此无需
另外安装 Waybar、Fuzzel、Mako、Swaylock 或 Swaybg。

如果需要通过 DDC/CI 控制外接显示器亮度，还应显式安装 `ddcutil`。本机当前的
`ddcutil` 是 PowerDevil 的依赖；将它改为显式安装可避免删除 PowerDevil 时被
递归清理：

```bash
sudo pacman -S --asexplicit ddcutil
```

参考：

- [Noctalia v5 安装文档](https://docs.noctalia.dev/noctalia/getting-started/installation/)
- [Arch Linux 的 Noctalia 包信息](https://archlinux.org/packages/extra/x86_64/noctalia/)
- [Noctalia v5 上游状态说明](https://github.com/noctalia-dev/noctalia)
- [niri 所需桌面组件](https://github.com/niri-wm/niri/wiki/Important-Software)

## 3. 建立 niri 配置

从软件包提供的默认配置开始：

```bash
mkdir -p ~/.config/niri

test -e ~/.config/niri/config.kdl || \
  cp /usr/share/doc/niri/default-config.kdl ~/.config/niri/config.kdl
```

编辑 `~/.config/niri/config.kdl`。

把默认的：

```kdl
spawn-at-startup "waybar"
```

替换为：

```kdl
spawn-at-startup "noctalia"
spawn-at-startup "fcitx5" "-d"
```

本机的 `~/.config/autostart/org.fcitx.Fcitx5.desktop` 设置了 `Hidden=true`，
所以需要由 niri 显式启动 Fcitx5。

在默认配置已有的 `binds {}` 中修改按键。不要添加第二个 `binds {}`：

```kdl
Mod+T { spawn "ghostty"; }

Mod+Space { spawn "noctalia" "msg" "panel-toggle" "launcher"; }
Mod+S { spawn "noctalia" "msg" "panel-toggle" "control-center"; }

// 替换默认的 Mod+Comma consume-window-into-column
Mod+Comma { spawn "noctalia" "msg" "settings-toggle"; }

// niri 25.11+ 已提供原生 recent-windows；不要在 binds 中覆盖 Alt+Tab。

Super+Alt+L {
    spawn "noctalia" "msg" "session" "lock";
}

XF86AudioRaiseVolume allow-when-locked=true {
    spawn "noctalia" "msg" "volume-up";
}
XF86AudioLowerVolume allow-when-locked=true {
    spawn "noctalia" "msg" "volume-down";
}
XF86AudioMute allow-when-locked=true {
    spawn "noctalia" "msg" "volume-mute";
}
XF86AudioMicMute allow-when-locked=true {
    spawn "noctalia" "msg" "mic-mute";
}
XF86MonBrightnessUp allow-when-locked=true {
    spawn "noctalia" "msg" "brightness-up";
}
XF86MonBrightnessDown allow-when-locked=true {
    spawn "noctalia" "msg" "brightness-down";
}
```

默认配置中原有的 Alacritty、Fuzzel、Swaylock、音量和亮度绑定应删除或替换，
否则会保留无效命令或重复按键。

在顶层加入 Noctalia 推荐的窗口规则：

```kdl
window-rule {
    geometry-corner-radius 20
    clip-to-geometry true
}

window-rule {
    match app-id="dev.noctalia.Noctalia"
    open-floating true
    default-column-width { fixed 1080; }
    default-window-height { fixed 920; }
}

debug {
    honor-xdg-activation-with-invalid-serial
}
```

验证配置语法：

```bash
niri validate
```

niri 不会导入 KDE 的显示器布局。第一次进入 niri 后运行：

```bash
niri msg outputs
```

再根据实际输出名称配置 `output "eDP-1" { ... }`、缩放、刷新率和外接显示器
位置。

参考：[Noctalia 的 niri 配置](https://docs.noctalia.dev/noctalia/compositor-settings/niri/)

## 4. 配置 Noctalia 的授权和空闲行为

创建或编辑 `~/.config/noctalia/config.toml`：

```bash
mkdir -p ~/.config/noctalia
${EDITOR:-nvim} ~/.config/noctalia/config.toml
```

Noctalia 默认不启用自己的 Polkit 授权代理。KDE 的代理通常又只在 KDE 会话中
启动，因此必须在删除 `polkit-kde-agent` 前显式启用 Noctalia 代理：

```toml
[shell]
polkit_agent = true
```

Noctalia 默认提供的空闲锁定和关屏行为处于关闭状态。移除 PowerDevil 前，至少
配置锁定、关屏和锁定后挂起：

```toml
[idle]
behavior_order = ["lock", "screen-off", "suspend"]
pre_action_fade_seconds = 2.0

[idle.behavior.lock]
timeout = 300
action = "lock"
enabled = true

[idle.behavior.screen-off]
timeout = 360
action = "screen_off"
enabled = true

[idle.behavior.suspend]
timeout = 1800
action = "lock_and_suspend"
enabled = true
```

这些时间分别是 5 分钟、6 分钟和 30 分钟。锁屏与熄屏保留一分钟间隔，避免两项同时触发。此时先验证配置：

```bash
noctalia config validate
```

继续完成第 5、6 节并首次进入 niri。下面的重启和测试命令必须在 niri 会话中
运行，不要在 Plasma 会话中启动第二套桌面壳：

```bash
pkill -x noctalia
noctalia --daemon
```

确认 KDE 授权代理没有在 niri 会话中运行，再测试 Noctalia 代理：

```bash
pgrep -af polkit-kde
pkexec true
```

第一条命令应没有输出；第二条命令应显示 Noctalia 的密码窗口并在验证成功后
退出。若没有授权窗口，立即停止第 10 节的全部删除操作；不能只从删除命令中去掉
`polkit-kde-agent`，因为它当前是 `plasma-desktop` 的依赖，仍会被 `pacman -Rns`
递归清理。

优先修复 Noctalia 代理。如果必须暂时使用 KDE Polkit 代理作为后备，应在仍保留
Plasma 时完成以下操作：

1. 在 Noctalia 配置中把 `[shell] polkit_agent` 改回 `false`，避免同时运行两个代理。
2. 把 KDE 代理改成显式安装：

   ```bash
   sudo pacman -D --asexplicit polkit-kde-agent
   pacman -Qqe | rg '^polkit-kde-agent$'
   ```

3. 在 niri 配置顶层加入：

   ```kdl
   spawn-at-startup "/usr/lib/polkit-kde-authentication-agent-1"
   ```

4. 重新登录 niri，然后验证代理进程和授权窗口：

   ```bash
   pgrep -af polkit-kde-authentication-agent-1
   pkexec true
   ```

只有代理进程存在并且 `pkexec true` 成功后，才能继续第 10 节，并从删除目标中去掉
`polkit-kde-agent`。这只是后备方案，后续仍应修复并切回 Noctalia 代理。

删除 PowerDevil 前还应在 niri 会话中实际测试空闲行为。可以暂时把三个超时
时间改为 10、20 和 40 秒，然后：

1. 保持无输入约 25 秒，确认会话先锁定、显示器随后关闭。
2. 移动鼠标或按键，确认显示器恢复后仍停留在锁屏界面。
3. 解锁后再次保持无输入超过 40 秒，确认系统挂起，唤醒后回到锁屏界面。
4. 测试完成后恢复正式的超时时间，再运行 `noctalia config validate`。

任一空闲测试失败时都要停止第 10 节的全部删除操作。`powerdevil` 硬依赖
`plasma-workspace`，不能在删除 Plasma Workspace 后单独保留；必须先修复 Noctalia
的锁屏、关屏和挂起行为并重新测试。

如果安装了 `ddcutil`，在同一个配置文件中加入：

```toml
[brightness]
enable_ddcutil = true

[brightness.monitor.HDMI-A-1]
backend = "ddcutil"
```

运行 `ddcutil detect`，并用 Noctalia 控制中心或亮度键确认外接显示器可以调整。
`enable_ddcutil` 只启用 DDC/CI 探测，不会强制所有显示器都使用它。本机的
外屏接口是 `HDMI-A-1`，显式设置 `backend = "ddcutil"` 可避免登录初期一次
DDC 探测失败后该显示器被判定为不可用。如果以后改用其他接口，这个表名
也必须改为 `niri msg outputs` 显示的新接口名。

参考：

- [Noctalia 默认配置](https://github.com/noctalia-dev/noctalia/blob/main/example.toml)
- [Noctalia 空闲行为](https://docs.noctalia.dev/noctalia/services/idle/)
- [Noctalia 亮度配置](https://docs.noctalia.dev/noctalia/services/brightness/)
- [Arch Linux 的 polkit-kde-agent 包信息](https://archlinux.org/packages/extra/x86_64/polkit-kde-agent/)
- [Arch Linux 的 PowerDevil 包信息](https://archlinux.org/packages/extra/x86_64/powerdevil/)

## 5. 配置 GTK portal

安装 niri 后，复制它附带的 portal 配置：

```bash
mkdir -p ~/.config/xdg-desktop-portal

cp /usr/share/xdg-desktop-portal/niri-portals.conf \
  ~/.config/xdg-desktop-portal/niri-portals.conf
```

在 `[preferred]` 中补充 GTK 文件选择器：

```ini
[preferred]
default=gnome;gtk;
org.freedesktop.impl.portal.Access=gtk;
org.freedesktop.impl.portal.FileChooser=gtk;
org.freedesktop.impl.portal.Notification=gtk;
org.freedesktop.impl.portal.Secret=gnome-keyring;
```

GNOME portal 仍排在默认项前面，以便屏幕共享工作；文件选择器明确交给 GTK。
不要全局设置 `GDK_BACKEND`，否则可能破坏屏幕共享 portal。

## 6. 第一次登录 niri

退出 Plasma，在 SDDM 的会话菜单中选择 `Niri`。Arch 的 niri 包已经安装
`/usr/share/wayland-sessions/niri.desktop`，SDDM 会通过 `niri-session` 启动
完整的 systemd 图形会话。

进入后检查：

```bash
printf '%s\n' "$XDG_CURRENT_DESKTOP" "$XDG_SESSION_TYPE"
niri msg outputs
noctalia msg status
pgrep -a fcitx5
echo "$DISPLAY"

systemctl --user --failed
journalctl --user -b -u niri --no-pager
```

期望结果：

- `XDG_CURRENT_DESKTOP` 包含 `niri`
- `XDG_SESSION_TYPE` 是 `wayland`
- Noctalia 能返回状态
- Fcitx5 正在运行
- `DISPLAY` 有值

niri 26.04 会按需自动启动 `xwayland-satellite`，不要手动设置 `DISPLAY`，也
不要重复启动它。

如果 `~/.config/environment.d/` 中全局设置了 `GTK_IM_MODULE=fcitx`，将这一行
删除：

```ini
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
SDL_IM_MODULE=fcitx
```

仅修改文件可能不够。如果旧会话仍有进程未退出，systemd 用户管理器
会保留旧变量。在退出当前会话前运行：

```bash
systemctl --user unset-environment GTK_IM_MODULE
systemctl --user daemon-reload
systemctl --user show-environment | grep '^GTK_IM_MODULE='
```

最后一条应该没有输出，且退出状态是 1。然后退出并重新登录 niri。

niri 支持 Wayland 输入法协议，原生 Wayland GTK 程序可以通过组合器连接
Fcitx5。全局强制 GTK Fcitx 模块时，候选窗口会由应用内的 GTK 模块
绘制；Chromium/Electron 程序通常由 Fcitx5 服务端绘制，两者外观可能
不一致。本机已用 Ghostty 验证，取消该变量后中文输入和候选窗口
正常。

如果个别旧 GTK X11/Xwayland 程序因此无法输入，只对它单独启动
Fcitx GTK 模块：

```bash
env GTK_IM_MODULE=fcitx <program>
```

不要为了单个 X11 程序恢复全局 `GTK_IM_MODULE`。

参考：

- [ArchWiki：Niri](https://wiki.archlinux.org/title/Niri)
- [niri 的 Xwayland 说明](https://github.com/niri-wm/niri/wiki/Xwayland)
- [Fcitx5 维护者对 Wayland 客户端候选窗口的说明](https://github.com/fcitx/fcitx5/discussions/808)

## 7. 设置 GTK 主题

运行：

```bash
nwg-look
```

建议设置：

- GTK3 主题：`adw-gtk3`
- 图标：`Papirus` 或 `Papirus-Dark`
- 光标：`Adwaita`
- 取消 nwg-look 的 GTK4 主题接管

打开 Noctalia 设置：

```bash
noctalia msg settings-toggle
```

进入 `Templates`，启用 GTK 3 和 GTK 4。Noctalia 会生成 GTK CSS，并同步
明暗模式。nwg-look 的 GTK4 选项必须关闭，否则可能覆盖 Noctalia 生成的 GTK4
配色。

如果旧的 KDE GTK 设置仍然存在，检查并删除
`~/.config/gtk-3.0/settings.ini` 中的这一项：

```ini
gtk-modules=colorreload-gtk-module:window-decorations-gtk-module
```

这是 `kde-gtk-config` 写入的 KDE 模块设置。

参考：[Noctalia 的 GTK 主题说明](https://docs.noctalia.dev/noctalia/templates/official/gtk-qt/)

## 8. NVIDIA 检查

本机的 `nvidia-utils 610` 已高于 560，Arch 默认启用 DRM KMS，不需要预先修改
systemd-boot 参数。仍应验证：

```bash
sudo cat /sys/module/nvidia_drm/parameters/modeset
```

输出必须是 `Y`。

参考：[ArchWiki：NVIDIA DRM KMS](https://wiki.archlinux.org/title/NVIDIA#DRM_kernel_mode_setting)

niri 上游建议为 NVIDIA 配置显存回收规则。创建目录和文件：

```bash
sudo install -d /etc/nvidia/nvidia-application-profiles-rc.d
sudoedit /etc/nvidia/nvidia-application-profiles-rc.d/50-niri-vram.json
```

写入：

```json
{
  "rules": [
    {
      "pattern": {
        "feature": "procname",
        "matches": "niri"
      },
      "profile": "Limit Free Buffer Pool On Wayland Compositors"
    }
  ],
  "profiles": [
    {
      "name": "Limit Free Buffer Pool On Wayland Compositors",
      "settings": [
        {
          "key": "GLVidHeapReuseRatio",
          "value": 0
        }
      ]
    }
  ]
}
```

重新登录 niri 后生效。

参考：[niri 的 NVIDIA 说明](https://github.com/niri-wm/niri/wiki/Nvidia)

## 9. 删除 KDE 前的检查

至少连续使用几天，并逐项确认：

- GTK、Electron 和 Xwayland 程序均可输入中文
- Wi-Fi、蓝牙、音量键和亮度键正常
- 手动锁屏和空闲锁定均正常
- 空闲关屏后，输入设备能唤醒显示器并保持锁定
- 空闲挂起和唤醒后锁屏正常；合盖行为符合已选策略
- `pkexec true` 能显示 Noctalia 的授权窗口
- 如果使用 DDC/CI，外接显示器亮度控制正常
- Nautilus 和浏览器能打开文件选择器
- OBS、浏览器或 Discord 能选择窗口并共享画面
- Steam 和其他 X11 程序可以运行
- GNOME Keyring 登录后自动解锁

本机选择的合盖策略是：连接外屏时继续运行，未连接外屏时合盖挂起。
这与 systemd-logind 的默认值一致：

```ini
HandleLidSwitch=suspend
HandleLidSwitchExternalPower=suspend
HandleLidSwitchDocked=ignore
```

因此不需要创建 `/etc/systemd/logind.conf.d/` 覆盖。在当前外接显示器连接、
内屏关闭的状态下实际合盖，确认外屏继续显示且系统没有挂起；
再打开上盖，确认输入、音频和网络仍正常。

如果以后改为“接外屏也合盖挂起”，再在 logind drop-in 中显式设置
`HandleLidSwitchDocked=suspend`，重启后重新测试。

本机的 SDDM PAM 文件已经包含 `pam_gnome_keyring.so`，安装 `gnome-keyring`
后通常无需手工修改。

参考：[ArchWiki：GNOME Keyring](https://wiki.archlinux.org/title/GNOME/Keyring)

## 10. 确认稳定后移除 Plasma

删除前分别保存官方仓库和 AUR/本地来源的显式安装包列表。这两个文件不会被
后续的 `dot_pkglist/help.sh` 覆盖：

```bash
pacman -Qqen > \
  ~/.local/share/chezmoi/dot_pkglist/pacman-official-before-plasma-removal.txt
pacman -Qqem > \
  ~/.local/share/chezmoi/dot_pkglist/aur-local-before-plasma-removal.txt
```

如果需要恢复 Plasma，可先重新安装核心桌面：

```bash
sudo pacman -S --needed \
  plasma-desktop plasma-workspace plasma-x11-session \
  eos-settings-plasma eos-breeze-sddm \
  plasma-nm plasma-pa powerdevil \
  xdg-desktop-portal-kde polkit-kde-agent sddm
sudo systemctl enable sddm.service
```

也可以根据删除前的官方仓库包清单补回其他软件：

```bash
sudo pacman -S --needed - < \
  ~/.local/share/chezmoi/dot_pkglist/pacman-official-before-plasma-removal.txt
```

`aur-local-before-plasma-removal.txt` 仅作为 AUR 和本地包的恢复参考；这些包不能
直接交给 `pacman -S` 从官方仓库安装，应逐项用 `yay` 或原来的构建方式恢复。

### 保留并验证 SDDM

本机的 `sddm` 当前被标记为“作为依赖安装”。先把它改成显式安装，并立即验证。
第一条命令失败、第二条命令没有输出，或安装原因仍不是显式安装时，都不要执行
删除 Plasma 的命令：

```bash
sudo pacman -D --asexplicit sddm
pacman -Qqe | rg '^sddm$'
pacman -Qi sddm | rg '^Install Reason'
```

第二条命令必须输出 `sddm`，`Install Reason` 必须显示为显式安装。

本机的 `/etc/sddm.conf.d/10-endeavouros.conf` 和
`/etc/sddm.conf.d/kde_settings.conf` 分别指定了 `eos-breeze` 和 `breeze`。
删除 `plasma-desktop` 后，`breeze` 主题会随之消失。使用优先级最高的
`/etc/sddm.conf` 覆盖这些 KDE 主题设置；编辑文件时保留其中已有的其他配置：

```bash
sudoedit /etc/sddm.conf
```

加入或修改为：

```ini
[General]
InputMethod=

[Theme]
Current=
```

空的 `InputMethod` 会覆盖
`/etc/sddm.conf.d/10-endeavouros.conf` 中的 `qtvirtualkeyboard`，避免
`qt6-virtualkeyboard` 随 Plasma 被删除后留下失效的输入法配置。若确实需要 SDDM
屏幕键盘，则保留 `InputMethod=qtvirtualkeyboard`，并在删除 Plasma 前将其依赖改为
显式安装并验证：

```bash
sudo pacman -D --asexplicit qt6-virtualkeyboard
pacman -Qqe | rg '^qt6-virtualkeyboard$'
```

空的 `Current` 会让 SDDM 使用内置主题。也可以将它设为 SDDM 包自身提供的
`maya`、`elarun` 或 `maldives`，但不要继续引用 `breeze` 或 `eos-breeze`。

保存工作并退出图形会话，进入 TTY 后重启 SDDM：

```bash
sudo systemctl restart sddm
```

确认登录界面没有主题加载错误，并能进入 niri。只有这项测试通过后，才删除
`plasma-desktop` 和 `eos-breeze-sddm`。

参考：[SDDM 配置说明](https://man.archlinux.org/man/sddm.conf.5)、
[Arch Linux 的 qt6-virtualkeyboard 包信息](https://archlinux.org/packages/extra/x86_64/qt6-virtualkeyboard/)

### 备份并迁移 KWallet 凭据

本机已经有 `~/.local/share/kwalletd/kdewallet.kwl`。GNOME Keyring 不会自动导入
这个钱包；删除 `kwallet-pam` 后，它也不会再随登录密码自动解锁。先复制整个钱包
目录，不要只复制 `.kwl` 文件：

```bash
kwallet_backup_dir="$HOME/.local/share/kwalletd-backup-$(date +%Y%m%d-%H%M%S)"
install -d -m700 "$kwallet_backup_dir"
cp -a ~/.local/share/kwalletd/. "$kwallet_backup_dir/"
chmod -R go-rwx "$kwallet_backup_dir"
test -s "$kwallet_backup_dir/kdewallet.kwl"
printf 'KWallet backup: %s\n' "$kwallet_backup_dir"
```

该目录包含密码数据，不能加入 chezmoi、Git、普通云盘或其他未加密备份。

如果尚未安装管理工具，先安装并在仍能自动解锁 KWallet 的 Plasma 会话中启动：

```bash
sudo pacman -S --needed kwalletmanager
kwalletmanager5
```

Arch 的包名是 `kwalletmanager`，但当前可执行文件名是
`kwalletmanager5`；也可以在应用启动器中搜索 `KWalletManager`。

在 KWallet Manager 中打开 `kdewallet`，检查所有文件夹和条目，并使用
“File → Export as encrypted”把加密导出文件保存到受保护的位置。这个导出文件只
用于恢复到 KWallet，不能导入 GNOME Keyring。不要使用 XML 导出，除非文件保存
在加密介质中并能在迁移后立即安全删除；XML 中的密码是明文。

随后逐项处理仍需使用的凭据：

1. 记录条目所属的应用和账号，不要把密码写进普通文本文件。
2. 在 niri 中让对应应用使用 Secret Service/libsecret，重新输入原密码并选择保存。
3. 完全退出应用后重新打开，确认它能从 GNOME Keyring 取回密码。
4. 至少选择一个原来保存在 KWallet 中的实际账号，重新登录 niri 后再次打开应用，
   确认无需打开 KWallet 或重新输入密码即可登录。仅检查 D-Bus 服务存在不算通过。

如果应用没有导入或切换密码后端的功能，可在 KWallet Manager 中显示原条目，
再把它手工保存到新密码库。`kwallet-query -f '<文件夹>' -r '<条目>' kdewallet`
也能读取密码，但会把明文输出到终端；不要把输出重定向到文件、终端日志或聊天中。

参考：[KWallet 手册](https://docs.kde.org/stable_kf6/en/kwalletmanager/kwalletmanager/kwalletmanager.pdf)、
[ArchWiki：KDE Wallet](https://wiki.archlinux.org/title/KDE_Wallet)

### 移除 KDE 桌面组件

执行删除前最后检查一次 SDDM 仍是显式安装。没有输出时立即停止：

```bash
pacman -Qqe | rg '^sddm$'
```

再移除 KDE 桌面组件：

> 只有在授权和空闲行为测试全部通过后，才能执行下面的删除操作。任一测试失败，
> 都要保留 Plasma 并停止本节。`powerdevil` 不能脱离 `plasma-workspace` 保留。
> 如果已经按第 4 节配置并验证 KDE Polkit 后备代理，只从删除目标中去掉
> `polkit-kde-agent`；不要改动 `powerdevil` 和 `plasma-workspace`。

```bash
sudo pacman -Rns \
  plasma-desktop plasma-workspace plasma-x11-session \
  kdeplasma-addons eos-settings-plasma eos-breeze-sddm \
  plasma-browser-integration plasma-disks plasma-keyboard \
  plasma-nm plasma-pa plasma-systemmonitor \
  bluedevil powerdevil print-manager kinfocenter kscreen kgamma \
  kde-gtk-config sddm-kcm polkit-kde-agent \
  xdg-desktop-portal-kde
```

上面是“保留 KDE 应用”时的基本事务。本机已确认 KWallet 中没有条目，
并选择了完全删除 KWallet 和依赖它的 KDE 应用，因此应使用下面的
合并事务，不要再重复执行上面的基本事务：

```bash
sudo pacman -Rns \
  plasma-desktop plasma-workspace plasma-x11-session \
  kdeplasma-addons eos-settings-plasma eos-breeze-sddm \
  plasma-browser-integration plasma-disks plasma-keyboard \
  plasma-nm plasma-pa plasma-systemmonitor \
  bluedevil powerdevil print-manager kinfocenter kscreen kgamma \
  kde-gtk-config sddm-kcm polkit-kde-agent \
  xdg-desktop-portal-kde \
  ark dolphin dolphin-plugins ffmpegthumbs gwenview kate \
  kde-cli-tools kdegraphics-thumbnailers kdenetwork-filesharing \
  kio-admin kio-extras kio-fuse konsole okular partitionmanager \
  spectacle kcalc kwalletmanager kwallet-pam kwallet
```

本机在执行前用 `pacman -Rs --print` 预演该事务。`--print` 不能与
`--nosave` (`-n`) 同时使用，所以预演时只用 `-Rs`；这不会改变
实际 `-Rns` 事务的包依赖集合。

执行前阅读 pacman 给出的完整删除列表。如果其中出现以下包，应取消操作并检查
依赖关系：

```text
niri
noctalia
xwayland-satellite
networkmanager
bluez
pipewire
wireplumber
gnome-keyring
ddcutil
sddm
```

删除完成后还要测试删除后的实际环境。保存工作并退出 niri，进入 TTY 后重新启动
SDDM：

```bash
sudo systemctl restart sddm
sudo journalctl -b -u sddm --no-pager | tail -n 100
```

确认 SDDM 使用内置主题正常显示、日志中没有 `qtvirtualkeyboard` 插件加载错误，
并能重新登录 niri。删除前的测试不能替代这一步，因为当时 Breeze 和
`qt6-virtualkeyboard` 仍然存在。

KWallet 的包处理必须在完成上面的备份、加密导出、逐项迁移和实际密码测试后，
从下面两个方案中选择一个。

### 保留 KDE 应用

Dolphin、Ark、Gwenview、Okular 和其他使用 KIO 的程序会通过硬依赖保留
`kwallet`。这种情况下只删除 PAM 集成，不要删除 `kwallet` 包。确认旧钱包的主密码
可用并且凭据迁移已完成后再执行：

```bash
sudo pacman -R kwallet-pam
```

重新登录 niri 后确认 Secret Service 实际由 GNOME Keyring 提供：

```bash
busctl --user status org.freedesktop.secrets
```

输出中的进程应是 `gnome-keyring-daemon`，而不是 KDE 的 `ksecretd`。确认浏览器、
Noctalia 加密剪贴板和其他密码存储工作正常，并再次完成上一节的实际账号测试。
如果旧凭据遗漏，立即重新安装 `kwallet-pam`，重新登录后从原钱包或加密导出中恢复：

```bash
sudo pacman -S kwallet-pam
```

验证通过后，保留 `kwallet` 库不会影响使用 GNOME Keyring。

### 完全删除 KWallet

先查看所有反向依赖：

```bash
pactree -r kwallet
```

替换并删除所有依赖 `kwallet` 的 KDE 应用与 KIO 组件。只有当上面的输出不再
包含仍需保留的软件、全部凭据已经迁移且实际账号测试通过，而且 pacman 的事务
检查允许时，才删除：

```bash
sudo pacman -Rns kwallet kwallet-pam
```

如果希望把常用 KDE 应用替换为 GTK，可以按需安装：

```bash
sudo pacman -S \
  nautilus file-roller loupe papers gnome-text-editor \
  gnome-calculator gnome-system-monitor \
  gparted xorg-xhost gnome-disk-utility system-config-printer \
  ffmpegthumbnailer gvfs-smb gvfs-mtp
```

`xorg-xhost` 是 GParted 在 Wayland 会话下启动 root 图形窗口所需的可选依赖。
缺少它时，Polkit 授权可以成功，但 GParted 无法连接 Xwayland，窗口不会出现。

不要为了“纯 GTK”手工删除所有 Qt 库。让 pacman 根据仍在使用的应用和依赖关系
处理它们。

## 11. Noctalia Greeter

迁移完成后使用 greetd 启动 Noctalia Greeter。它自带 wlroots 登录界面合成器，
不需要 Cage。`/etc/greetd/config.toml` 的有效配置是：

```toml
[terminal]
vt = 1

[default_session]
command = "/usr/bin/noctalia-greeter-session"
user = "greeter"
```

`/etc/pam.d/greetd` 保留 GNOME Keyring 的认证、改密和会话自动启动项；登录
密码与 `Login` keyring 密码相同时会自动解锁。管理员配置只固定默认会话和
5 分钟无操作关屏：

```toml
[session]
default = "Niri"

[idle]
timeout = 300
```

在 Noctalia 的“设置 → 安全 → Noctalia Greeter”中执行同步，可把壁纸、配色、
字体和多显示器布局写入 `/var/lib/noctalia-greeter/sync.toml`，不会被上述配置
覆盖。

参考：[Noctalia Greeter 安装说明](https://docs.noctalia.dev/greeter/)、
[Noctalia Greeter 上游仓库](https://github.com/noctalia-dev/noctalia-greeter)、
[ArchWiki：greetd](https://wiki.archlinux.org/title/Greetd)

## 12. 纳入 chezmoi

确认配置正常后：

```bash
chezmoi add ~/.config/niri/config.kdl
chezmoi add ~/.config/xdg-desktop-portal/niri-portals.conf
chezmoi add ~/.config/environment.d/im.conf
```

Noctalia 建议只管理手写配置或导出的合并用户配置：

```bash
mkdir -p ~/.config/noctalia

noctalia_export="$(mktemp --tmpdir noctalia-config.XXXXXX.toml)"
noctalia config export > "$noctalia_export" &&
  noctalia config validate "$noctalia_export" &&
  install -Dm600 "$noctalia_export" ~/.config/noctalia/config.toml
rm -f -- "$noctalia_export"

noctalia config validate
chezmoi add ~/.config/noctalia/config.toml
```

导出必须先写入独立临时文件。直接重定向到正在读取的 `config.toml` 会在
`noctalia config export` 启动前清空原文件；导出或验证失败时会丢失原配置。
上面的命令只有在导出和临时文件验证都成功后才替换正式配置。

不要把 `~/.local/state/noctalia/` 纳入 chezmoi；该目录保存 Noctalia 写入的运行
状态和图形设置覆盖项。

参考：[Noctalia 配置文件说明](https://docs.noctalia.dev/noctalia/configuration/)
