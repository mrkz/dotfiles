#!/bin/sh

managed=(alacritty bash zsh git shrc tmux nvim vim conky)
install_list=(stow zsh tmux universal-ctags nvim ohmyzsh rust rust-analyzer clangd git-delta bat)
plug_vim_url=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim_plugfile=$HOME/.local/share/nvim/site/autoload/plug.vim

# to update ./dconf/gnome-terminal-profiles.dconf run
# dconf dump /org/gnome/terminal/legacy/profiles:/ > ${HOME}/git/dotfiles/dconf/gnome-terminal-profiles.dconf
function setup_gnome_terminal_colors() {
    command -v dconf >/dev/null 2>&1 || { echo >&2 "missing dconf binary"; exit 1; }
    if [ "${XDG_CURRENT_DESKTOP}x" != "GNOMEx" ]; then
        return
    fi
    dconf load /org/gnome/terminal/legacy/profiles:/ < ./dconf/gnome-terminal-profiles.dconf
}

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
setup_gnome_terminal_colors

unset element
unset install_list
unset plug_vim_url
unset nvim_plugfile
