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

;; smooth scrolling
(setq scroll-step           1
      scroll-conservatively 10000)

(global-eldoc-mode -1)
(global-hl-line-mode 1)

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
                         (projects . 20))))

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
  :defer t
  :init
  (load-theme 'spacemacs-dark t)
)

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :init
  ;(load-theme 'sanityinc-tomorrow-night t)
  ;(load-theme 'sanityinc-tomorrow-bright t)
  (load-theme 'sanityinc-tomorrow-eighties t)
)

(use-package dracula-theme
 :ensure t
 :init
 ;(load-theme 'dracula t)
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
   (setq projectile-project-search-path '("~/Work/IIoT/" "~/Work/" "~/Projects"))
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

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                5000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask" "__pycache__")
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (treemacs-project-follow-mode t)
    
    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
  :after (treemacs)
  :ensure t
  :config (treemacs-set-scope-type 'Tabs))

;;;; A simple file explorer 
;;(use-package neotree
;;  :ensure t
;;  :config
;;    (setq neo-theme (if (display-graphic-p) 'icons 'classic))
;;    (setq neo-window-fixed-size nil)
;;    (setq neo-window-width 50)
;;    (setq-default neo-show-hidden-files t)
;;    (setq neo-smart-open t)
;;  :bind
;;    ("<f8>" . neotree-toggle)
;;    ("<C-f8>" . neotree-show)
;;  :hook
;;    ;; Disable line-numbers minor mode for neotree
;;    (neo-after-create . (lambda (&rest _) (display-line-numbers-mode -1)))
;;)

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

;; Supports highlighting of csharp projects
(use-package  csharp-mode
  :ensure t
  :config
    ;; There are errors in the current version, this seems stable enough
    (setq lsp-csharp-server-path "~/.emacs.d/.cache/lsp/latest/omnisharp-roslyn/Omnisharp")
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


;; Debugging with realgud
(use-package realgud
  :ensure t
)

(use-package display-fill-column-indicator
  :ensure t
  :hook
  (python-mode . (lambda()
                   (message "hook fired for display-fill-column-indicator")
                   (setq display-fill-column-indicator-column 140)
                   (display-fill-column-indicator-mode)
                   
                 )
               ) 
)

;; Python syntax highlighting support
(use-package python
  :config
    (setq display-fill-column-indicator-column 140)
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

(use-package pyvenv
  :ensure t
  :config
  (pyvenv-mode t)
  ;:hook
  ;(python-mode . (lambda () (pyvenv-activate .venv)))
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
 '(package-selected-packages
   '(display-fill-column-indicator treemacs-tab-bar treemacs-persp treemacs-magit treemacs-icons-dired treemacs-projectile treemacs pyvenv just-mode treemacs-all-the-icons terraform-mode dap-python sql-mode svelte-mode svelt-mode color-theme-sanityinc-tomorrow csv-mode dash dap-mode makefile-executor omnisharp typescript-mode dashboard magit-popup neotree nord-theme projectile spacemacs-theme move-text aggressive-indent csharp-mode restclient x509-mode powershell all-the-icons-dired lsp-elixir flycheck-prospector doom-modeline docker-compose-mode use-package company-lsp lsp-python lsp-ui lsp-mode dockerfile-mode add-node-modules-path all-the-icons counsel json-mode yaml-mode ag magit fish-mode markdown-mode rjsx-mode dracula-theme yasnippet-snippets js2-mode web-mode flycheck))
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
