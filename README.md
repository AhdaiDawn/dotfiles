# dotfiles

由 chezmoi 管理的个人配置。目前同时服务于家用笔记本和公司 PC，两台机器共用
终端、编辑器、niri 与 Noctalia 的主体配置，只在硬件相关位置使用模板分支。

## 设备配置

设备映射集中在 [`.chezmoidata.toml`](.chezmoidata.toml)：

- `ahdai-pc`：家用笔记本，保留 eDP-1 和笔记本专用快捷键；
- `gxy`：公司 PC，双外接显示器；

模板只接受上面显式登记的主机名。新设备必须先在 `.chezmoidata.toml` 中指定
设备类型，避免误用笔记本显示器配置。

主要设备模板：

- `dot_config/niri/outputs.kdl.tmpl`：输出、刷新率、缩放和位置；
- `dot_config/niri/binds.kdl.tmpl`：只在笔记本生成内屏安全切换快捷键；
- `dot_config/noctalia/private_config.toml.tmpl`：UI 缩放、电池和 DDC 显示器；
- `dot_local/bin/executable_niri-output-autoswitch`：家用笔记本连接外屏时关闭
  内屏，断开外屏时恢复内屏；
- `dot_config/niri/switcher.kdl`：多显示器窗口切换策略；动态配色由 Noctalia
  内置 niri 模板单独生成。

## 初始化

先安装基础工具：

```sh
sudo pacman -S --needed \
  chezmoi git git-lfs fish neovim eza fzf zoxide starship direnv \
  git-delta lazygit yazi zellij just pacman-contrib
```

niri、Noctalia 以及仓库中的桌面快捷键和脚本还直接依赖：

```sh
sudo pacman -S --needed \
  niri noctalia xwayland-satellite ghostty fcitx5 nautilus \
  jq xorg-xrdb xdg-user-dirs wl-clipboard satty grim slurp \
  tesseract tesseract-data-chi_sim tesseract-data-eng gpu-screen-recorder \
  xdg-desktop-portal-gnome xdg-desktop-portal-gtk gnome-keyring ddcutil
```

然后应用配置：

```sh
chezmoi init --apply git@github.com:AhdaiDawn/dotfiles.git
chezmoi apply
```

首次切换 Fish 前可先运行 `fish` 测试，再执行：

```sh
chsh -s /usr/bin/fish
```

## 登录管理器

两台 Linux 主机都使用 `greetd + noctalia-greeter` 启动 Niri。所需软件为
`greetd`、`accountsservice` 和 `noctalia-greeter-git`；系统配置位于
`/etc/greetd/config.toml` 和 `/var/lib/noctalia-greeter/`。登录界面的配色、
壁纸和显示器布局由 Noctalia 的“设置 → 安全 → Noctalia Greeter”同步到
`/var/lib/noctalia-greeter/sync.toml`。

切回保留安装的 SDDM：

```sh
sudo systemctl disable greetd.service
sudo systemctl enable sddm.service
```

## 包清单

`dot_pkglist/` 只保存家用笔记本的当前快照，不保留迁移阶段的前后副本：

- `home-laptop-pacman.txt`；
- `home-laptop-aur.txt`。

运行脚本更新这两份清单：

```sh
./dot_pkglist/help.sh
```

## 系统维护

Pacman 缓存默认保留两个版本。首次在一台机器上启用每周清理：

```sh
pacman-cache-prune --enable-timer
```

立即查看清理候选或执行清理：

```sh
pacman-cache-prune --dry-run
pacman-cache-prune --prune
```

后两项不会更改定时器配置；实际删除和首次启用需要 `sudo`。
