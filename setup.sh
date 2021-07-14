#!/bin/sh

managed=(bash zsh git shrc tmux nvim vim)
install_list=(stow zsh tmux universal-ctags nvim ohmyzsh rust git-delta bat)
plug_vim_url=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim_plugfile=$HOME/.local/share/nvim/site/autoload/plug.vim

function install_deps () {
    source ./install_functions.sh
    for element in ${install_list[@]}; do
        # replace all dashes with underscores
        sanitized_element=$(echo ${element} | tr '-' '_')
        install_${sanitized_element}
    done
}

function main() {
    command -v stow >/dev/null 2>&1 || { echo >&2 "Install stow to continue"; exit 1; }

    for element in ${managed[@]}; do
        stow -t $HOME ${element}
        if [[ ${element} == nvim && ! -f ${nvim_plugfile} ]]; then
            curl -sfLo ${nvim_plugfile} --create-dirs ${plug_vim_url}
        fi
    done
}

install_deps
main

unset element
unset install_list
unset plug_vim_url
unset nvim_plugfile
