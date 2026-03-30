# dotfiles

Personal dotfiles managed with `chezmoi`.

## Linux dependencies

These configs assume the following tools are installed:

- `chezmoi`
- `git`
- `neovim`
- `eza`
- `fzf`
- `zoxide`
- `starship`
- `delta`
- `lazygit`
- `yazi`
- `zellij`
- `zsh-autosuggestions`
- `zsh-syntax-highlighting`

Some configs are optional but will be skipped if missing, such as `ghostty`, `just`, and `fcitx5-rime`.

## Setup

```zsh
# initialize and apply
chezmoi init --apply git@github.com:AhdaiDawn/dotfiles.git

# re-apply after updating the source directory
chezmoi apply
```

## Package lists

Package snapshots are stored in [`dot_pkglist/`](/home/ahdai/.local/share/chezmoi/dot_pkglist).

To refresh them on Arch Linux:

```zsh
./dot_pkglist/help.sh
```

This updates:

- `dot_pkglist/pacman.txt`: explicitly installed repo packages
- `dot_pkglist/aur_local.txt`: explicitly installed AUR packages
