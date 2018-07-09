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
  '(better-defaults
    ;;auto-complete
    elpy
    flycheck
    web-mode
    ;;tern
    ;;tern-auto-complete
    material-theme
    js2-mode
    ;;company-tern
    company
    tide
    neotree
    ))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; -------------------------------------
;; BASIC CUSTOMIZATION
;; -------------------------------------

(require 'auto-complete)
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(setq inhibit-startup-message t)
(load-theme 'material t)
(global-display-line-numbers-mode)
(elpy-enable t)
(global-auto-complete-mode t)
(scroll-bar-mode -1)
(tool-bar-mode  -1)
(tooltip-mode -1)
(menu-bar-mode -1)

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
(require 'tide)
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

;;(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))
;;(add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))

(add-hook 'js-mode-hook #'setup-tide-mode)
;;(flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "jsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
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
 '(package-selected-packages
   (quote
    (tern-auto-complete tide js2-mode web-mode material-theme flycheck elpy better-defaults)))
 '(safe-local-variable-values
   (quote
    ((eval add-to-list
	   (quote load-path)
	   (quote "/home/vasdee/work/dev/emacs/frontend/node_modules/tern/emacs/"))
     (eval setq exec-path
	   (append exec-path
		   (quote
		    ("/home/vasdee/work/dev/emacs/frontend/node_modules/tern/bin"))))
     (eval setenv "PATH"
	   (concat
	    (getenv "PATH")
	    ":/home/vasdee/work/dev/emacs/frontend/node_modules/tern/bin"))
     (setenv "PATH"
	     (concat
	      (getenv "PATH")
	      ":/home/vasdee/work/dev/emacs/frontend/node_modules/tern/bin"))
     (setq exec-path
	   (append exec-path
		   (quote
		    ("/home/vasdee/work/dev/emacs/frontend/node_modules/tern/bin"))))
     (setq exec-path
	   (append exec-path
		   (quote
		    ("/home/vasdee/work/dev/emacs/frontend/node_modules/tern"))))
     (setenv "PATH"
	     (concat
	      (getenv "PATH")
	      ":/home/vasdee/work/dev/emacs/frontend/node_modules/tern"))
     (setq exec-path
	   (append exec-path
		   (quote
		    ("frontend/node_modules/tern"))))
     (setenv "PATH"
	     (concat
	      (getenv "PATH")
	      ":frontend/node_modules/tern"))
     (setenv "PATH"
	     (concat
	      (getenv "PATH")
	      ":frontend/node_modules/tern/bin"))
     (setq exec-path
	   (append exec-path
		   (quote
		    ("frontend/node_modules/tern/bin"))))
     (setenv "PATH"
	     (concat
	      (getenv "PATH")
	      "frontend/node_modules/tern/bin"))
     (setq exec-path
	   (append exec-path
		   (quote
		    ("frontend/node_modules/tern/bin/"))))
     (eval pyvenv-activate "backend/venv")
     (eval pyvenv-activate "venv")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


