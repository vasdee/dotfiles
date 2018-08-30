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
  '(elpy
    flycheck
    web-mode
    js2-mode
    rjsx-mode
    company
    tide
    neotree
    yasnippet
    dracula-theme
    find-file-in-project
    fish-mode
    ))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; -------------------------------------
;; BASIC CUSTOMIZATION
;; -------------------------------------
(require 'neotree)
(require 'yasnippet)
(require 'web-mode)
(require 'find-file-in-project)
(require 'tide)
(require 'find-dired)
(require 'yaml-mode)
(require 'json-mode)
(require 'ivy)
(require 'ag)

(yas-global-mode 1)
(global-set-key [f8] 'neotree-toggle)
(global-set-key (kbd "<C-f8>") 'neotree-show)
(global-display-line-numbers-mode)

;; IVY 
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")


(show-paren-mode 1)
(setq inhibit-startup-message t)
(load-theme 'tango-dark t)
(elpy-enable)
(scroll-bar-mode -1)
(tool-bar-mode  -1)
(tooltip-mode -1)
(menu-bar-mode -1)
;(setq display-line-numbers 'relative)
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq neo-window-fixed-size nil)
(setq neo-window-width 50)
(setq enable-local-eval t) ;; enable dir-locals evals without prompting
(setq truncate-lines t) ;; turn off line wrapping

;; Nicer window moving keys
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; Set a VSCode style find file in project lookup key
;(global-set-key (kbd "C-p") 'find-file-in-project-by-selected)
(global-set-key (kbd "C-c p") 'counsel-git)
(global-set-key (kbd "C-c o") 'ag-project-regexp)

(set-face-attribute 'default nil :height 100)

;; -----------------------------------
;; MARK DOWN
;; -----------------------------------
(setq markdown-command "pandoc")


;; ------------------------------------- 
;; dired configuration
;; -------------------------------------

;; When running dired-find
;;(setq find-ls-option '("-print0 | xargs -0 ls -h" . ""))

(setq find-ls-option '("-print0 | xargs -0 ls -lhd" . "-a"))
;;'(find-ls-option (quote ("-print0 | xargs -P4 -0 ls -ldN" . "-ldN")))
;; (setq find-ls-option (quote ("-path '*/.git*' -o -path '*/node_modules/*' -o -path '*/venv/*' -o -path '*/htmlcov/*' -o -path '*/.idea*' -prune -o -print0 | xargs -0 ls -ah" . "-l"))

;; relies on project-dir being set
(defun my-find-name-dired (pattern)
  "My version of find-name-dired that always starts in my chosen folder"
  (interactive "Find Name (file name wildcard): ")
  (find-name-dired project-dir pattern))


;; -------------------------------------
;; python configuration
;; -------------------------------------
;;(add-hook 'python-mode-hook
;;         (lambda ()
           ;; explicitly load company for the occasion when the deferred
                       ;; loading with use-package hasn't kicked in yet
;;            (company-mode)
;;            (add-to-list 'company-backends
;;                         (company-mode/backend-with-yas 'elpy-company-backend))))

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))  
;; -------------------------------------  


;; -------------------------------------
;; Javascript config
;; -------------------------------------
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))
  
(setq company-tooltip-align-annotations t)

;; configure javascript-tide checker to run after your default javascript checker

;(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))
;(add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))

(add-hook 'rjsx-mode-hook #'setup-tide-mode)

(add-hook 'js2-mode-hook (lambda () (setq js2-basic-offset 2)))
;;(flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))

(add-to-list 'auto-mode-alist '("\\.jsx$" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . rjsx-mode))

(add-hook 'json-mode-hook #'flycheck-mode)


(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "jsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))

(add-hook 'rjsx-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil) ;; use space instead of tabs
	    (setq js-indent-level 2) ;; 2 spaces
	    (setq js2-basic-offset 2) 
	    ;;(setq js2-strict-missing-semi-warning nil ) ;; disable the semi-colon warning
	    )
)

;; configure jsx-tide checker to run after your default jsx checker
(flycheck-add-mode 'javascript-eslint 'web-mode)
(flycheck-add-next-checker 'javascript-eslint 'jsx-tide 'append)


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
    (counsel json-mode yaml-mode ag magit fish-mode solarized-theme markdown-mode rjsx-mode dracula-theme yasnippet-snippets tide js2-mode web-mode flycheck elpy)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
