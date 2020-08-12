;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(
    flycheck
    web-mode
    js2-mode
    rjsx-mode
    company
    neotree
    yasnippet
    dracula-theme
    find-file-in-project
    fish-mode
    yaml-mode
    json-mode
    ag
    counsel
    magit
    markdown-mode
    lsp-mode
    company-lsp
    lsp-ui
    dockerfile-mode
    use-package
    doom-modeline
    add-node-modules-path
    ))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; -------------------------------------
;; BASIC CUSTOMIZATION
;; -------------------------------------
(require 'yasnippet)
(require 'web-mode)
(require 'find-file-in-project)
(require 'find-dired)
(require 'json-mode)
(require 'ag)
(require 'markdown-mode)
(require 'use-package)

;; ---------------------------------------------------------
;; Global Configuration across all modes
;; ---------------------------------------------------------
;; Global keybindings
(yas-global-mode 1)
(global-display-line-numbers-mode)

;; Global Config options
(show-paren-mode 1)
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(setq visible-bell 1)
(load-theme 'dracula t)
(scroll-bar-mode -1)
(tool-bar-mode  -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(column-number-mode 1)
;(setq display-line-numbers 'relative)
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq enable-local-eval t) ;; enable dir-locals evals without prompting
(set-default 'truncate-lines t) ;; turn off line wrapping
(delete-selection-mode t)

;; Nicer window moving keys
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

; Set a VSCode style find file in project lookup key
(global-set-key (kbd "C-x p") 'counsel-git)
(global-set-key (kbd "C-c o") 'ag-project-regexp)
(global-eldoc-mode -1)
(global-hl-line-mode 1)
(set-face-background 'hl-line "#3e4446")
(set-face-foreground 'highlight nil)
(set-face-attribute 'default nil :height 100)

;; ---------------------------------------------------------
;; Package configurations
;; ---------------------------------------------------------

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status))
)

(use-package neotree
  :ensure t
  :config
  (setq neo-theme (if (display-graphic-p) 'classic 'arrow))
  (setq neo-window-fixed-size nil)
  (setq neo-window-width 50)
  (global-set-key [f8] 'neotree-toggle)
  (global-set-key (kbd "<C-f8>") 'neotree-show)
  (setq neo-smart-open t)
)

(use-package ivy
  :ensure t
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (ivy-mode 1)
)

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode)
  (setq flycheck-check-syntax-automatically '(mode-enabled save mode-enable))
)


(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
)


(use-package lsp-mode
  :ensure t
  :commands lsp
  :config
  (require 'lsp-clients)
  (setq lsp-prefer-flymake nil)
  (setq lsp-imenu-sort-methods '(position kind))
  (setq lsp-inhibit-message t)
  (set-face-attribute 'lsp-face-highlight-textual nil
		    :background "#666" :foreground "#ffffff"
		    )
  ;; https://emacs-lsp.github.io/lsp-mode/page/performance/
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 1024)) ;; 1mb
  (setq lsp-idle-delay 0.500)
  ;; make sure this is activated when python-mode is activated
  ;; lsp-python-enable is created by macro above

  ;; config lifted from https://vxlabs.com/2018/06/08/python-language-server-with-emacs-and-lsp-mode/
  (add-hook 'lsp-after-open-hook 'lsp-enable-imenu)
  (add-hook 'python-mode-hook 'lsp)
  (add-hook 'rjsx-mode-hook 'lsp)
  (add-hook 'js2-mode-hook 'lsp)
)

(use-package company-lsp
  :ensure t
)

(use-package lsp-ui
  :after lsp-mode
  :init
  (setq lsp-ui-sideline-ignore-duplicate t)
  (setq lsp-ui-sideline-mode -1)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (add-hook 'python-mode-hook 'flycheck-mode)
)

(use-package rjsx-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.jsx$" . rjsx-mode))
  (add-to-list 'auto-mode-alist '("\\.js$" . rjsx-mode))
  (add-hook 'rjsx-mode-hook (lambda ()
			      (flyspell-mode-off)
			      ;(aggressive-indent-mode 1)
			      (setq indent-tabs-mode nil) ;; use space instead of tabs
			      (setq js-indent-level 2) ;; 2 spaces
			      (setq js2-basic-offset 2)
			      ))
  :config
   (with-eval-after-load 'rjsx-mode'
     (add-hook 'rjsx-mode-hook #'add-node-modules-path)
   )
   (with-eval-after-load "lsp-javascript-typescript"
     (add-hook 'rjsx-mode-hook #'lsp)
   )
)

(use-package python
  :init
  ;; Do not use tabs for indenting
  (setq-default indent-tab-mode nil)
  :config
  (add-to-list 'flycheck-disabled-checkers 'python-flake8)
  ;; (add-to-list 'flycheck-disabled-checkers 'python-pylint)
  (eldoc-mode -1)

  (when (> (length (locate-dominating-file default-directory "Pipfile")) 0)
    (message . ("Found pip file, adding venv to path"))
    (add-to-list 'exec-path (concat (string-trim-right (shell-command-to-string "pipenv --venv")) "/bin/"))
  )
)

(use-package yaml-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
)

(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))

;; -------------------------------------
;; MARK DOWN
;; -------------------------------------
(setq markdown-command "pandoc")


;; -------------------------------------
;; Restructured Text mode
;; -------------------------------------

(add-hook 'rst-mode-hook #'flyspell-mode)


;; -------------------------------------
;; Javascript config
;; -------------------------------------
(setq company-tooltip-align-annotations t)
(add-hook 'js2-mode-hook (lambda () (setq js2-basic-offset 2)))
(add-hook 'json-mode-hook #'flycheck-mode)

;; configure jsx-tide checker to run after your default jsx checker
(flycheck-add-mode 'javascript-eslint 'web-mode)
(flycheck-add-mode 'javascript-eslint 'rjsx-mode)
;(flycheck-add-next-checker 'javascript-eslint 'append)


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
    ("3f44e2d33b9deb2da947523e2169031d3707eec0426e78c7b8a646ef773a2077" "aaffceb9b0f539b6ad6becb8e96a04f2140c8faa1de8039a343a4f1e009174fb" "190a9882bef28d7e944aa610aa68fe1ee34ecea6127239178c7ac848754992df" "a4df5d4a4c343b2712a8ed16bc1488807cd71b25e3108e648d4a26b02bc990b3" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(package-selected-packages
   (quote
    (powershell all-the-icons-dired lsp-elixir flycheck-prospector doom-modeline docker-compose-mode use-package company-lsp lsp-python lsp-ui lsp-mode dockerfile-mode add-node-modules-path all-the-icons counsel json-mode yaml-mode ag magit fish-mode markdown-mode rjsx-mode dracula-theme yasnippet-snippets js2-mode web-mode flycheck)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-face-highlight-read ((t (:inherit highlight :underline "dark gray")))))


(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
