;;; package --- Summary
;;; Commentary:

;;; Code:

;;; Ensure `user-emacs-directory` is set correctly
(setq user-emacs-directory (file-name-directory load-file-name))

;;; Add core to load-path
(add-to-list 'load-path (expand-file-name "core" user-emacs-directory))
;;; Add modular-editing to load-path
(add-to-list 'load-path (expand-file-name "modular-editing" user-emacs-directory))
;;; Add file-management to load-path
(add-to-list 'load-path (expand-file-name "file-management" user-emacs-directory))
;;; Add project-management to load-path
(add-to-list 'load-path (expand-file-name "project-management" user-emacs-directory))
;; Add dashboard to load-path
;; (add-to-list 'load-path (expand-file-name "dashboard" user-emacs-directory))
;; Add autocomplete to load-path
(add-to-list 'load-path (expand-file-name "autocomplete" user-emacs-directory))
;; Add notetaking to load-path
(add-to-list 'load-path (expand-file-name "note-taking" user-emacs-directory))
;; Add org configuration to load-path
(add-to-list 'load-path (expand-file-name "org" user-emacs-directory))
;; Add programming configuration to load-path
(add-to-list 'load-path (expand-file-name "programming" user-emacs-directory))
;; Add bibliography configuration to load-path
(add-to-list 'load-path (expand-file-name "bibliography-management" user-emacs-directory))
;; Add bibliography configuration to load-path
(add-to-list 'load-path (expand-file-name "llms" user-emacs-directory))

;; Disable package.el in favor of straight.el
(setq package-enable-at-startup nil)

;;Fonts
(set-face-attribute 'default nil :family "ComicShannsMonoNerdFontMono" :height 150)

;;Sensible defaults
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
;;Vim-like scrolling
(setq scroll-step 1)
(setq scroll-margin 1)
(setq scroll-conservatively 9999)
;;No ugly borders
(modify-all-frames-parameters
 '((right-divider-width . 5)
   (internal-border-width . 50)))
(dolist (face '(window-divider
                  window-divider-first-pixel
                  window-divider-last-pixel))
  (face-spec-reset-face face)
  (set-face-foreground face (face-attribute 'default :background)))
(set-face-background 'fringe (face-attribute 'default :background))

(provide 'early-init)
;;; early-init.el ends here
