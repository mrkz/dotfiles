#!/bin/sh

managed=(bash git shrc tmux vim)

command -v stow >/dev/null 2>&1 || { echo >&2 "Install stow to continue"; exit 1; }

for element in ${managed[@]}; do
    stow -t $HOME ${element}
done
unset element
