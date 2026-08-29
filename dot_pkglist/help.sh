#!/bin/sh
set -eu

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

if [ "$#" -ne 0 ]; then
    printf 'Usage: %s\n' "$0" >&2
    exit 2
fi

pacman -Qqen >"$script_dir/home-laptop-pacman.txt"
pacman -Qqm >"$script_dir/home-laptop-aur.txt"

printf '%s\n' 'Updated home-laptop package snapshots.'
