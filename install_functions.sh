#!/bin/sh

function __install_pkg() {
    distro=$(grep ^ID= /usr/lib/os-release | cut -d= -f2)
    PKG_MANAGER=""
    case $distro in
        fedora)
            PKG_MANAGER=dnf;;
        raspbian)
            PKG_MANAGER=apt;;
        ubuntu)
            PKG_MANAGER=apt;;
        *)
            echo >&2 "Error: could not install curl for ${distro}"
            exit 1;;
    esac
    sudo -E ${PKG_MANAGER} install -y "$@"
    unset distro
    unset PKG_MANAGER
}

function __install_cargo_pkg() {
    command -v cargo >/dev/null 2>&1 || { echo >&2 "Install cargo (rust) to continue"; exit 1; }
    cargo install "$@"
}

function install_curl() {
    command -v curl > /dev/null 2>&1 &&  return
    __install_pkg curl
}

function install_stow() {
    command -v stow > /dev/null 2>&1 &&  return
    __install_pkg stow
}

function install_rust_analyzer() {
    # skip install if clangd is installed
    command -v rust-analyzer > /dev/null 2>&1 && return
    command -v rustup >/dev/null 2>&1 || { echo >&2 "Install rustup (rust) to continue"; exit 1; }
    rustup +nightly component add rust-analyzer-preview
    # create a symlink to it to a discoverable directory in $PATH
    ln -s ${HOME}/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rust-analyzer ${HOME}/.cargo/bin/rust-analyzer
}

function install_clangd() {
    # skip install if clangd is installed
    command -v clangd > /dev/null 2>&1 && return
    distro=$(grep ^ID= /usr/lib/os-release | cut -d= -f2)
    pkgname="clang-tools-extra" # pkgname for fedora
    case $distro in
        fedora)
            ;;
        raspbian)
            pkgname=clangd-11
            ;;
        ubuntu)
            pkgname=clangd-11
            ;;
        *)
            echo >&2 "Error: could not install clangd for ${distro}"
            exit 1;;
    esac
    __install_pkg ${pkgname}
    unset pkgname
    unset distro
}

function install_universal_ctags() {
    # skip install if the right ctags is installed
    command -v ctags > /dev/null 2>&1 && ctags --version | grep -qs '^Universal Ctags' && return
    distro=$(grep ^ID= /usr/lib/os-release | cut -d= -f2)
    case $distro in
        fedora)
            sudo -E dnf copr enable jgoguen/universal-ctags;;
        raspbian)
            ;;
        ubuntu)
            ;;
        *)
            echo >&2 "Error: could not install universal-ctags for ${distro}"
            exit 1;;
    esac
    unset distro
    __install_pkg universal-ctags
}

function install_nvim() {
    # skip install if already installed
    command -v nvim > /dev/null 2>&1 &&  return
    distro=$(grep ^ID= /usr/lib/os-release | cut -d= -f2)
    case $distro in
        fedora)
            sudo -E dnf copr enable agriffis/neovim-nightly
            __install_pkg neovim;;
        raspbian)
            echo "Still Unsupported!";;
        ubuntu)
            pkgname=neovim
            ;;
        *)
            echo >&2 "Error: could not install neovim for ${distro}"
            exit 1;;
    esac
    unset distro
}

function install_zsh() {
    # skip install if already installed
    command -v zsh > /dev/null 2>&1 &&  return
    __install_pkg zsh
}

function install_tmux() {
    # skip install if already installed
    command -v tmux > /dev/null 2>&1 &&  return
    __install_pkg tmux
}

function install_bat() {
    # skip install if already installed
    command -v bat > /dev/null 2>&1 &&  return
    __install_cargo_pkg bat
}

function install_git_delta() {
    # skip install if already installed
    command -v delta > /dev/null 2>&1 &&  return
    __install_cargo_pkg git-delta
}

function install_ohmyzsh() {
    # skip clone if already exists
    if [ -d $HOME/git/ohmyzsh ]; then
        return
    fi
    command -v git >/dev/null 2>&1 || { echo >&2 "Install git to continue"; exit 1; }
    mkdir -p $HOME/git &> /dev/null
    git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/git/ohmyzsh
}

function install_rust() {
    # skip install if already installed
    command -v rustc > /dev/null 2>&1 &&  return
    command -v curl >/dev/null 2>&1 || { echo >&2 "Install curl to continue"; exit 1; }
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}
