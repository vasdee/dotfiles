;;; init.el --- Summary
;;; Commentary:
;;; init-.el starts
;;; Code:

(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Following chadmacs conventions, separate config and language specific stuff into directories
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "lang" user-emacs-directory))

(require 'core)
(require 'ui)
(require 'tools)

;; Custom language package includes
(require 'ansible-lang)
(require 'just-lang)
(require 'rust-lang)
(require 'python-lang)
(require 'docker-lang)
(require 'yaml-lang)
(require 'json-lang)
(require 'markdown-lang)
;(require 'web-lang)
;(require 'terraform-lang)
;(require 'sql-lang)

;; Nicer window moving keys
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings)

  )

;; smooth scrolling
(setq scroll-step           1
      scroll-conservatively 10000)

(defun font-available-p (font-name)
  (find-font (font-spec :name font-name)))

;; Iosevka, Fira, Jetbrains Mono,
(cond
((font-available-p "Iosevka Nerd Font Mono")
  (set-frame-font "Iosevka Nerd Font Mono-10" nil t))
 ((font-available-p "JetBrains Mono")
  (set-frame-font "JetBrains Mono-10" nil t))
 ((font-available-p "Cascadia Code")
  (set-frame-font "Cascadia Code-12" nil t))
 ((font-available-p "Hack")
  (set-frame-font "Hack-10" nil t))
 ((font-available-p "DejaVu Sans Mono")
  (set-frame-font "DejaVu Sans Mono-12" nil t))
 ((font-available-p "Inconsolata")
  (set-frame-font "Inconsolata-12" nil t)))


;; credit: yorickvP on Github
;; temporarily disabling this method, as this is not a wayland build of emacs
(when (getenv "WSLENV")
  (message . ("In a WSL environment, setting custom copy and paste using wl-clipboard if installed"))
  (setq wl-copy-process nil)
  (defun wl-copy (text)
    (setq wl-copy-process (make-process :name "wl-copy"
                                        :buffer nil
                                        :command '("wl-copy" "-f" "-n")
                                        :connection-type 'pipe))
    (process-send-string wl-copy-process text)
    (process-send-eof wl-copy-process))
  (defun wl-paste ()
    (if (and wl-copy-process (process-live-p wl-copy-process))
        nil ; should return nil if we're the current paste owner
        (shell-command-to-string "wl-paste -n | tr -d \r")))
  (setq interprogram-cut-function 'wl-copy)
  (setq interprogram-paste-function 'wl-paste)
)

;; --------------------------------------------------------
;; Custom Functions Configurations
;; ---------------------------------------------------------

(defun my/base64-encode-region-no-break ()
  "Base 64 encode a region and ignore the line break."
  (interactive)
  (base64-encode-region (mark) (point) t))

(defun my/reload-dotemacs-file ()
  "Reload your .emacs file without restarting Emacs."
  (interactive)
  (load-file "~/.emacs.d/init.el")
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; T H E M E S
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package spacemacs-theme
    :ensure t
    :init
    (load-theme 'spacemacs-dark t)
)

(use-package color-theme-sanityinc-tomorrow
    :ensure t
    :config
    (load-theme 'sanityinc-tomorrow-night t)
    (load-theme 'sanityinc-tomorrow-bright t)
    (load-theme 'sanityinc-tomorrow-eighties t)
)

(use-package dracula-theme
    :ensure t
    :config
    (load-theme 'dracula t)
)

(use-package material-theme
    :ensure t
    :config
    (load-theme 'material t)
)

(use-package doom-themes
    :ensure t
    :custom
    (doom-themes-enable-bold nil)   ; if nil, bold is universally disabled
    (doom-themes-enable-italic nil) ; if nil, italics is universally disabled
    :config
    (load-theme 'doom-one t)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; P A C K A G E S
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package otpp
    :ensure t
    :after project
    :init
    (otpp-mode 1)
    (otpp-override-mode 1))


;; Make the tab-bar look more flat, like what's in neovim
(use-package vim-tab-bar
    :ensure t
    :commands vim-tab-bar-mode
    :hook
    (after-init-hook . vim-tab-bar-mode)
    :config
    (setq vim-tab-bar-show-groups t))

(use-package move-text
  :ensure t
  :bind (("M-p" . move-text-up)
         ("M-n" . move-text-down))
  :config (move-text-default-bindings)
)


(use-package display-line-numbers
  :ensure nil
  :hook
  (
   ((prog-mode-hook text-mode-hook conf-mode-hook) . (lambda () (display-line-numbers-mode t )))
  )
)

;; nerd-icons-install-fonts
(use-package nerd-icons
    :ensure t
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Navigation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Marginalia: rich annotations in completion candidates
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init section is always executed.
  :config

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))

;; Free form matching in the mini-buffer
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil)
  (completion-pcm-leading-wildcard t))

;; Embark: context-sensitive actions / right-click menu
(use-package embark
  :ensure t
  :bind
  (("C-." . embark-act)
   ("C-;" . embark-dwim)
   ("C-h B" . embark-bindings))
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :ensure t
  :hook (embark-collect-mode . consult-preview-at-point-mode))

;; CORFU: Inline Popup Completion UI
(use-package corfu
  :ensure t
  ;; Optional customizations
  :custom
  (corfu-cycle t)                ; Allows cycling through candidates
  (corfu-auto t)                 ; Enable auto-completion popup window
  (corfu-auto-prefix 2)          ; Minimum numeric characters before popup shows
  (corfu-auto-delay 0.3)         ; Tiny delay before menu pops up for speed
  (corfu-quit-at-boundary 'separator) ; Never quit completion at space/separator

  :init
  (global-corfu-mode 1))

;; Recommended: Enable Corfu in the Minibuffer (e.g., for Vertico search prompts)
(use-package corfu-popupinfo
  :ensure nil ; Part of the core Corfu repository package
  :hook (corfu-mode . corfu-popupinfo-mode)
  :custom
  (corfu-popupinfo-delay '(0.2 . 0.1))) ; Quick display of documentation tooltips


;; cape: Completion At Point Extensions (Backends)
(use-package cape
  :ensure t
  :init
  ;; Add useful completion backends globally to the capf list.
  ;; Order determines priority evaluation during triggers.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)     ; Words in open buffers
  (add-hook 'completion-at-point-functions #'cape-file)        ; File path system matching
  (add-hook 'completion-at-point-functions #'cape-elisp-block) ; Elisp inside org code blocks
  (add-hook 'completion-at-point-functions #'cape-keyword)     ; Programming language keywords

  :config
  ;; Optional: Silence capf errors if they cause unwanted noise in specific modes
    (setq text-mode-ispell-silent t)
)

(use-package vertico
  :ensure t
  :init
  (vertico-mode 1)
  :config
  ;; Optional: Tweak minibuffer behavior
  (setq vertico-cycle t)) ; Allow cycling from last to first candidate

(use-package consult
  :ensure t
  :bind (;; Swiper replacements
         ("C-s" . consult-line)
         ("M-s l" . consult-line)
         ;; Counsel replacements
         ("C-x b" . consult-buffer)                ; Replacing ivy-switch-buffer
         ("M-y" . consult-yank-pop)               ; Replacing counsel-yank-pop
         ("C-x r b" . consult-bookmark)
         ;; Search replacements
         ("M-s g" . consult-grep)
         ("M-s r" . consult-ripgrep)
         ;; Info/Help enhancements
         ("C-h i" . consult-info)
         ;; Errors/Flycheck integration
         ("M-g g" . consult-goto-line)            ; Enhances native line jumping
         ("M-g o" . consult-outline)))            ; Replaces counsel-outline

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Nice display of the modeline for git, flycheck info
(use-package doom-modeline
  :ensure t
  :custom
    (doom-modeline-lsp t)
    (doom-modeline-buffer-file-name-style 'truncate-with-project)
  :hook (after-init-hook . doom-modeline-mode)
)

;; Simple client for making REST requests
(use-package restclient
  :ensure t
)


;; Show a nice hover box showing documentation via eldoc
(use-package eldoc-box
  :ensure t
  :hook (eglot-managed-mode-hook . eldoc-box-hover-at-point-mode) ; (lambda() (#'eldoc-box-help-at-point t))
)

(use-package ace-window
  :ensure t
  :bind (("M-o" . ace-window))
)


(use-package display-fill-column-indicator
  :ensure nil
  :hook
  (((prog-mode-hook text-mode-hook) . (lambda()
                   ;(setq display-fill-column-indicator-column 140)
                   (display-fill-column-indicator-mode))))
)

(use-package flyspell-mode
  :init
    (setq-default ispell-program-name "aspell")
  :hook
    (markdown-mode-hook . flyspell-mode)
    (rst-mode-hook . flyspell-mode)
)

(use-package rst
  :defer t
  :init
    (add-to-list 'auto-mode-alist '("\\.rst$" . rst-mode))
    (add-to-list 'auto-mode-alist '("\\.rest$" . rst-mode))
)

(provide 'init)
;;; init.el ends here
