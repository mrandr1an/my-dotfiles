(use-package nano-modeline
  :ensure
    (nano-modeline :host github :repo "rougier/nano-modeline" :branch "rewrite")
  :init
    (setq-default mode-line-format nil)
  :config
  ;; --- tiny echo commands ---
  (defun my/nano-echo-elisp ()  (message "ELISP: ."))
  (defun my/nano-echo-org ()    (message "ORG: outline > everything."))
  (defun my/nano-echo-eshell () (message "ESHELL: $ echo hello"))
  (defun epic-button () (nano-modeline-button "ELISP-ECHO" #'my/nano-echo-elisp 'active "Echo from Emacs Lisp"))
  ;; --- 3 distinct formats (each with a different button) ---
  (setq my/nano-format-elisp
        (cons
         '(nano-modeline-element-buffer-status
           nano-modeline-element-half-space
           nano-modeline-element-buffer-name
           nano-modeline-element-space
           nano-modeline-element-buffer-mode
           nano-modeline-element-space
	   epic-button
	   )
         '(
           nano-modeline-element-window-status
           nano-modeline-element-half-space)))
  (setq my/nano-format-org
        (cons
         '(nano-modeline-element-buffer-status
           nano-modeline-element-space
           nano-modeline-element-buffer-name)
         '((nano-modeline-button "ORG-ECHO" #'my/nano-echo-org 'active "Echo from Org")
           nano-modeline-element-window-status
           nano-modeline-element-half-space)))

  (setq my/nano-format-eshell
        (cons
         '(nano-modeline-element-terminal-status
           nano-modeline-element-space
           nano-modeline-element-terminal-name
           nano-modeline-element-space
           nano-modeline-element-terminal-mode)
         '(nano-modeline-element-terminal-directory
           nano-modeline-element-space
           (nano-modeline-button "ESH-ECHO" #'my/nano-echo-eshell 'active "Echo from Eshell")
           nano-modeline-element-window-status
           nano-modeline-element-half-space)))

  ;; --- per-mode installs (buffer-local; no 3rd arg) ---
  :hook
  ((emacs-lisp-mode . (lambda () (nano-modeline my/nano-format-elisp 'header)))
   (org-mode        . (lambda () (nano-modeline my/nano-format-org   'header)))
   (eshell-mode     . (lambda () (nano-modeline my/nano-format-eshell 'header)))
   (prog-mode . (lambda () (nano-modeline)))))


(provide 'modeline)
