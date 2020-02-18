#!/bin/sh

managed=(bash zsh git shrc tmux nvim vim)

plug_vim_url=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim_plugfile=$HOME/.local/share/nvim/site/autoload/plug.vim

command -v stow >/dev/null 2>&1 || { echo >&2 "Install stow to continue"; exit 1; }

for element in ${managed[@]}; do
    stow -t $HOME ${element}
    if [[ ${element} == nvim && ! -f ${nvim_plugfile} ]]; then
        curl -sfLo ${nvim_plugfile} --create-dirs ${plug_vim_url}
    fi
done
unset element
unset plug_vim_url
unset nvim_plugfile
