#!/bin/sh
set -eu

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
profile=${1:-$(chezmoi execute-template '{{ if eq .chezmoi.hostname .devices.companyHostname }}company-pc{{ else }}home-laptop{{ end }}')}

case $profile in
    home-laptop|company-pc) ;;
    *)
        printf 'Unknown profile: %s\n' "$profile" >&2
        printf '%s\n' 'Use home-laptop or company-pc.' >&2
        exit 2
        ;;
esac

pacman -Qqen >"$script_dir/$profile-pacman.txt"
pacman -Qqm >"$script_dir/$profile-aur.txt"

printf 'Updated %s package snapshots.\n' "$profile"
