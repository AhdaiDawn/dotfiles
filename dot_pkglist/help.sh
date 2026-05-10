#!/bin/sh
set -eu

script_dir=$(CDPATH= cd "$(dirname "$0")" && pwd)

brew leaves | sort >"$script_dir/brew.txt"
brew list --cask | sort >"$script_dir/brew-cask.txt"
