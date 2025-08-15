(require 'early-init)

;; Install elpaca.el
(defvar elpaca-installer-version 0.10)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Install use-package support
(elpaca elpaca-use-package
  ;; Enable use-package :ensure support for Elpaca.
  (elpaca-use-package-mode))


(use-package apropospriate-theme
  :ensure t
  :config 
  (load-theme 'modus-operandi-tritanopia t)
)

;;Defaults
(use-package emacs
  :ensure nil
  :custom
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Hide commands in M-x which do not work in the current mode.
  (read-extended-command-predicate #'command-completion-default-include-p)
  :init
  (setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox")
  (setq inhibit-startup-screen t)
  (org-babel-do-load-languages
   'org-babel-load-languages '(
			       (C . t)
			       (emacs-lisp . t)
			       (python . t)
			       (haskell . t)
			       (shell . t)
			       ))
  :hook
  (prog-mode . display-line-numbers-mode)
)

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize)
)

(use-package all-the-icons
  :ensure t
)

(use-package nerd-icons
   :ensure t
)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
)

(use-package openwith
  :ensure t
  :config
  (setq openwith-associations
        '(("\\.pdf\\'" "evince" (file))
          ("\\.djvu\\'" "evince" (file))
          ("\\.html?\\'" "firefox" (file))
          ("\\.mp4\\'" "vlc" (file))))
  (openwith-mode 1))

;;Libraries
(use-package svg-lib
  :ensure t
)

;; Enable extra keybindings
(require 'keybinding-manager)
;; Enable vim motions
(require 'vim-motions)
;; Enable avy motions
(require 'avy-motions)
;; Extra
(require 'navigation)
;; Enable file exploring
(require 'file-explorer)
;; Enable project Managemer
(require 'project-manager)
;; Enable versioning ex. git
(require 'versioning)
;; Enable autocomplete on minibuffer
(require 'minibuffer-autocomplete)
;; Enable autocomplete on region
(require 'region-autocomplete)
;; Enable orderless filter
(require 'orderless-filtering)
;; Org Mode

;;Note Taking
(require 'roam-notes)
;; Enable org aesthetics
(require 'org-aesthetics)
;; Enable org configuratione
(require 'org-configuration)
;; Enable org latex 
(require 'org-latex)

;;Bibliography Management
(require 'bib-notes)
(require 'bib-manager)

;; Snippets
(require 'snippets)
;; Lsp
(require 'programming-lsp)
;; Visuals for programming
(require 'programming-visuals)
;; Enbable Rust
(require 'rust-programming)
;; Enable Haskell 
(require 'haskell-programming)
;; Enable Ocaml
(require 'ocaml-programming)
;; Enable Coq
(require 'coq-programming)

;; (require 'startup)
(require 'variables)


;;LLMs
(require 'llms)

;;Custom file
(customize-save-variable 'custom-file  (expand-file-name "custom.el" user-emacs-directory))
;;; init.el ends here
