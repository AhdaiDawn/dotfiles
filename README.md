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
- `dot_config/niri/binds.kdl.tmpl`：只在笔记本生成内屏恢复快捷键；
- `dot_config/noctalia/private_config.toml.tmpl`：UI 缩放、电池和 DDC 显示器；
- `dot_config/niri/switcher.kdl`：多显示器窗口切换策略；动态配色由 Noctalia
  内置 niri 模板单独生成。

家用笔记本的历史迁移过程保存在
[`docs/niri-noctalia-migration.md`](docs/niri-noctalia-migration.md)。

## 初始化

先安装基础工具：

```sh
sudo pacman -S --needed \
  chezmoi git git-lfs fish neovim eza fzf zoxide starship direnv \
  git-delta lazygit yazi zellij just
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

家用笔记本使用 `greetd + noctalia-greeter` 启动 Niri；系统配置位于
`/etc/greetd/config.toml` 和 `/var/lib/noctalia-greeter/`。登录界面的配色、
壁纸和显示器布局由 Noctalia 的“设置 → 安全 → Noctalia Greeter”同步到
`/var/lib/noctalia-greeter/sync.toml`。

## 包清单

`dot_pkglist/` 只保存家用笔记本的当前快照，不保留迁移阶段的前后副本：

- `home-laptop-pacman.txt`；
- `home-laptop-aur.txt`。

运行脚本更新这两份清单：

```sh
./dot_pkglist/help.sh
```
