SHELL = /bin/zsh

XDG_CONFIG_HOME := ${HOME}/.config
XDG_CACHE_HOME := ${HOME}/.cache
XDG_DATA_HOME := ${HOME}/.local/share
XDG_STATE_HOME := ${HOME}/.local/state

all: brew emacs git iterm2 starship tmux zsh

brew:
	mkdir -pv ${XDG_CONFIG_HOME}/brew
	ln -sfv ${PWD}/.config/brew/Brewfile ${XDG_CONFIG_HOME}/brew/Brewfile
	type brew > /dev/null 2>&1 \
	  	|| /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew update
	brew upgrade
	HOMEBREW_CASK_OPTS="--appdir=/Applications --fontdir=${HOME}/Library/Fonts" HOMEBREW_BUNDLE_FILE="${XDG_CONFIG_HOME}/brew/Brewfile" \
		brew bundle -v
	brew cleanup

emacs:
	mkdir -pv ${XDG_CONFIG_HOME}/emacs
	ln -sfv ${PWD}/.config/emacs/init.el ${XDG_CONFIG_HOME}/emacs/init.el
	ln -sfv ${PWD}/.config/emacs/custom.el ${XDG_CONFIG_HOME}/emacs/custom.el
	mkdir -pv ${XDG_CONFIG_HOME}/emacs/inits
	ln -sfv ${PWD}/.config/emacs/inits/*.el ${XDG_CONFIG_HOME}/emacs/inits/
	mkdir -pv ${XDG_CONFIG_HOME}/emacs/themes
	ln -sfv ${PWD}/.config/emacs/themes/wilmersdorf-theme.el ${XDG_CONFIG_HOME}/emacs/themes/wilmersdorf-theme.el
	if type emacs > /dev/null 2>&1; then \
		emacs --batch -l ${XDG_CONFIG_HOME}/emacs/init.el -l install-packages.el; \
	fi

git:
	mkdir -pv ${XDG_CONFIG_HOME}/git
	ln -sfv ${PWD}/.config/git/config ${XDG_CONFIG_HOME}/git/config
	touch ${XDG_CONFIG_HOME}/git/config.local
	ln -sfv ${PWD}/.config/git/ignore ${XDG_CONFIG_HOME}/git/ignore

iterm2:
	mkdir -pv ${XDG_CONFIG_HOME}/iterm2
	ln -sfv ${PWD}/.config/iterm2/com.googlecode.iterm2.plist ${XDG_CONFIG_HOME}/iterm2/com.googlecode.iterm2.plist

starship:
	mkdir -pv ${XDG_CONFIG_HOME}/starship
	ln -sfv ${PWD}/.config/starship/starship.toml ${XDG_CONFIG_HOME}/starship/starship.toml

tmux:
	mkdir -pv ${XDG_CONFIG_HOME}/tmux
	ln -sfv ${PWD}/.config/tmux/tmux.conf ${XDG_CONFIG_HOME}/tmux/tmux.conf

zsh: xdg_base_dir
	ln -sfv ${PWD}/.zshenv ${HOME}/.zshenv
	mkdir -pv $${ZDOTDIR}
	ln -sfv ${PWD}/.config/zsh/.zshenv $${ZDOTDIR}/.zshenv
	if ! [ -e $${ZDOTDIR}/.zshenv.local ]; then \
		cp -v ${PWD}/.config/zsh/.zshenv.local $${ZDOTDIR}/.zshenv.local; \
	fi
	ln -sfv ${PWD}/.config/zsh/.zprofile $${ZDOTDIR}/.zprofile
	if ! [ -e $${ZDOTDIR}/.zprofile.local ]; then \
		cp -v ${PWD}/.config/zsh/.zprofile.local $${ZDOTDIR}/.zprofile.local; \
	fi
	ln -sfv ${PWD}/.config/zsh/.zshrc $${ZDOTDIR}/.zshrc
	if ! [ -e $${ZDOTDIR}/.zshrc.local ]; then \
		cp -v ${PWD}/.config/zsh/.zshrc.local $${ZDOTDIR}/.zshrc.local; \
	fi
	ln -sfnv ${PWD}/.config/zsh/.zshenv.d $${ZDOTDIR}/.zshenv.d

xdg_base_dir:
	mkdir -pv ${XDG_CONFIG_HOME} ${XDG_DATA_HOME}
	mkdir -pv ${XDG_CACHE_HOME} && cd $${_} && \
		mkdir -pv zsh starship
	mkdir -pv ${XDG_STATE_HOME} && cd $${_} && \
		mkdir -pv zsh less

.PHONY: all brew emacs git iterm2 starship tmux zsh xdg_base_dir
