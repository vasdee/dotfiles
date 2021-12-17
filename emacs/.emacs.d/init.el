;; ---------------------------------------------------------
;; Global Configuration across all modes
;; ---------------------------------------------------------
(global-display-line-numbers-mode)

; Never use tabs
(setq-default indent-tabs-mode nil)

;; Global Config options
(show-paren-mode 1)

;; No Splash
(setq inhibit-startup-message t
inhibit-startup-echo-area-message t)

(setq ring-bell-function 'ignore)
(setq visible-bell 1)
(scroll-bar-mode -1)
(tool-bar-mode  -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(column-number-mode 1)
;(setq display-line-numbers 'relative)

;; stop creating backup~ files
(setq make-backup-files nil)

;; stop creating #autosave# files
(setq auto-save-default nil)

;; enable dir-locals evals without prompting
(setq enable-local-eval t) 

;; turn off line wrapping
(set-default 'truncate-lines t) 
(delete-selection-mode t)

;; Nicer window moving keys
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings)
)

(global-eldoc-mode -1)
(global-hl-line-mode 1)

;; -------------------------------------------------------
;; Add package management and bootstrap use package
;; -------------------------------------------------------
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
 (package-refresh-contents)
 (package-install 'use-package))

(require 'use-package)


;; --------------------------------------------------------
;; Custom Functions Configurations
;; ---------------------------------------------------------

(defun my/base64-encode-region-no-break ()
  (interactive)
  (base64-encode-region (mark) (point) t))


;; ---------------------------------------------------------
;; Package configurations
;; ---------------------------------------------------------

(use-package dashboard
 :ensure t
 :config
 (dashboard-setup-startup-hook)
 (setq dashboard-items '((recents  . 5)
                         (bookmarks . 5)
                         (projects . 20))))

;; For linting and on the fly syntax checking
(use-package flycheck
 :ensure t
 :init
   (global-flycheck-mode)
 :config
   (setq flycheck-check-syntax-automatically '(mode-enabled save mode-enable))
   (flycheck-add-mode 'typescript-tslint 'web-mode)
   ; Disable these until figure out what is required for flycheck linting
   ;(flycheck-add-mode 'csharp-omnisharp-codecheck 'csharp-mode)
   ;(add-to-list 'flycheck-checkers 'csharp-omnisharp-codecheck)
)

;; Mode for working with Dockerfile
(use-package dockerfile-mode
 :ensure t
)

;; For inspecting certificates and private keys
(use-package x509-mode
 :ensure t
)

;(use-package spacemacs-theme
;  :ensure t
;)

(use-package dracula-theme
 :ensure t
 :config
  ;(load-theme 'dracula t)
  ;(load-theme 'nord t)
  (load-theme 'spacemacs-dark t)
)

;; Silver Searcher support
(use-package ag
 :ensure t
 :init
   (setq ag-reuse-buffers t)
 :bind
   ("C-c o" . ag-project-regexp)
)

;; Snippet manager for creating and using
;; custom code snippets
(use-package yasnippet
 :ensure t
 :init
   (yas-global-mode +1)
)


;; Project manager. Organises projects by .git presence and other known files
(use-package projectile
 :ensure t
 :config
   (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
   (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
   (projectile-mode +1)
   (setq projectile-project-search-path '("~/code/dash/" "~/code/iiot-platform"))
   (setq projectile-completion-system 'ivy)
   (setq frame-title-format
    '(""
      "%b"
      (:eval
       (let ((project-name (projectile-project-name)))
         (unless (string= "-" project-name)
           (format " in [%s]" project-name))))))
)

;; Fix the indenting issues in emacs
(use-package aggressive-indent
 :ensure t
 :hook (
        (css-mode . aggressive-indent-mode)
        ;(emacs-lisp-mode . aggressive-indent-mode)
        ;(js-mode . aggressive-indent-mode)
        ;(lisp-mode . aggressive-indent-mode)
        )
  :custom (aggressive-indent-comments-too)
)

(use-package move-text
  :ensure t
  :bind (("M-p" . move-text-up)
         ("M-n" . move-text-down))
  :config (move-text-default-bindings)
)

;; Git interface
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status))
)

;; A simple file explorer 
(use-package neotree
  :ensure t
  :config
    (setq neo-theme (if (display-graphic-p) 'icons 'classic))
    (setq neo-window-fixed-size nil)
    (setq neo-window-width 50)
    (setq-default neo-show-hidden-files t)
    (setq neo-smart-open t)
  :bind
    ("<f8>" . neotree-toggle)
    ("<C-f8>" . neotree-show)
  :hook
    ;; Disable line-numbers minor mode for neotree
    (neo-after-create . (lambda (&rest _) (display-line-numbers-mode -1)))
)

;; Icon package for displaying in neotree and modelines
(use-package all-the-icons
  :if (display-graphic-p)
  :config (unless (find-font (font-spec :name "all-the-icons"))
            (all-the-icons-install-fonts t))
)


;; Allows auto completion of commands in the command buffer
(use-package ivy
  :ensure t
  :config
    (setq ivy-use-virtual-buffers t)
    (setq ivy-count-format "(%d/%d) ")
    (ivy-mode 1)
  :bind 
    ("C-x b" . ivy-switch-buffer)
    ("C-x B" . ivy-switch-buffer-other-window)
)

;; Find 
(use-package counsel
  :ensure t
  :after ivy
  :config
  (counsel-mode)
  :bind
    ;; Set a VSCode style find file in project lookup key
  ("C-x p" . counsel-git)
)

;; Better searching control
(use-package swiper
  :after ivy
  :bind
  ("C-s" . swiper)
  ("C-r" . swiper)
)


;; Nice display of the modeline for git, flycheck info
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
)

;; Simple client for making REST requests
(use-package restclient
  :ensure t
)

;; Language Server protocol support for code completion
(use-package lsp-mode
  :ensure t
  :commands lsp
  :init
    (setq lsp-keymap-prefix "C-c l")
  :config
    (setq lsp-prefer-flymake nil)
    (setq lsp-imenu-sort-methods '(position kind))
    ;; https://emacs-lsp.github.io/lsp-mode/page/performance/
    (setq gc-cons-threshold 100000000)
    (setq read-process-output-max (* 1024 1024)) ;; 1mb
    (setq lsp-idle-delay 0.500)
  :hook
    ;; config lifted from https://vxlabs.com/2018/06/08/python-language-server-with-emacs-and-lsp-mode/
    (lsp-after-open . lsp-enable-imenu)
    (python-mode . lsp)
    (csharp-mode . lsp)
    (typescript-mode . lsp)
    (web-mode . lsp)
    (lsp-after-initialize . (lambda() (flycheck-add-next-checker 'lsp 'typescript-tslint)))
)

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (when (> (length (locate-dominating-file default-directory "Pipfile")) 0)
                           (message . ("Found pip file, adding venv to path"))
                           ;;(setq lsp-pyright-venv-path (concat (string-trim-right (shell-command-to-string "pipenv --venv"))))
                           (setq lsp-pyright-venv-path "/home/millrt9/.local/share/virtualenvs/")
                           (setq lsp-pyright-venv-directory (file-name-nondirectory (string-trim-right (shell-command-to-string "pipenv --venv"))))
                         )
                         (lsp)))
)  ; or lsp-deferred

;; Debugging support
;(use-package dap-mode
;  :ensure t
;  :after lsp-mode
  ;:config
  ;  (dap-mode t)
  ;  (dap-ui-mode t)
;)

;; Pop up dialog for autocomplete functions
(use-package company
  :ensure t
  :config
    (setq company-tooltip-align-annotations t)
    (setq global-company-mode t)
)

;; Allow LSP mode to use company for autocompletion/intellisense
;(use-package company-lsp
;  :ensure t
;)

;; Supports highlighting of csharp projects
(use-package  csharp-mode
  :ensure t
  ;;:config
    ;; There are errors in the current version, this seems stable enough
    ;;(setq lsp-csharp-server-path "/home/vasdee/.emacs.d/.cache/lsp/omnisharp-roslyn/v1.37.8/run")
 )

;; Handy functions to support csharp mode
(use-package omnisharp
  :after csharp-mode
  :ensure t
)

;; The user interface parts of lsp
(use-package lsp-ui
  :ensure t
  :init
    (setq lsp-ui-sideline-ignore-duplicate t)
    (setq lsp-ui-sideline-mode -1)
  :commands lsp-ui-mode
  )

(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)

;; Built in package for supporting JS/HTML etc.
;; This is configured to use type script which works well with react
(use-package web-mode
  :ensure t
  :init
    (add-to-list 'auto-mode-alist '("\\.ts$" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.tsx$" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.html"   . web-mode))
  :config
    (setq web-mode-enable-auto-quoting nil)
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-code-indent-offset 2)
    (setq web-mode-attr-indent-offset 2)
    (setq web-mode-attr-value-indent-offset 2)
)

;; Alternative mode for react, when not using typescript
(use-package rjsx-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.jsx$" . rjsx-mode))
  (add-to-list 'auto-mode-alist '("\\.js$" . rjsx-mode))
  (add-hook 'rjsx-mode-hook (lambda ()
			      (flyspell-mode-off)
			      ;(aggressive-indent-mode 1)
			      (setq js-indent-level 2) ;; 2 spaces
			      (setq js2-basic-offset 2)
			      ))
  :config
   (with-eval-after-load "lsp-javascript-typescript"
     (add-hook 'rjsx-mode-hook #'lsp)
   )
)

;; Python syntax highlighting support
(use-package python
  :config
    (add-to-list 'flycheck-disabled-checkers 'python-flake8)
    (eldoc-mode -1)
    ;(setq python-shell-interpreter "ipython"
    ;      python-shell-interpreter-args "--simple-prompt -i")

  (when (> (length (locate-dominating-file default-directory "Pipfile")) 0)
    (message . ("Found pip file, adding venv to path"))
    (add-to-list 'exec-path (concat (string-trim-right (shell-command-to-string "pipenv --venv")) "/bin/"))
    (setq lsp-pyright-venv-path (concat (string-trim-right (shell-command-to-string "pipenv --venv")) "/bin/"))
  )
)

(use-package yaml-mode
  :ensure t
  :init
    (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
    (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
)

(use-package json-mode
  :ensure t
  :init
    (add-to-list 'auto-mode-alist '("\\.json$" . json-mode))
)

(use-package markdown-mode
  :ensure t
  :config
    (setq markdown-command  "pandoc --metadata=title=markdown -f markdown -t html5 --mathjax --highlight-style=pygments --standalone")
)

(use-package flyspell-mode
  :hook
    (markdown-mode . flyspell-mode)
    (rst-mode . flyspell-mode)
)

(use-package makefile-executor
  :ensure t
  :config
  (add-hook 'makefile-mode-hook 'makefile-executor-mode)
)

(use-package rst
  :ensure t
  :init
    (add-to-list 'auto-mode-alist '("\\.rst$" . rst-mode))
    (add-to-list 'auto-mode-alist '("\\.rest$" . rst-mode))
)


;; -------------------------------------
;; init.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-safe-themes
   (quote
    ("37768a79b479684b0756dec7c0fc7652082910c37d8863c35b702db3f16000f8" "2dff5f0b44a9e6c8644b2159414af72261e38686072e063aa66ee98a2faecf0e" "3f44e2d33b9deb2da947523e2169031d3707eec0426e78c7b8a646ef773a2077" "aaffceb9b0f539b6ad6becb8e96a04f2140c8faa1de8039a343a4f1e009174fb" "190a9882bef28d7e944aa610aa68fe1ee34ecea6127239178c7ac848754992df" "a4df5d4a4c343b2712a8ed16bc1488807cd71b25e3108e648d4a26b02bc990b3" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(package-selected-packages
   (quote
    (dash dap-mode makefile-executor omnisharp typescript-mode dashboard magit-popup neotree nord-theme projectile spacemacs-theme move-text aggressive-indent csharp-mode restclient x509-mode powershell all-the-icons-dired lsp-elixir flycheck-prospector doom-modeline docker-compose-mode use-package company-lsp lsp-python lsp-ui lsp-mode dockerfile-mode add-node-modules-path all-the-icons counsel json-mode yaml-mode ag magit fish-mode markdown-mode rjsx-mode dracula-theme yasnippet-snippets js2-mode web-mode flycheck)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-face-highlight-read ((t (:inherit highlight :underline "dark gray")))))


(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
