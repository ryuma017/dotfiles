(use-package rustic
  :ensure
  :bind (:map rustic-mode-map
          ("M-j" . lsp-ui-imenu)
          ("M-?" . lsp-find-references)
          ("C-c C-c l" . flycheck-list-errors)
          ("C-c C-c a" . lsp-execute-code-action)
          ("C-c C-c r" . lsp-rename)
          ("C-c C-c q" . lsp-workspace-restart)
          ("C-c C-c Q" . lsp-workspace-shutdown)
          ("C-c C-c s" . lsp-rust-analyzer-status)
          ("C-c C-c e" . lsp-rust-analyzer-expand-macro)
          ("C-c C-c d" . dap-hydra)
          ("C-c C-c h" . lsp-ui-doc-glance))
  :config

  (add-hook 'rustic-mode-hook 'rym/rustic-mode-hook))

(defun rym/rustic-mode-hook ()
  (when buffer-file-name
    (setq-local buffer-save-without-query t))
  (add-hook 'before-save-hook 'lsp-format-buffer nil t))

;; for rust-analyzer integration
(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  (lsp-rust-analyzer-server-display-inlay-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (lsp-rust-analyzer-display-closure-return-type-hints t)
  (lsp-rust-analyzer-display-parameter-hints nil)
  (lsp-rust-analyzer-display-reborrow-hints nil)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
  :ensure
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable nil))


;; inline errors
(use-package flycheck :ensure)

;; auto-completion and code snippets
(use-package yasnippet
  :ensure
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  (add-hook 'text-mode-hook 'yas-minor-mode))

(use-package company
  :ensure
  :bind
  (:map company-active-map
    ("C-n". company-select-next)
    ("C-p". company-select-previous)
    ("M-<". company-select-first)
    ("M->". company-select-last))
  (:map company-mode-map
      ("<tab>". tab-indent-or-complete)
      ("TAB". tab-indent-or-complete)))

(defun company-yasnippet-or-completion ()
  (interactive)
  (or (do-yas-expand)
      (company-complete-common)))

(defun check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
        (backward-char 1)
        (if (looking-at "::") t nil)))))

(defun do-yas-expand ()
  (let ((yas/fallback-behavior 'return-nil))
    (yas/expand)))

(defun tab-indent-or-complete ()
  (interactive)
  (if (minibufferp)
      (minibuffer-complete)
    (if (or (not yas/minor-mode)
            (null (do-yas-expand)))
        (if (check-expansion)
            (company-complete-common)
          (indent-for-tab-command)))))

;; Create / cleanup rust scratch projects quickly
(use-package rust-playground :ensure)

;; for Cargo.toml and other config files
(use-package toml-mode :ensure)
