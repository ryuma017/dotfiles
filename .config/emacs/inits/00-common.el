(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")
(setq custom-theme-directory "~/.config/emacs/themes")

;; -Color Theme
(load-theme 'wilmersdorf t t)
(enable-theme 'wilmersdorf)

;; Key bounds
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-c C-l") 'toggle-truncate-lines)

(setq mac-pass-command-to-system t)
(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'meta)
(setq truncate-lines t)

(global-display-line-numbers-mode)
(line-number-mode t)
(column-number-mode t)
