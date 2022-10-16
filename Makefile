all: git starship tmux zsh

git:
	mkdir -p ${HOME}/.config/git
	ln -sf ${PWD}/.config/git/config ${HOME}/.config/git/config
	touch ${HOME}/.config/git/config.local
	ln -sf ${PWD}/.config/git/ignore ${HOME}/.config/git/ignore

starship:
	mkdir -p ${HOME}/.config/starship
	ln -sf ${PWD}/.config/starship/starship.toml ${HOME}/.config/starship/starship.toml

tmux:
	mkdir -p ${HOME}/.config/tmux
	ln -sf ${PWD}/.config/tmux/tmux.conf ${HOME}/.config/tmux/tmux.conf

zsh:
	ln -sf ${PWD}/.zshenv ${HOME}/.zshenv
	mkdir -p ${HOME}/.zsh
	ln -sf ${PWD}/.zsh/.zshenv ${HOME}/.zsh/.zshenv
	if ! [ -e ${HOME}/.zsh/.zshenv.local ]; then cp ${PWD}/.zsh/.zshenv.local ${HOME}/.zsh/.zshenv.local; fi
	ln -sf ${PWD}/.zsh/.zprofile ${HOME}/.zsh/.zprofile
	if ! [ -e ${HOME}/.zsh/.zprofile.local ]; then cp ${PWD}/.zsh/.zprofile.local ${HOME}/.zsh/.zprofile.local;	fi
	ln -sf ${PWD}/.zsh/.zshrc ${HOME}/.zsh/.zshrc
	if ! [ -e ${HOME}/.zsh/.zshrc.local ]; then	cp ${PWD}/.zsh/.zshrc.local ${HOME}/.zsh/.zshrc.local; fi
	ln -sfn ${PWD}/.zsh/.zshenv.d ${HOME}/.zsh/.zshenv.d

.PHONY: all git starship tmux zsh
