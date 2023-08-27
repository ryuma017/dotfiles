#!/bin/sh

set -u

# fail fast if we're not in a directory that exists
if ! [[ -d "${PWD}" ]]; then
    error "the current working directory does not exist"
fi

# fail fast if HOME is not set
if [[ -z "${HOME:-}" ]]; then
    error "HOME is unset"
fi

DOTFILES_REMOTE_URL="https://github.com/ryuma017/dotfiles"
DOTFILES_HOME="${DOTFILES_HOME:-$HOME/tmp/.dotfiles}"

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

main() {
    # create XDG Base Directory specification directories
    msg "Creating" "XDG Base Directory specification directories" green
    ensure mkdir -p \
        "${XDG_CONFIG_HOME}" \
        "${XDG_CACHE_HOME}"  \
        "${XDG_DATA_HOME}"   \
        "${XDG_STATE_HOME}"

    # install homebrew if it does not exist
    if ! check_cmd brew; then
        msg "Installing" "homebrew" green
        trace ensure install_homebrew
    fi

    # install all the necessary packages
    msg "Installing" "packages via homebrew" green
    trace ensure brew bundle --file="${DOTFILES_HOME}/Brewfile" install

    # clone or update dotfiles
    msg "Fetching" "ryuma017/dotfiles" green
    trace ensure clone_or_update_dotfiles_via_git

    # stow config files
    msg "Stowing" "config files into ${XDG_CONFIG_HOME}" green
    trace ensure stow_all_configs
}

install_homebrew() {
    require_cmd curl
    require_cmd /bin/bash

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
}

clone_or_update_dotfiles_via_git() {
    require_cmd git

    if [ -d "${DOTFILES_HOME}/.git" ]; then
        git -C "${DOTFILES_HOME}" pull --ff-only
    else
        git clone "${DOTFILES_REMOTE_URL}" "${DOTFILES_HOME}"
    fi
}

stow_all_configs() {
    export DOTFILES_HOME XDG_CONFIG_HOME
    make --file "${DOTFILES_HOME}/Makefile" all
}

### utility functions ###

# commands checked by this function may be pre-installed
require_cmd() {
    if ! check_cmd "$1"; then
        error "$1 is required (command not found)"
    fi
}

check_cmd() {
    command -v "$1" > /dev/null 2>&1
}

ensure() {
    if ! "$@"; then
        error "command failed: $*";
    fi
}

trace() {
    local -i st
    "$@" 2>&1 | while read -r line; do
        printf "$(_setaf gray)%s$(_reset)\n" "$line"
    done
    st="${PIPESTATUS[0]}"
    if [ $st -ne 0 ] && [ "$1" = ensure ]; then
        exit 1
    fi
    if [ $st -ne 0 ]; then
        echo "return 1: ${PIPESTATUS[0]}"
        return 1
    fi
}

msg() {
    local status="$1"
    local msg="$2"
    local color="$3"

    printf "$(_setaf "$color")$(_bold)%12s$(_reset) %s\n" "$status" "$msg"
}

error() {
    printf "$(_setaf red)$(_bold)error$(_reset): %s\n" "$1" >&2
    exit 1
}

_reset() {
    tput sgr0 2> /dev/null || printf "" # printf "\x1B[0m"
}

_bold() {
    tput bold 2> /dev/null || printf "" # printf "\x1B[1m"
}

_setaf() {
    case "$1" in
        gray)
            tput setaf 0 2> /dev/null || printf "" # printf "\x1B[30m"
            ;;
        red)
            tput setaf 1 2> /dev/null || printf "" # printf "\x1B[31m"
            ;;
        green)
            tput setaf 2 2> /dev/null || printf "" # printf "\x1B[32m"
            ;;
        *)
            ;;
    esac
}

main "$@" || exit 1
