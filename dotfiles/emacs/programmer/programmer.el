(require 'use-package)
(require 'eglot)

(use-package display-line-numbers
  :hook
  (prog-mode . display-line-numbers-mode)
  :init
  (setq display-line-numbers-type 'relative)
)


(use-package transient
  :ensure t
)

(use-package magit 
  :ensure t
  :general
  (:prefix "C-c m"
    "g" 'magit-status
    "d" 'magit-dispatch
    "f" 'magit-file-dispatch
    "i" 'magit-init
    "c" 'magit-clone 
  )
)

(use-package nix-mode
  :ensure t
  :mode "\\.nix\\'"
  :hook (nix-mode . eglot-ensure)
)
(provide 'programmer)
