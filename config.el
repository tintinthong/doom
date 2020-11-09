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
(setq doom-font (font-spec :family "Source Code Pro" :size 15 :weight 'semi-light)
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

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'
(setq display-line-numbers-type 'relative)

(require 'prettier-js)
(add-hook 'js2-mode-hook 'prettier-js-mode)
;; eslint already used in +lsp
;; (add-hook 'js2-mode-hook
;;           (defun my-js2-mode-setup ()
;;             (flycheck-mode t)
;;             (when (executable-find "eslint")
;;               (flycheck-select-checker 'javascript-eslint))))

;; (setq prettier-js-args '(
;;   "--trailing-comma" "all"
;;   "--bracket-spacing" "false"
;; ))

(map! :leader
      :desc "Expand region" "v" #'er/expand-region
      )

;; (display-time-mode 1)
(if (eq initial-window-system 'x)                 ; if started by emacs command or desktop file
    (toggle-frame-maximized)
  (toggle-frame-fullscreen))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; (require 'lsp)
;; (require 'lsp-haskell)
;; ;; Hooks so haskell and literate haskell major modes trigger LSP setup
;; (add-hook 'haskell-mode-hook #'lsp)
;; (add-hook 'haskell-literate-mode-hook #'lsp)
