#!/bin/sh
set -eu

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

if [ "$#" -ne 0 ]; then
    printf 'Usage: %s\n' "$0" >&2
    exit 2
fi

# This memo belongs to the home-laptop host listed in .chezmoidata.toml.
if [ "$(hostname)" != ahdai-pc ]; then
    printf '%s\n' 'Package snapshots can only be updated on the home laptop (ahdai-pc).' >&2
    exit 1
fi

temp_dir=$(mktemp -d "$script_dir/.pkglist-XXXXXX")
trap 'rm -rf -- "$temp_dir"' 0
trap 'exit 1' HUP INT TERM

# Finish both exports before replacing either memo. Keep temporary files on
# the same filesystem so each replacement is a rename.
pacman -Qqen >"$temp_dir/home-laptop-pacman.txt"
pacman -Qqm >"$temp_dir/home-laptop-aur.txt"

mv -- "$temp_dir/home-laptop-pacman.txt" "$script_dir/home-laptop-pacman.txt"
mv -- "$temp_dir/home-laptop-aur.txt" "$script_dir/home-laptop-aur.txt"

printf '%s\n' 'Updated home-laptop package snapshots.'
