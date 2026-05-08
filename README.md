# dotfiles

Personal dotfiles managed with `chezmoi`.

## macOS

Install Homebrew first, then install the tracked packages:

```zsh
brew install $(sed '/^$/d' dot_pkglist/brew.txt)
brew install --cask $(sed '/^$/d' dot_pkglist/brew-cask.txt)
```

## Setup

```zsh
chezmoi init --apply git@github.com:AhdaiDawn/dotfiles.git
chezmoi apply
```

## Package lists

Package snapshots are stored in `dot_pkglist/`.

Refresh them with:

```zsh
./dot_pkglist/help.sh
```
