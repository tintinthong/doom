;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Justin Thong"
      user-mail-address "justinthong93@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Source Code Pro" :size 13 :weight 'semi-light)
      ;; doom-variable-pitch-font (font-spec :family "sans" :size 13)
      )

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'modus-vivendi)
;; Remove default hover highlight that removes ability to see syntax highlighting
;; (custom-set-faces! '((hl-line solaire-hl-line-face) :foreground nil))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-roam-directory "~/org/roam/")

(defmacro with-system (type &rest body)
  "Evaluate BODY if `system-type' equals TYPE."
  (declare (indent defun))
  `(when (eq system-type ',type)
     ,@body))

(with-system gnu/linux
  (message "You are free!")
  (setq projectile-project-search-path '("~/Repos/"))
  )

(with-system darwin
  (message "You are not free! But I guess you must be rich")
  (setq projectile-project-search-path '("~/Documents/GitHub/"))
  )

(use-package dired
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
   "H" 'dired-up-directory
   "L" 'dired-find-file
   )
  )

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'
(setq display-line-numbers-type 'relative)

(require 'prettier-js)
(add-hook 'js2-mode-hook 'prettier-js-mode)
(map! :leader
      :desc "Prettify" "m f" #'prettier-js
      )

(map! :leader
      :desc "Expand region" "v" #'er/expand-region
      )

(display-time-mode 1)
;; (if (eq initial-window-system 'x)                 ; if started by emacs command or desktop file
;;     (toggle-frame-maximized)
;;   (toggle-frame-fullscreen))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; (require 'lsp)
;; (require 'lsp-haskell)
;; (add-hook 'haskell-mode-hook #'lsp)
;; (add-hook 'haskell-literate-mode-hook #'lsp)
(setq haskell-stylish-on-save nil)
(map! :leader
      (:after lsp-mode
       (:prefix ("l" . "LSP")
          :desc "Restart LSP server" "r" #'lsp-workspace-restart
          :desc "Excute code action" "a" #'lsp-execute-code-action
          :desc "Go to definition" "d" #'lsp-find-definition
          :desc "Toggle doc mode" "d" #'lsp-ui-doc-mode
          (:prefix ("u" . "LSP UI")
            :desc "Toggle doc mode" "d" #'lsp-ui-doc-mode
            :desc "Toggle sideline mode"  "s" #'lsp-ui-sideline-mode
            :desc "Glance at doc" "g" #'lsp-ui-doc-glance
            :desc "Toggle imenu"  "i" #'lsp-ui-imenu
            )
          )))

(after! lsp-ui
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-glance 1
        lsp-ui-doc-delay 0.5
        lsp-ui-doc-include-signature t
        lsp-ui-doc-position 'at-point
        lsp-ui-doc-border "#fdf5b1"
        lsp-ui-doc-max-width 65
        lsp-ui-doc-max-height 70
        lsp-ui-sideline-enable t
        lsp-ui-sideline-ignore-duplicate t
        lsp-ui-peek-enable t
        lsp-ui-flycheck-enable -1)

  (add-to-list 'lsp-ui-doc-frame-parameters '(left-fringe . 0))
)

(defun efs/presentation-setup ()
  (hide-mode-line-mode 1)
  (org-display-inline-images)
  (setq text-scale-mode-amount 3)
  (text-scale-mode 1)
  )
(defun efs/presentation-end ()
  (hide-mode-line-mode 0)
  (text-scale-mode 0)
  )
(use-package org-tree-slide
  :hook (
         (org-tree-slide-play . efs/presentation-setup)
         (org-tree-slide-stop . efs/presentation-end)
         )
  :custom
  (org-tree-slide-slide-in-effect t)
  (org-tree-slide-activate-message t)
  (org-tree-slide-deactivate-message t)
  (org-tree-slide-header t)
  (org-tree-slide-skip-comments 'nil)
)

(use-package command-log-mode
  :config
  (global-command-log-mode)
  )
(setq command-log-mode-window-font-size 5)

(setq whitespace-mode 't)

;; Interactive Org Roam Server Graph
;; (require 'simple-httpd)
;; (setq httpd-root "/var/www")
;; (httpd-start)
(require 'org-roam-protocol)
(use-package org-roam-server
  :ensure t
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8080
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files nil
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20))

(map! :leader
      :desc "test random prefix"
      "a j j" #'org-tree-slide-skip-comments-toggle)

(map! :leader
      (:prefix-map ("t" . "toggle")
       (:prefix ("s" . "tree-slide")
        :desc "Skip comments in slide" "c" #'org-tree-slide-skip-comments-toggle
        )
       )
      )

(key-chord-mode 1)
(key-chord-define-global "jk" 'evil-normal-state)
