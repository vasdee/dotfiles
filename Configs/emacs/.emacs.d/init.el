;; ---------------------------------------------------------
;; ---------------------------------------------------------
;; Global Configuration across all modes
(global-set-key (kbd "C-x C-b") 'ibuffer)

(use-package emacs
  :init
  (defalias 'yes-or-no-p 'y-or-n-p) ;; life is too short
  (show-paren-mode t)
  (setq enable-local-eval t) 
  (setq make-backup-files nil)
  (setq auto-save-default nil)
  ;; keep backup and save files in a dedicated directory
  (setq backup-directory-alist
        `((".*" . ,(concat user-emacs-directory "backups")))
        auto-save-file-name-transforms
        `((".*" ,(concat user-emacs-directory "backups") t)))
  (setq indent-tabs-mode nil)

  ;; No bell notification
  (setq ring-bell-function 'ignore)
  (setq visible-bell 1)

  (set-default 'truncate-lines t) ;; turn off line wrapping
  (delete-selection-mode t)

  (setq window-sides-slots '(1 0 1 0))

  (add-to-list 'display-buffer-alist
        `(,(rx (| "*compilation*" "*grep*" "*Embark Export" "*Occur" "*Flycheck" "*Messages" "*Help" "*scratch"))
          display-buffer-in-side-window
          (side . right)
          (slot . 0)
          (window-parameters . ((no-delete-other-windows . t)))
          (window-width . 80)))
  
)


;; Nicer window moving keys
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings)

  )

;; smooth scrolling
(setq scroll-step           1
      scroll-conservatively 10000)

(global-eldoc-mode -1)
(global-hl-line-mode 1)

(defun font-available-p (font-name)
  (find-font (font-spec :name font-name)))

(cond
 ((font-available-p "JetBrains Mono")
  (set-frame-font "JetBrains Mono-10" nil t))
 ((font-available-p "Cascadia Code")
  (set-frame-font "Cascadia Code-12" nil t))
 ((font-available-p "Hack")
  (set-frame-font "Hack 10" nil t))
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

;; -------------------------------------------------------
;; Add package management and bootstrap use package
;; -------------------------------------------------------
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
                                 ;("gnu" . "https://elpa.gnu.org/packages/")))


(package-initialize)

(unless (package-installed-p 'use-package)
 (package-refresh-contents)
 (package-install 'use-package))

(require 'use-package)


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

;; ---------------------------------------------------------
;; Package configurations
;; ---------------------------------------------------------

(use-package editorconfig-mode
  :ensure nil
  :hook ( prog-mode .  editorconfig-mode)
)

(use-package just-ts-mode
  ;:init (just-ts-mode-install-grammar)
  :ensure t
  :config
  (setq-default indent-tabs-mode nil)
  (add-to-list 'auto-mode-alist '("\\.just$" . just-ts-mode))
)

(use-package docker
  :ensure t
  :bind ("C-c d" . docker))

(use-package dired
  :ensure nil
  :config
  (setq dired-listing-switches "-laGh1v --group-directories-first")
)

(use-package dired-subtree
  :ensure t
  :after dired
  :bind (:map dired-mode-map
      ("<tab>" . 'dired-subtree-toggle)
      )
)

(use-package terraform-mode
  :ensure t
)

(use-package dashboard
 :ensure t
 :config
 (dashboard-setup-startup-hook)
 (setq dashboard-center-content t)
 (setq dashboard-items '((recents  . 5)
                         (bookmarks . 5)
                         (projects . 20)))
 (setq dashboard-display-icons-p t)
 (setq dashboard-icon-type 'all-the-icons) ;; use `all-the-icons' package 
)

;; For linting and on the fly syntax checking
(use-package flycheck
 :ensure t
 :init
   (global-flycheck-mode)
 :config
   (setq flycheck-check-syntax-automatically '(mode-enabled save mode-enable))
   (flycheck-add-mode 'javascript-eslint 'web-mode)
   ; Disable these until figure out what is required for flycheck linting
   ;(flycheck-add-mode 'csharp-omnisharp-codecheck 'csharp-mode)
   ;(add-to-list 'flycheck-checkers 'csharp-omnisharp-codecheck)
)

(use-package sql
  :ensure t
  :init
  (setq lsp-sqls-workspace-config-path nil)
  (setq sql-connection-alist
      '((sw-db
         (sql-product 'postgres)
         (sql-server "127.0.0.1")
         (sql-user "postgres")
         (sql-password "admin")
         (sql-database "postgres")
         (sql-port 5433))))
  (setq lsp-sqls-connections
    '(
      ((driver . "postgresql") (dataSourceName . "host=127.0.0.1 port=5433 user=postgres password=admin dbname=postgres sslmode=disable")))
    )
)

;; Mode for working with Dockerfile
(use-package dockerfile-mode
 :ensure t
)

(use-package csv-mode
  :ensure t
)

;; For inspecting certificates and private keys
(use-package x509-mode
 :ensure t
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Themes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package spacemacs-theme
  :ensure t
  :init
  ;(load-theme 'spacemacs-dark t)
)

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  ;(load-theme 'sanityinc-tomorrow-night t)
  ;(load-theme 'sanityinc-tomorrow-bright t)
  :init
  ;(load-theme 'sanityinc-tomorrow-eighties t)
)

(use-package dracula-theme
 :ensure t
 :init
 ;(load-theme 'dracula t)
)

(use-package material-theme
 :ensure t
 :init
 (load-theme 'material t)
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

;; use in-built project.el to manage projects
(use-package project
  :ensure t
  ;:bind-keymap ("C-c p" . project-prefix-map)
  :config
  (setq xref-search-program 'ripgrep)
  ;; set the formatting to show the project name in the tab-bar
  (setq tab-bar-format '(tab-bar-format-history tab-bar-format-tabs-groups tab-bar-separator tab-bar-format-add-tab))
  ;; make the default action when switching/opening a project to select a file
  (setq project-switch-commands 'project-find-file)  
)

;; Consolidates project buffers into a tab
(use-package project-tab-groups
  :ensure t
  :config
  (project-tab-groups-mode 1))


;; Make the tab-bar look more flat, like what's in neovim
(use-package vim-tab-bar
  :ensure t
  :commands vim-tab-bar-mode
  :hook
  (after-init . vim-tab-bar-mode)
  :config
  (setq vim-tab-bar-show-groups t))

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

(use-package display-line-numbers
  :ensure nil
  :hook
  (
   ((prog-mode text-mode conf-mode) . (lambda () (display-line-numbers-mode t )))
  )
)

(use-package all-the-icons-dired
 :ensure t
 :hook ((dired-mode . all-the-icons-dired-mode))
)


(use-package dired-gitignore
  :ensure t
  ;:bind (("" . #'dired-gitignore-mode))
)

;; Allows auto completion of commands in the command buffer
(use-package ivy
  :ensure t
  :init
    (ivy-mode 1)
  :config
    (setq ivy-use-virtual-buffers t)
    (setq ivy-count-format "(%d/%d) ")
  :bind 
    ("C-x b" . ivy-switch-buffer)
    ("C-x B" . ivy-switch-buffer-other-window)   
)

;; ensures completion happens in ivy
(use-package counsel
  :ensure t
  :after ivy
  :config
  (counsel-mode)
  :bind
    ;; Set a VSCode style find file in project lookup key
  ("C-c p f" . counsel-find-file)
  ("M-x" . counsel-M-x)
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

(use-package eglot
  :ensure t
  :defer t
  :hook ((python-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs
               `(python-mode . ,(eglot-alternatives '(("basedpyright-langserver" "--stdio")))))
  (setq-default eglot-workspace-configuration
                '((:pyright . (:venvPath ".venv" :pythonPath "."))))
  )

;; Show a nice hover box showing documentation via eldoc
(use-package eldoc-box
  :ensure t
  :hook (eglot-managed-mode . eldoc-box-hover-at-point-mode) ; (lambda() (#'eldoc-box-help-at-point t))
)


;; Pop up dialog for autocomplete functions
(use-package company
  :ensure t
  :hook (( prog-mode . company-mode))
  :config 
    ;(setq company-tooltip-align-annotations t)
    ;(setq global-company-mode t)
  :bind (:map company-active-map
                ("<return>" . nil)
                ("RET" . nil)
                ("C-<return>" . company-complete-selection)
                ([tab] . company-complete-selection)
                ("TAB" . company-complete-selection))
  :custom
  ('(company-quickhelp-color-background "#4F4F4F")
   '(company-quickhelp-color-foreground "#DCDCCC"))
)

;(use-package company-box
;    :ensure t
;    :hook (company-mode . company-box-mode)))

(use-package ace-window
  :ensure t
  :bind (("M-o" . ace-window))
)


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


(use-package display-fill-column-indicator
  :ensure nil
  :hook
  (((prog-mode text-mode) . (lambda()
                   (setq display-fill-column-indicator-column 140)
                   (display-fill-column-indicator-mode))))
)

(use-package python-mode
  :ensure t
  :config
  (py-underscore-word-syntax-p-off)
  (add-to-list 'flycheck-disabled-checkers '(python-flake8 python-mypy))
  (add-to-list 'flycheck-checkers 'python-ruff)
  (eldoc-mode t)
)

(use-package yaml-mode
  :ensure t
  :init
    (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
    (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
)

(use-package json-mode
  :ensure t
  :config
  (setq js-indent-level 2)
  :init
  (add-to-list 'auto-mode-alist '("\\.json$" . json-mode))
  )

(use-package markdown-mode
  :ensure t
  :config
  (setq markdown-command  "pandoc --metadata=title=markdown -f markdown -t html5 --mathjax --highlight-style=pygments --standalone")
  ;; always open the preview window at the right
  (setq markdown-split-window-direction 'right)
  :hook ( markdown . editorconfig-mode)
  :bind (:map markdown-mode-map
         ("C-c C-e" . markdown-do))
)

(use-package flyspell-mode
  :init
    (setq-default ispell-program-name "aspell")
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
 '(css-indent-offset 4)
 '(custom-safe-themes
   '("37768a79b479684b0756dec7c0fc7652082910c37d8863c35b702db3f16000f8"
     "2dff5f0b44a9e6c8644b2159414af72261e38686072e063aa66ee98a2faecf0e"
     "3f44e2d33b9deb2da947523e2169031d3707eec0426e78c7b8a646ef773a2077"
     "aaffceb9b0f539b6ad6becb8e96a04f2140c8faa1de8039a343a4f1e009174fb"
     "190a9882bef28d7e944aa610aa68fe1ee34ecea6127239178c7ac848754992df"
     "a4df5d4a4c343b2712a8ed16bc1488807cd71b25e3108e648d4a26b02bc990b3"
     "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4"
     default))
 '(js-indent-level 4)
 '(newsticker-url-list
   '(("phoronix" "https://www.phoronix.com/phoronix-rss.php" nil nil nil)
     ("hacker news" "https://news.ycombinator.com/rss" nil nil nil)))
 '(package-selected-packages nil)
 '(pdf-view-midnight-colors '("#DCDCCC" . "#383838"))
 '(safe-local-variable-values '((just-ts-indent-offset . 4)))
 '(sgml-basic-offset 4)
 '(warning-suppress-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-face-highlight-read ((t (:inherit highlight :underline "dark gray")))))


(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
