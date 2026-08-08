# dotfiles

Personal dotfiles managed with `chezmoi`.

## Arch Linux

Install the required packages:

```zsh
sudo pacman -S chezmoi git neovim eza fzf zoxide starship direnv delta lazygit yazi zellij just zsh-autosuggestions zsh-history-substring-search
yay -S zsh-fast-syntax-highlighting zsh-vi-mode
```

## Setup

```zsh
chezmoi init --apply git@github.com:AhdaiDawn/dotfiles.git
chezmoi apply
```

## Package lists

Package snapshots are stored in [`dot_pkglist/`](/home/ahdai/.local/share/chezmoi/dot_pkglist).

Refresh them with:

```zsh
./dot_pkglist/help.sh
```
