SHELL=/bin/zsh

all: zsh git iterm2 starship tmux

zsh:
	ln -sfv ${PWD}/.zshenv ${HOME}/.zshenv
	mkdir -pv ${ZDOTDIR}
	ln -sfv ${PWD}/.zsh/.zshenv ${ZDOTDIR}/.zshenv
	if ! [ -e ${ZDOTDIR}/.zshenv.local ]; then cp ${PWD}/.zsh/.zshenv.local ${ZDOTDIR}/.zshenv.local; fi
	ln -sfv ${PWD}/.zsh/.zprofile ${ZDOTDIR}/.zprofile
	if ! [ -e ${ZDOTDIR}/.zprofile.local ]; then cp ${PWD}/.zsh/.zprofile.local ${ZDOTDIR}/.zprofile.local;	fi
	ln -sfv ${PWD}/.zsh/.zshrc ${ZDOTDIR}/.zshrc
	if ! [ -e ${ZDOTDIR}/.zshrc.local ]; then	cp ${PWD}/.zsh/.zshrc.local ${ZDOTDIR}/.zshrc.local; fi
	ln -sfnv ${PWD}/.zsh/.zshenv.d ${ZDOTDIR}/.zshenv.d

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
	mkdir -p ${XDG_CONFIG_HOME}/tmux
	ln -sfv ${PWD}/.config/tmux/tmux.conf ${XDG_CONFIG_HOME}/tmux/tmux.conf

.PHONY: all zsh git iterm2 starship tmux
