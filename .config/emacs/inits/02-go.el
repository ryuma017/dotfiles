(use-package lsp-mode :ensure)

(use-package lsp-ui
  :ensure
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-max-width 150)
  (lsp-ui-doc-max-height 30)
  (lsp-ui-peek-enable t)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package go-mode
  :ensure
  :config
  (add-hook 'go-mode-hook #'lsp))
