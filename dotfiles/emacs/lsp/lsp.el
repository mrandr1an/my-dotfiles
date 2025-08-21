(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '(nix-mode . ("nixd")))
)

(provide 'lsp)

