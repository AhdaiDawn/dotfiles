# dotfiles

Personal dotfiles managed with `chezmoi`.

## Arch Linux

Install the required packages:

```sh
sudo pacman -S chezmoi git fish neovim eza fzf zoxide starship direnv delta lazygit yazi zellij just
```

## Setup

```sh
chezmoi init --apply git@github.com:AhdaiDawn/dotfiles.git
chezmoi apply
```

Test fish interactively before making it the login shell:

```sh
fish
chsh -s /usr/bin/fish
```

## Package lists

Package snapshots are stored in [`dot_pkglist/`](/home/ahdai/.local/share/chezmoi/dot_pkglist).

Refresh them with:

```sh
./dot_pkglist/help.sh
```
