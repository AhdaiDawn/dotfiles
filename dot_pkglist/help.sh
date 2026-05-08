#!/bin/sh
set -eu

brew leaves | sort >brew.txt
brew list --cask | sort >brew-cask.txt
