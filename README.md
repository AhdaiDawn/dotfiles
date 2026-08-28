# dotfiles

由 chezmoi 管理的个人配置。目前同时服务于家用笔记本和公司 PC，两台机器共用
终端、编辑器、niri 与 Noctalia 的主体配置，只在硬件相关位置使用模板分支。

## 设备配置

设备映射集中在 [`.chezmoidata.toml`](.chezmoidata.toml)：

- `gxy`：公司 PC，双外接显示器；
- 其他主机：家用笔记本配置，保留 eDP-1 和笔记本专用快捷键。

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
sudo pacman -S chezmoi git fish neovim eza fzf zoxide starship direnv delta lazygit yazi zellij just
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

## 包清单

`dot_pkglist/` 只保存每台设备的当前快照，不保留迁移阶段的前后副本：

- `home-laptop-pacman.txt`、`home-laptop-aur.txt`；
- `company-pc-pacman.txt`、`company-pc-aur.txt`。

脚本默认根据当前主机选择设备，也可以显式指定：

```sh
./dot_pkglist/help.sh
./dot_pkglist/help.sh home-laptop
./dot_pkglist/help.sh company-pc
```
