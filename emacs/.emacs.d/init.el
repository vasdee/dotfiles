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
    zenburn-theme
    find-file-in-project
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

(yas-global-mode 1)
(global-set-key [f8] 'neotree-toggle)
(global-display-line-numbers-mode)

(show-paren-mode 1)
(setq inhibit-startup-message t)
(load-theme 'tango-dark t)
(elpy-enable)
(scroll-bar-mode -1)
(tool-bar-mode  -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
;; Set a VSCode style find file in project lookup key
(global-set-key (kbd "C-p") 'find-file-in-project-by-selected)
(set-face-attribute 'default nil :height 100)

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

(add-hook 'js-mode-hook #'setup-tide-mode)

(add-hook 'js2-mode-hook (lambda () (setq js2-basic-offset 2)))
;;(flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)

(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
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
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-safe-themes
   (quote
    ("190a9882bef28d7e944aa610aa68fe1ee34ecea6127239178c7ac848754992df" "a4df5d4a4c343b2712a8ed16bc1488807cd71b25e3108e648d4a26b02bc990b3" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(package-selected-packages
   (quote
    (solarized-theme markdown-mode rjsx-mode dracula-theme yasnippet-snippets tide js2-mode web-mode flycheck elpy)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(safe-local-variable-values
   (quote
    ((eval progn
	   (require
	    (quote find-file-in-project))
	   (setq ffip-prune-patterns
		 (\`
		  ("*/venv/*"
		   (\, "*/node_modules/*")))))
     (eval neotree-change-root "/home/vasdee/work/dev/crew_rostering/")
     (eval neotree-change-root @ffip-project-root)
     (eval setq ffip-prune-patterns
	   (\`
	    ("*/venv/*"
	     (\, @ffip-prune-patterns))))
     (setq ffip-prune-patterns
	   (\`
	    ("*venv*"
	     (\,@ ffip-prune-patterns))))
     (setq ffip-prune-patterns
	   (\`
	    ("venv"
	     (\,@ ffip-prune-patterns))))
     (setq ffip-prune-patterns
	   (\`
	    ("backend/venv/*"
	     (\,@ ffip-prune-patterns))))
     (setq ffip-prune-patterns
	   (\`
	    ("*/venv/*"
	     (\,@ ffip-prune-patterns))))
     (eval progn
	   (require
	    (quote find-file-in-project))
	   (setq ffip-prune-patterns
		 (\`
		  ("*/venv/*"
		   (\, @ffip-prune-patterns)))))
     (eval progn
	   (require
	    (quote find-file-in-project))
	   (setq ffip-prune-patterns
		 (\`
		  ("*/venv/*"
		   (\, "*/node_modules/*")
		   (\,@ ffip-prune-patterns)))))
     (eval neotree-change-root
	   (quote ffip-project-root))
     (eval setq tide-tsserver-directory "/home/vasdee/work/dev/crew_rostering/frontend/node_modules/typescript/lib/")
     (eval setq tide-tsserver-executable "/home/vasdee/work/dev/crew_rostering/frontend/node_modules/typescript/bin/tsserver")
     (neotree-change-root "/home/vasdee/work/dev/crew_rostering")
     (eval neotree-change-root "/home/vasdee/work/dev/crew_rostering")
     (eval setq elpy-set-project-root "/home/vasdee/work/dev/crew_rostering/backend/")
     (eval pyvenv-activate "/home/vasdee/work/dev/crew_rostering/backend/venv/")
     (eval neotree-dir "/home/vasdee/work/dev/crew_rostering")
     (eval setq elpy-set-project-root "backend")
     (eval neotree-dir ".")
     (eval add-to-list
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


(put 'upcase-region 'disabled nil)
