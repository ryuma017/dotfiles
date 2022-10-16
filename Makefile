all: git iterm2 starship tmux zsh

git:
	mkdir -pv ${HOME}/.config/git
	ln -sfv ${PWD}/.config/git/config ${HOME}/.config/git/config
	touch -v ${HOME}/.config/git/config.local
	ln -sfv ${PWD}/.config/git/ignore ${HOME}/.config/git/ignore

iterm2:
	mkdir -pv ${HOME}/.config/iterm2
	ln -sfv ${PWD}/.config/iterm2/com.googlecode.iterm2.plist ${HOME}/.config/iterm2/com.googlecode.iterm2.plist

starship:
	mkdir -pv ${HOME}/.config/starship
	ln -sfv ${PWD}/.config/starship/starship.toml ${HOME}/.config/starship/starship.toml

tmux:
	mkdir -p ${HOME}/.config/tmux
	ln -sfv ${PWD}/.config/tmux/tmux.conf ${HOME}/.config/tmux/tmux.conf

zsh:
	ln -sfv ${PWD}/.zshenv ${HOME}/.zshenv
	mkdir -pv ${HOME}/.zsh
	ln -sfv ${PWD}/.zsh/.zshenv ${HOME}/.zsh/.zshenv
	if ! [ -e ${HOME}/.zsh/.zshenv.local ]; then cp ${PWD}/.zsh/.zshenv.local ${HOME}/.zsh/.zshenv.local; fi
	ln -sfv ${PWD}/.zsh/.zprofile ${HOME}/.zsh/.zprofile
	if ! [ -e ${HOME}/.zsh/.zprofile.local ]; then cp ${PWD}/.zsh/.zprofile.local ${HOME}/.zsh/.zprofile.local;	fi
	ln -sfv ${PWD}/.zsh/.zshrc ${HOME}/.zsh/.zshrc
	if ! [ -e ${HOME}/.zsh/.zshrc.local ]; then	cp ${PWD}/.zsh/.zshrc.local ${HOME}/.zsh/.zshrc.local; fi
	ln -sfnv ${PWD}/.zsh/.zshenv.d ${HOME}/.zsh/.zshenv.d

.PHONY: all git iterm2 starship tmux zsh
