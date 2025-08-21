(require 'use-package)
(require 'eglot)

(use-package display-line-numbers
  :hook
  (prog-mode . display-line-numbers-mode)
  :init
  (setq display-line-numbers-type 'relative)
)

(use-package nix-mode
  :ensure t
  :mode "\\.nix\\'"
  :hook (nix-mode . eglot-ensure)
)
(provide 'programmer)
