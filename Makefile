XDG_CONFIG_HOME ?= $(HOME)/.config
DOTFILES_HOME ?= $(HOME)/.dotfiles
DOTFILES_CONFIG_HOME := $(DOTFILES_HOME)/.config

.DEFAULT_GOAL := all

.PHONY: alacritty emacs git hammerspoon karabiner starship tmux zsh

alacritty:
	mkdir -p $(XDG_CONFIG_HOME)/alacritty
	ln -sf $(DOTFILES_CONFIG_HOME)/alacritty/alacritty.yml $(XDG_CONFIG_HOME)/alacritty/alacritty.yml

emacs:
	mkdir -p $(XDG_CONFIG_HOME)/emacs
	ln -sf $(DOTFILES_CONFIG_HOME)/emacs/init.el $(XDG_CONFIG_HOME)/emacs/init.el
	ln -sf $(DOTFILES_CONFIG_HOME)/emacs/custom.el $(XDG_CONFIG_HOME)/emacs/custom.el
	mkdir -p $(XDG_CONFIG_HOME)/emacs/inits
	ln -sf $(DOTFILES_CONFIG_HOME)/emacs/inits/*.el $(XDG_CONFIG_HOME)/emacs/inits/
	mkdir -p $(XDG_CONFIG_HOME)/emacs/themes
	ln -sf $(DOTFILES_CONFIG_HOME)/emacs/themes/wilmersdorf-theme.el $(XDG_CONFIG_HOME)/emacs/themes/wilmersdorf-theme.el

git:
	mkdir -p $(XDG_CONFIG_HOME)/git
	ln -sf $(DOTFILES_CONFIG_HOME)/git/config $(XDG_CONFIG_HOME)/git/config
	touch $(XDG_CONFIG_HOME)/git/config.local
	ln -sf $(DOTFILES_CONFIG_HOME)/git/ignore $(XDG_CONFIG_HOME)/git/ignore

hammerspoon:
	mkdir -p $(XDG_CONFIG_HOME)/hammerspoon
	ln -sf $(DOTFILES_CONFIG_HOME)/hammerspoon/init.lua $(XDG_CONFIG_HOME)/hammerspoon/init.lua
	defaults write org.hammerspoon.Hammerspoon MJConfigFile "$(HOME)/.config/hammerspoon/init.lua"

karabiner:
	mkdir -p $(XDG_CONFIG_HOME)/karabiner
	ln -sf $(DOTFILES_CONFIG_HOME)/karabiner/karabiner.json $(XDG_CONFIG_HOME)/karabiner/karabiner.json

starship:
	mkdir -p $(XDG_CONFIG_HOME)/starship
	ln -sf $(DOTFILES_CONFIG_HOME)/starship/starship.toml $(XDG_CONFIG_HOME)/starship/starship.toml

tmux:
	mkdir -p $(XDG_CONFIG_HOME)/tmux
	ln -sf $(DOTFILES_CONFIG_HOME)/tmux/tmux.conf $(XDG_CONFIG_HOME)/tmux/tmux.conf

zsh:
	mkdir -p $(XDG_CONFIG_HOME)/zsh
	ln -sf $(DOTFILES_CONFIG_HOME)/.zshenv $(HOME)/.zshenv
	ln -sf $(DOTFILES_CONFIG_HOME)/zsh/.zshenv $(XDG_CONFIG_HOME)/zsh/.zshenv
	ln -sf $(DOTFILES_CONFIG_HOME)/zsh/.zprofile $(XDG_CONFIG_HOME)/.zprofile
	ln -sf $(DOTFILES_CONFIG_HOME)/zsh/.zshrc $(XDG_CONFIG_HOME)/zsh/.zshrc
	if ! [ -e $(XDG_CONFIG_HOME)/zsh/.zshenv.local ]; then \
		cp $(DOTFILES_CONFIG_HOME)/zsh/.zshenv.local $(XDG_CONFIG_HOME)/zsh/.zshenv.local; \
	fi
	if ! [ -e $(XDG_CONFIG_HOME)/zsh/.zprofile.local ]; then \
		cp $(DOTFILES_CONFIG_HOME)/zsh/.zprofile.local $(XDG_CONFIG_HOME)/zsh/.zprofile.local;\
	fi
	if ! [ -e $(XDG_CONFIG_HOME)/zsh/.zshrc.local ]; then \
		cp $(DOTFILES_CONFIG_HOME)/zsh/.zshrc.local $(XDG_CONFIG_HOME)/zsh/.zshrc.local; \
	fi

	ln -sfn $(DOTFILES_CONFIG_HOME)/zsh/.zshenv.d $(XDG_CONFIG_HOME)/zsh/.zshenv.d

all: alacritty emacs git hammerspoon karabiner starship tmux zsh

