SHELL := /bin/zsh

XDG_CONFIG_HOME := ${HOME}/.config
XDG_CACHE_HOME := ${HOME}/.cache
XDG_DATA_HOME := ${HOME}/.local/share
XDG_STATE_HOME := ${HOME}/.local/state

all: zsh git iterm2 starship tmux

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
	echo ${SHELL}

xdg_base_dir:
	mkdir -pv ${XDG_CONFIG_HOME}
	mkdir -pv ${XDG_CACHE_HOME} \
	    mkdir -pv ${XDG_CACHE_HOME}/zsh \
		mkdir -pv ${XDG_CACHE_HOME}/starship
	mkdir -pv ${XDG_DATA_HOME}
	mkdir -pv ${XDG_STATE_HOME}
		mkdir -pv ${XDG_STATE_HOME}/zsh \
		mkdir -pv ${XDG_STATE_HOME}/less

.PHONY: all zsh git iterm2 starship tmux xdg_base_dir
