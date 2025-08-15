(use-package rustic
  :ensure t
  :config
  (setq rustic-lsp-setup-p nil)
)

(use-package flycheck-rust
  :ensure t
  :hook
  (flycheck-mode . flycheck-rust-setup)
)

(provide 'rust-programming)
