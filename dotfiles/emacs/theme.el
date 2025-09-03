(use-package nano-theme
  :ensure (nano-theme
           :host github
           :repo "rougier/nano-theme")
  :config
  (load-theme 'nano t)
)

(provide 'theme)
