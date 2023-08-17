SHELL=/bin/zsh

XDG_CONFIG_HOME:=${HOME}/.config
XDG_CACHE_HOME:=${HOME}/.cache
XDG_DATA_HOME:=${HOME}/.local/share
XDG_STATE_HOME:=${HOME}/.local/state

.PHONY: all alacritty brew emacs git starship tmux zsh xdg_base_dirs
.DEFAULT_GOAL := all

all: alacritty brew emacs git starship tmux zsh xdg_base_dirs

brew:
	command -v brew > /dev/null 2>&1 || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	HOMEBREW_CASK_OPTS="--appdir=/Applications --fontdir=${HOME}/Library/Fonts" brew bundle --file ${PWD}/Brewfile

alacritty:
	mkdir -p ${XDG_CONFIG_HOME}/alacritty
	ln -sf ${PWD}/.config/alacritty/alacritty.yml ${XDG_CONFIG_HOME}/alacritty/alacritty.yml

emacs:
	mkdir -p ${XDG_CONFIG_HOME}/emacs
	ln -sf ${PWD}/.config/emacs/init.el ${XDG_CONFIG_HOME}/emacs/init.el
	ln -sf ${PWD}/.config/emacs/custom.el ${XDG_CONFIG_HOME}/emacs/custom.el
	mkdir -p ${XDG_CONFIG_HOME}/emacs/inits
	ln -sf ${PWD}/.config/emacs/inits/*.el ${XDG_CONFIG_HOME}/emacs/inits/
	mkdir -p ${XDG_CONFIG_HOME}/emacs/themes
	ln -sf ${PWD}/.config/emacs/themes/wilmersdorf-theme.el ${XDG_CONFIG_HOME}/emacs/themes/wilmersdorf-theme.el
	emacs --batch -l ${XDG_CONFIG_HOME}/emacs/init.el -l install-packages.el

git:
	mkdir -p ${XDG_CONFIG_HOME}/git
	ln -sf ${PWD}/.config/git/config ${XDG_CONFIG_HOME}/git/config
	touch ${XDG_CONFIG_HOME}/git/config.local
	ln -sf ${PWD}/.config/git/ignore ${XDG_CONFIG_HOME}/git/ignore

starship:
	mkdir -p ${XDG_CONFIG_HOME}/starship
	ln -sf ${PWD}/.config/starship/starship.toml ${XDG_CONFIG_HOME}/starship/starship.toml

tmux:
	mkdir -p ${XDG_CONFIG_HOME}/tmux
	ln -sf ${PWD}/.config/tmux/tmux.conf ${XDG_CONFIG_HOME}/tmux/tmux.conf

zsh: xdg_base_dirs
	ln -sf ${PWD}/.zshenv ${HOME}/.zshenv
	mkdir -p $${ZDOTDIR}
	ln -sf ${PWD}/.config/zsh/.zshenv $${ZDOTDIR}/.zshenv
	if ! [ -e $${ZDOTDIR}/.zshenv.local ]; then cp ${PWD}/.config/zsh/.zshenv.local $${ZDOTDIR}/.zshenv.local; fi
	ln -sf ${PWD}/.config/zsh/.zprofile $${ZDOTDIR}/.zprofile
	if ! [ -e $${ZDOTDIR}/.zprofile.local ]; then cp ${PWD}/.config/zsh/.zprofile.local $${ZDOTDIR}/.zprofile.local; fi
	ln -sf ${PWD}/.config/zsh/.zshrc $${ZDOTDIR}/.zshrc
	if ! [ -e $${ZDOTDIR}/.zshrc.local ]; then cp ${PWD}/.config/zsh/.zshrc.local $${ZDOTDIR}/.zshrc.local; fi
	ln -sfn ${PWD}/.config/zsh/.zshenv.d $${ZDOTDIR}/.zshenv.d

xdg_base_dirs:
	mkdir -p ${XDG_CONFIG_HOME} ${XDG_DATA_HOME}
	mkdir -p ${XDG_CACHE_HOME} && cd $${_} && mkdir -p zsh starship
	mkdir -p ${XDG_STATE_HOME} && cd $${_} && mkdir -p zsh less
