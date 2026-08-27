#!/bin/sh
set -eu

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

pacman -Qqen >"$script_dir/pacman.txt"
pacman -Qqm >"$script_dir/aur_local.txt"
