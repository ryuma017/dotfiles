XDG_CONFIG_HOME ?= $(HOME)/.config
DOTFILES_HOME ?= $(HOME)/.dotfiles
DOTFILES_CONFIG_HOME := $(DOTFILES_HOME)/.config

.DEFAULT_GOAL := all

.PHONY: alacritty emacs git karabiner starship tmux zsh

alacritty:
	mkdir -p $(XDG_CONFIG_HOME)/alacritty
	ln -sf $(PWD)/.config/alacritty/alacritty.yml $(XDG_CONFIG_HOME)/alacritty/alacritty.yml

emacs:
	mkdir -p $(XDG_CONFIG_HOME)/emacs
	ln -sf $(PWD)/.config/emacs/init.el $(XDG_CONFIG_HOME)/emacs/init.el
	ln -sf $(PWD)/.config/emacs/custom.el $(XDG_CONFIG_HOME)/emacs/custom.el
	mkdir -p $(XDG_CONFIG_HOME)/emacs/inits
	ln -sf $(PWD)/.config/emacs/inits/*.el $(XDG_CONFIG_HOME)/emacs/inits/
	mkdir -p $(XDG_CONFIG_HOME)/emacs/themes
	ln -sf $(PWD)/.config/emacs/themes/wilmersdorf-theme.el $(XDG_CONFIG_HOME)/emacs/themes/wilmersdorf-theme.el

git:
	mkdir -p $(XDG_CONFIG_HOME)/git
	ln -sf $(PWD)/.config/git/config $(XDG_CONFIG_HOME)/git/config
	touch $(XDG_CONFIG_HOME)/git/config.local
	ln -sf $(PWD)/.config/git/ignore $(XDG_CONFIG_HOME)/git/ignore

karabiner:
	mkdir -p $(XDG_CONFIG_HOME)/karabiner
	ln -sf $(PWD)/.config/karabiner/karabiner.json $(XDG_CONFIG_HOME)/karabiner/karabiner.json

starship:
	mkdir -p $(XDG_CONFIG_HOME)/starship
	ln -sf $(PWD)/.config/starship/starship.toml $(XDG_CONFIG_HOME)/starship/starship.toml

tmux:
	mkdir -p $(XDG_CONFIG_HOME)/tmux
	ln -sf $(PWD)/.config/tmux/tmux.conf $(XDG_CONFIG_HOME)/tmux/tmux.conf

zsh:
	mkdir -p $(XDG_CONFIG_HOME)/zsh
	ln -sf $(PWD)/.zshenv $(HOME)/.zshenv
	ln -sf $(PWD)/.config/zsh/.zshenv $(XDG_CONFIG_HOME)/zsh/.zshenv
	if ! [ -e $(XDG_CONFIG_HOME)/zsh/.zshenv.local ]; then cp $(PWD)/.config/zsh/.zshenv.local $(XDG_CONFIG_HOME)/zsh/.zshenv.local; fi
	ln -sf $(PWD)/.config/zsh/.zprofile $(XDG_CONFIG_HOME)/.zprofile
	if ! [ -e $(XDG_CONFIG_HOME)/zsh/.zprofile.local ]; then cp $(PWD)/.config/zsh/.zprofile.local $(XDG_CONFIG_HOME)/zsh/.zprofile.local; fi
	ln -sf $(PWD)/.config/zsh/.zshrc $(XDG_CONFIG_HOME)/zsh/.zshrc
	if ! [ -e $(XDG_CONFIG_HOME)/zsh/.zshrc.local ]; then cp $(PWD)/.config/zsh/.zshrc.local $(XDG_CONFIG_HOME)/zsh/.zshrc.local; fi
	ln -sfn $(PWD)/.config/zsh/.zshenv.d $(XDG_CONFIG_HOME)/zsh/.zshenv.d

all: alacritty emacs git karabiner starship tmux zsh

