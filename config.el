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
(setq doom-font (font-spec :family "Source Code Pro" :size 12 :weight 'semi-light)
      ;; doom-variable-pitch-font (font-spec :family "sans" :size 13)
      )

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'wombat)
;; Remove default hover highlight that removes ability to see syntax highlighting
(custom-set-faces! '((hl-line solaire-hl-line-face) :foreground nil))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-journal-dir "~/org/journal/")
(setq org-roam-directory "~/org/roam/")

(setq projectile-project-search-path '("~/Documents/GitHub/"))

(use-package dired
  :ensure nil
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

;; (display-time-mode 1)
(if (eq initial-window-system 'x)                 ; if started by emacs command or desktop file
    (toggle-frame-maximized)
  (toggle-frame-fullscreen))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(require 'lsp)
(require 'lsp-haskell)
;; ;; Hooks so haskell and literate haskell major modes trigger LSP setup
(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)
(custom-set-variables
 '(haskell-stylish-on-save t))
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

;; (after! lsp-ui
;;   (setq lsp-ui-doc-enable t
;;         lsp-ui-doc-glance 1
;;         lsp-ui-doc-delay 0.5
;;         lsp-ui-doc-include-signature t
;;         lsp-ui-doc-position 'Top
;;         lsp-ui-doc-border "#fdf5b1"
;;         lsp-ui-doc-max-width 65
;;         lsp-ui-doc-max-height 70
;;         lsp-ui-sideline-enable t
;;         lsp-ui-sideline-ignore-duplicate t
;;         lsp-ui-peek-enable t
;;         lsp-ui-flycheck-enable -1)

;;   (add-to-list 'lsp-ui-doc-frame-parameters '(left-fringe . 0))
;; )
