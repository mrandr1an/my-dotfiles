(use-package rainbow-delimiters
  :ensure t
  :defer t
  :hook
  (prog-mode .rainbow-delimiters-mode)
)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
)

(use-package flycheck-inline
  :ensure t
  :hook
  (flycheck-mode . flycheck-inline-mode)
)

(provide 'programming-visuals)
