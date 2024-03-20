#!/bin/sh
# shellcheck disable=SC3043

set -u

# Fail fast if HOME is not set.
if [ -z "${HOME:-}" ]; then
    error "HOME is unset"
fi

_reset() {
  tput sgr0 2> /dev/null || printf "" # printf "\x1B[0m"
}

_bold() {
  tput bold 2> /dev/null || printf "" # printf "\x1B[1m"
}

_setaf() {
  tput setaf "$1" 2> /dev/null || printf ""
}

info() {
  printf "$(_setaf 6)$(_bold)%8s$(_reset): %s\n" "info" "$1"
}

error() {
  printf "$(_setaf 1)$(_bold)%8s$(_reset): %s\n" "error" "$1" >&2
  exit 1
}

# commands checked by this function may be pre-installed
requires() {
  if ! cmd_exists "$1"; then
    error "$1 is required (command not found)"
  fi
}

cmd_exists() {
  command -v "$1" > /dev/null 2>&1
}

ensure() {
  if ! "$@"; then
    error "command failed: $*";
  fi
}

export DOTFILES_HOME="${DOTFILES_HOME:-$HOME/.dotfiles}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

requires /bin/bash
requires curl
requires git
requires make

info "creating XDG directories"
ensure mkdir -p \
  "${XDG_CONFIG_HOME}" \
  "${XDG_CACHE_HOME}"  \
  "${XDG_DATA_HOME}"   \
  "${XDG_STATE_HOME}"

if [ ! -d "${DOTFILES_HOME}/.git" ]; then
  info "cloning dotfiles"
  ensure git clone https://github.com/ryuma017/dotfiles "${DOTFILES_HOME}"
else
  info "ryuma017/dotfiles is already exists"
  info "updating dotfiles"
  ensure git -C "${DOTFILES_HOME}" pull --ff-only
fi

for bin in "${DOTFILES_HOME}/bin"/*; do
  if [ -x "$bin" ]; then
    info "symlinking ${bin} to ${HOME}/.local/bin/$(basename "$bin")"
    ensure ln -sf "$bin" "${HOME}/.local/bin/$(basename "$bin")"
  fi
done

# Rust

if [ ! -d "${RUSTUP_HOME:-$HOME/.rustup}" ]; then
  info "installing rustup"
  ensure curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
  info "rustup is already installed"
fi

. "${CARGO_HOME:-$HOME/.cargo}"/env

if ! cmd_exists cargo-binstall; then
  info "installing cargo-binstall"
  ensure curl -L --proto '=https' --tlsv1.2 -sSf \
    https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
else
  info "cargo-binstall is already installed"
fi

while IFS= read -r name; do
  if [ -n "$name" ]; then
    info "installing Rust binary: $name"
    ensure cargo binstall -yq "$name"
  fi
done < "${DOTFILES_HOME}/cargo-install.txt"

# Homebrew

brew_bin="/opt/homebrew/bin/brew"
if [ ! "$(uname -m)" = "arm64" ]; then
  brew_bin="/usr/local/bin/brew"
fi

if [ ! -x "${brew_bin}" ]; then
  info "installing homebrew"
  ensure /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  info "homebrew is already installed"
fi

eval "$(${brew_bin} shellenv)"

info "installing packages via homebrew"
ensure brew bundle --file="${DOTFILES_HOME}/Brewfile" install

# symlinking config files
info "stowing config files into ${XDG_CONFIG_HOME}"
ensure make --file "${DOTFILES_HOME}/Makefile" all

info "all installations are completed successfully"
