;;; Package --- Summary
;;; Commentary:
;;; Code:

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-integration t)
  :config
  (evil-mode 1)
  (setq evil-want-minibuffer t)
  :general
  (:keymaps 'evil-insert-state-map
	    "C-k" nil
	    "C-j" nil
	    "C-h" nil
	    "C-l" nil
	    "C-d" nil
	    "C-a" nil
  )
)

(use-package evil-collection
:after evil
:ensure t
:config
(evil-collection-init)
)

(use-package evil-nerd-commenter
  :ensure t
  :after evil
  :config
  (evilnc-default-hotkeys)
  :general 
  (:keymaps 'evil-visual-state-map
	    "gcc" 'evilnc-comment-or-uncomment-lines
	    )

  (:keymaps 'evil-visual-state-map
	    "gcc" 'evilnc-comment-or-uncomment-lines
  )
)

(use-package evil-org
:ensure t
:after (org evil)
:hook (org-mode . (lambda () evil-org-mode))
:config
(require 'evil-org-agenda)
(evil-org-agenda-set-keys)
)

(use-package undo-fu
  :after evil
  :ensure t
  :config 
  (setq evil-undo-system 'undo-fu)
  (global-unset-key (kbd "C-z"))
)

(provide 'vim-motions)
;;; vim-motions.el ends here
