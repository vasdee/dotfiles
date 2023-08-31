;; ---------------------------------------------------------
;; Global Configuration across all modes
;; ---------------------------------------------------------
;(global-display-line-numbers-mode)
(global-set-key (kbd "C-x C-b") 'ibuffer)
;
; Never use tabs
(setq-default indent-tabs-mode nil)

(setq backup-directory-alist
      `((".*" . "~/.emacs.d/backups")))
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/backups" t)))

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

(defun my/dired-new-file ()
    "Like `find-file' but with `default-directory' set to the one specified by listing header."
    (interactive)
    (let ((default-directory (dired-current-directory)))
                                        ;(call-interactively #'find-file)))
      (call-interactively #'dired-create-empty-file)))

(defun my/dired-gitignore-filter()
    "Enable dired-gitignore-mode to use the current directory for filtering."
    (interactive)
    (let ((default-directory (dired-current-directory)))
      (call-interactively #'dired-gitignore-mode)))

;; ---------------------------------------------------------
;; Package configurations
;; ---------------------------------------------------------

(use-package dired
  :ensure nil
  :config
  (setq dired-listing-switches "-laGh1v --group-directories-first")
)

;(use-package dired-filter
;  :ensure t
;)

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

(use-package poetry
  :ensure t
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
  :init
  ;(load-theme 'sanityinc-tomorrow-night t)
  ;(load-theme 'sanityinc-tomorrow-bright t)
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


;; Project manager. Organises projects by .git presence and other known files
(use-package projectile
 :ensure t
 :config
   (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
   (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
   (projectile-mode +1)
   (setq projectile-project-search-path '("~/Work/IIoT/" "~/Work/" "~/Projects" "~/code/iiot-platform/"))
   (setq projectile-completion-system 'ivy)
   (setq frame-title-format
    '(""
      "%b"
      (:eval
       (let ((project-name (projectile-project-name)))
         (unless (string= "-" project-name)
           (format " [%s]" project-name))))))
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


(use-package dired-sidebar
  :bind (
         ("C-x t" . dired-sidebar-toggle-sidebar)
         ("C-x j" . dired-sidebar-jump-to-sidebar)
         )
  :bind
  (:map dired-sidebar-mode-map
        ("N" . my/dired-new-file)
        ("C-i" . #'dired-gitignore-mode)
        ;("C-i" . dired-filter-by-git-ignored)
        ;("F" . dired-create-empty-file)
        ;("C-t c d" . dired-create-directory)
        ;("C-t d d" . dired-do-delete)
        )
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (add-to-list 'dired-sidebar-special-refresh-commands '(my/dired-find-file dired-create-empty-file))
  (setq dired-sidebar-should-follow-file t)
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)
  ;(setq dired-sidebar-subtree-line-prefix "__")
  (setq dired-sidebar-theme 'icons)
  (setq dired-sidebar-use-term-integration t)
  ;(setq dired-sidebar-use-custom-font t)
  (setq dired-sidebar-width 50 )
  :hook
  (dired-sidebar-mode . #'hide-mode-line-mode)
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
    (setq lsp-file-watch-threshold 2000)
  :hook
    ;; config lifted from https://vxlabs.com/2018/06/08/python-language-server-with-emacs-and-lsp-mode/
    (lsp-after-open . lsp-enable-imenu)
    (python-mode . lsp)
    (csharp-mode . lsp)
    (typescript-mode . lsp)
    (web-mode . lsp)
    (svelte-mode . lsp)
    (sql-mode . lsp)
    (lsp-after-initialize . (lambda() (flycheck-add-next-checker 'lsp 'javascript-eslint)))
)

;;
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                         (setq lsp-pyright-venv-directory ".venv")
                         (require 'lsp-pyright)
                         (when (> (length (locate-dominating-file default-directory "Pipfile")) 0)
                           (message . ("Found pip file, adding venv to path"))
                           (setq venv-path (concat default-directory ".venv/bin"))
                           (message . (venv-path))
                           ;(add-to-list 'python-shell-exec-path venv-path)
                           ;;(setq python-shell-exec-path (append python-shell-exec-path '(concat (default-directory ".venv"))))
                           ;;(setq lsp-pyright-venv-path (concat (string-trim-right (shell-command-to-string "pipenv --venv"))))
                           ;;(setq lsp-pyright-venv-path "/home/millrt9/.local/share/virtualenvs")
                           ;;(setq lsp-pyright-venv-directory (file-name-nondirectory (string-trim-right (shell-command-to-string "pipenv --venv"))))
                         )
                         (lsp-deferred)))
)  ; or lsp-deferred

;; Debugging support
;(use-package dap-mode
;  :ensure t
;  :after lsp-mode
  ;:config
  ;  (dap-mode t)
  ;  (dap-ui-mode t)
;)

(use-package dap-python
  :defer t
  :after lsp-mode
  :config
    (dap-register-debug-template "PyTest"
      (list :type "python"
        :args "-i"
        :cwd nil
        :env '(("DEBUG" . "1"))
        :target-module (expand-file-name "~/src/myapp/.env/bin/myapp")
        :request "launch"
        :name "PyTest"))
)

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

(use-package svelte-mode
  :ensure t
  :init
    (setq svelte-basic-offset 4)
  :config
    (setq svelte-basic-offset 4)
  :custom
    (customize-set-variable 'svelte-basic-offset 4)
    (svelte-basic-offset 4)
)

(use-package ace-window
  :ensure t
  :bind (("M-o" . ace-window))
)

;; Supports highlighting of csharp projects
(use-package  csharp-mode
  :ensure nil
  :config
    ;; There are errors in the current version, this seems stable enough
    (setq lsp-csharp-server-path "~/.emacs.d/.cache/lsp/latest/omnisharp-roslyn/Omnisharp")
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

(use-package display-fill-column-indicator
  :ensure nil
  :hook
  (((prog-mode text-mode) . (lambda()
                   (setq display-fill-column-indicator-column 140)
                   (display-fill-column-indicator-mode))))
)

;; Python syntax highlighting support
(use-package python
  :config
    (add-to-list 'flycheck-disabled-checkers 'python-flake8)
    (eldoc-mode t)
    ;(setq python-shell-interpreter "ipython"
    ;      python-shell-interpreter-args "--simple-prompt -i")

  (when (> (length (locate-dominating-file default-directory "Pipfile")) 0)
    (message . ("Found pip file, adding venv to path"))
    (add-to-list 'exec-path (concat (string-trim-right (shell-command-to-string "pipenv --venv")) "/bin/"))
    (setq lsp-pyright-venv-path (concat (string-trim-right (shell-command-to-string "pipenv --venv")) "/bin/"))
    )
)

(use-package pyvenv
  :ensure t
  :config
  (pyvenv-mode t)
  ;:hook
  ;(python-mode . (lambda () (pyvenv-activate .venv)))
)

(use-package python-mode
  :ensure t
  :config 
  (py-underscore-word-syntax-p-off)
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
   '("37768a79b479684b0756dec7c0fc7652082910c37d8863c35b702db3f16000f8" "2dff5f0b44a9e6c8644b2159414af72261e38686072e063aa66ee98a2faecf0e" "3f44e2d33b9deb2da947523e2169031d3707eec0426e78c7b8a646ef773a2077" "aaffceb9b0f539b6ad6becb8e96a04f2140c8faa1de8039a343a4f1e009174fb" "190a9882bef28d7e944aa610aa68fe1ee34ecea6127239178c7ac848754992df" "a4df5d4a4c343b2712a8ed16bc1488807cd71b25e3108e648d4a26b02bc990b3" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default))
 '(js-indent-level 4)
 '(newsticker-url-list
   '(("phoronix" "https://www.phoronix.com/phoronix-rss.php" nil nil nil)
     ("hacker news" "https://news.ycombinator.com/rss" nil nil nil)))
 '(package-selected-packages
   '(python-mode poetry dired-gitignore dired ls-lisp all-the-icons-dired-mode display-fill-column-indicator pyvenv just-mode terraform-mode dap-python sql-mode svelte-mode svelt-mode color-theme-sanityinc-tomorrow csv-mode dash dap-mode makefile-executor typescript-mode dashboard magit-popup neotree nord-theme projectile spacemacs-theme move-text aggressive-indent restclient x509-mode powershell all-the-icons-dired lsp-elixir flycheck-prospector doom-modeline docker-compose-mode use-package company-lsp lsp-python lsp-ui lsp-mode dockerfile-mode add-node-modules-path all-the-icons counsel json-mode yaml-mode ag magit fish-mode markdown-mode rjsx-mode dracula-theme yasnippet-snippets js2-mode web-mode flycheck))
 '(pdf-view-midnight-colors '("#DCDCCC" . "#383838"))
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
