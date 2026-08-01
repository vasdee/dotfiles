;; -*- lexical-binding: t; -*-
;;; tools.el --- Summary
;;
;;; Commentary:
;;
;;; Code:

;; LLM integration and coding assistance
(use-package agent-shell
    :ensure t
    :bind (("C-c a s" . agent-shell)                     ; Global launch/switch command
              ("C-c a k" . agent-shell-kiro-start-agent) ; Launch specific engine
              ("C-c a b" . agent-shell-switch-buffer)       ; Jump between active shells
              ("C-c a f" . agent-shell-ui-toggle-all-fragments))   ; Collapse/expand
)


(use-package csv-mode
  :ensure t
)

;; Dashboard startup screen
(use-package dashboard
    :ensure t
    :after (project nerd-icons)
    :init
    (setq dashboard-projects-backend          'project-el
          dashboard-icon-type                 'nerd-icons                ; or all-the-icons
          dashboard-center-content            t
          dashboard-display-icons-p           t
          dashboard-set-heading-icons         t
         dashboard-set-file-icons             t)
    (setq dashboard-items '((recents  . 5)
                            (bookmarks . 5)
                            (projects . 20)))
    (setq dashboard-item-shortcuts '((recents   . "r")
                                     (projects  . "p")
                                     (bookmarks . "m")))
    :config
    (require 'nerd-icons)
    (dashboard-setup-startup-hook)
)

;;(use-package dired
;;  :config
;;    (setq dired-listing-switches
;;        "-l --almost-all --human-readable --group-directories-first --no-group")
;;  ;; this command is useful when you want to close the window of `dirvish-side'
;;  ;; automatically when opening a file
;;  (put 'dired-find-alternate-file 'disabled nil)
;;)


(use-package dirvish
  :ensure t
  :init
    (dirvish-override-dired-mode)
  :custom
    (dirvish-attributes
        '(nerd-icons file-time file-size collapse subtree-state))
            ;; The order of these attributes is insignificant, they are always
            ;; displayed in the same position.
    (dired-listing-switches
        "-l --almost-all --human-readable --group-directories-first --no-group")
    :config
    (defun project-dired ()
        "Override the project-dired command to use dirvish"
        (interactive)
        (dirvish (project-root (project-current t))))
    (defun project-find-dir ()
        "override project.el function for dirvish in a directory inside the current project."
        (interactive)
        (let* ((project (project-current t))
                  (all-files (project-files project))
                  (completion-ignore-case read-file-name-completion-ignore-case)
                  ;; FIXME: This misses directories without any files directly
                  ;; inside.  Consider DIRS-ONLY as an argument for
                  ;; `project-files-filtered', and see
                  ;; https://stackoverflow.com/a/50685235/615245 for possible
                  ;; implementation.
                  (all-dirs (mapcar #'file-name-directory all-files))
                  (dir (funcall project-read-file-name-function
                           "Dired"
                           ;; Some completion UIs show duplicates.
                           (delete-dups all-dirs)
                           nil 'file-name-history)))
            (dirvish dir)))
  ;; Optional: Add configuration for specific features here.
  ;; For example, enabling the display of file/folder icons:
  ;; (add-hook 'dirvish-mode-hook #'dirvish-hide-details-mode) ; optional, hides file details for a cleaner look
  (setq dirvish-side-follow-mode t)
  (setq dirvish-side-follow-project-switch t)
  (setq dirvish-default-layout '(0 0.4 0.6))

  ;; Optional: Automatically delete old dired buffers
    (setq dirvish-buffers-max-size 10)
  :bind
    (("C-c f" . dirvish-side)
     ("C-x d" . dirvish-dwim)
     :map dirvish-mode-map
     ("?"   . dirvish-dispatch)          ; [?] a helpful cheatsheet
     ("f"   . dirvish-file-info-menu)    ; [f]ile info
     ("TAB" . dirvish-subtree-toggle))
  :hook
    ((dirvish-mode-hook . 'dirvish-hire-icons-mode)
     (dirvish-mode-hook . dirvish-peek-mode))
    ;(dirvish-mode-hook #'dirvish-garbage-collect-buffers)
)

(use-package editorconfig
  :ensure t
  :hook (( (prog-mode-hook text-mode-hook) . editorconfig-mode)
         )
)

;; LSP interface
(use-package eglot
    :ensure t
    :defer t
    :hook (((sh-mode-hook bash-ts-mode-hook) . eglot-ensure))
    :config
    (add-to-list 'eglot-server-programs
        '((bash-ts-mode sh-mode) . ("bash-language-server" "start")))
    (add-to-list 'eglot-server-programs
         '((ansible-mode) . ("rass" "--" "ansible-language-server" "--stdio" "--" "yaml-language-server" "--stdio")))

    (setf (alist-get 'yaml-mode eglot-server-programs)
        (lambda (interactive)
          (if (my/marker-file-in-project "ansible.cfg")
              '("rass" "--" "ansible-language-server" "--stdio" "--" "yaml-language-server" "--stdio")
            '("yaml-language-server" "--stdio"))))
)

;; For linting and on the fly syntax checking
(use-package flycheck
 :ensure t
 :config
   (setq flycheck-check-syntax-automatically '(mode-enabled save mode-enable))
    (flycheck-add-mode 'javascript-eslint 'web-mode)
   (add-to-list 'flycheck-disabled-checkers '(markdown-markdownlint-cli markdown-markdownlint-cli2 markdown-pymarkdown))
   (add-to-list 'flycheck-checkers 'markdown-mdl)
   (setq flycheck-markdown-mdl-executable "rumdl check")
   (global-flycheck-mode)
)

;; Important, this needs to be installed at the OS level
(use-package flyspell-mode
    :init
    (setq-default ispell-program-name "aspell")
    :hook
    (text-mode-hook . flyspell-mode)
)

(use-package ghostel
    :ensure t
    :bind (("C-x m" . ghostel)
         :map ghostel-semi-char-mode-map
         ("C-s"  . consult-line)
         ("C-k"  . my/ghostel-send-C-k-and-kill)
         ;; ;; I'm used to go up/down the shell history with M-n/p from eshell
         ;; ;; Simulate this behavior in ghostel by sending C-p and C-n
         ("M-p" . (lambda () (interactive) (ghostel-send-key "p" "ctrl")))
         ("M-n" . (lambda () (interactive) (ghostel-send-key "n" "ctrl")))
         :map project-prefix-map
         ("m" . ghostel-project)
         ("M" . ghostel-project-list-buffers))
    :config
    (defun my/ghostel-send-C-k-and-kill ()
    "Send `C-k' to ghostel. Like normal Emacs `C-k'.  Kill to end of line and put content in kill-ring."
    (interactive)
    (kill-ring-save (point) (line-end-position))
    (ghostel-send-key "k" "ctrl"))

    (add-to-list 'project-switch-commands '(ghostel-project "Ghostel") t)
    (add-to-list 'project-switch-commands '(ghostel-project-list-buffers "Ghostel buffers") t)
    (add-to-list 'ghostel-eval-cmds '("magit-status-setup-buffer" magit-status-setup-buffer))

    (defun my/fix-ghostel-emoji-rendering ()
        "Ensure Emacs maps package symbols and pictographs correctly inside ghostel."
        (let ((emoji-font "Noto Color Emoji")   ; Use "Noto Color Emoji" if you are running Linux
                 (nerd-font  "Iosevka Nerd Font Mono")) ; Fallback for regular developer font symbols

            ;; 1. Map the specific block containing the 📦 package symbol (0x1F4E6)
            (set-fontset-font t '(#x1f300 . #x1f5ff) (font-spec :family emoji-font))

            ;; 2. Double-check that your regular Nerd Font blocks are also bound
            (set-fontset-font t '(#xe000 . #xf2ff) (font-spec :family nerd-font))
            (set-fontset-font t '(#xf300 . #xf3ff) (font-spec :family nerd-font))
            (set-fontset-font t '(#xf400 . #xf8ff) (font-spec :family nerd-font))))

    :hook
    (after-init-hook . #'my/fix-ghostel-emoji-rendering))


;; Git interface
(use-package magit
    :ensure t
    :custom
    (magit-git-executable "/usr/bin/git")
    :bind (("C-x g" . magit-status))
)

(use-package move-text
  :ensure t
  :bind (("M-p" . move-text-up)
         ("M-n" . move-text-down))
  :config (move-text-default-bindings)
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
    ;;(setq project-switch-commands 'project-dired)
    (setq project-switch-commands
        '((project-find-file "Find file" "f")
          (project-find-dir "Find dir" "d")
          (project-dired "Dired" "D")
          (magit-project-status "Magit" "m") ; Requires magit
          (project-shell "Shell" "s")
          (project-eshell "Eshell" "e")))


    (defun my/project-discover-top-level ()
        "Recursively find projects under DIR, but stop descending once a root is found."
        (interactive)
       (let ((queue (list (expand-file-name (getenv "DEFAULT_CODE_DIR")))))
         (while queue
           (let ((current (pop queue)))
             (if-let ((proj (project-current nil current)))
                 ;; If this is a project, remember it and STOP recursing here
                 (project-remember-project proj)
               ;; If not a project, add its subdirectories to the queue to keep searching
               (dolist (file (directory-files current t))
                 (when (and (file-directory-p file)
                            (not (member (file-name-nondirectory file) '("." ".."))))
                   (push file queue))))))))

    (defun my/project-skip-external-buffers (window buffer _bury-or-kill)
      "Skip BUFFER if we are in a project and BUFFER doesn't belong to it."
      (let ((current-pr (project-current)))
        (if current-pr
            ;; We are in a project: skip any buffer not in this project
            (not (memq buffer (project-buffers current-pr)))
          ;; Not in a project: don't skip anything (normal behavior)
          nil)))

    (defun my/marker-file-in-project(marker-file)
        "Determine if the current project contain a (MARKER-FILE)."
        (interactive)
        (message "Looking for %s in " marker-file )
        (let* ((proj-root (if (project-current)                         ; Check if in a project
                            (project-root (project-current))
                              default-directory))                       ; Fallback to default-directory
                  (full-path (expand-file-name marker-file proj-root))) ; Construct full path
            (file-exists-p full-path)
        )
    )

    ;; Apply the filter
    (setq switch-to-prev-buffer-skip #'my/project-skip-external-buffers)

    ;; Recursively remember projects under the DEFAULT_CODE_DIR
    (my/project-discover-top-level)
)

;; Simple client for making REST requests
(use-package restclient
  :defer t
)

;; restructured text mode
(use-package rst
  :defer t
  :init
    (add-to-list 'auto-mode-alist '("\\.rst$" . rst-mode))
    (add-to-list 'auto-mode-alist '("\\.rest$" . rst-mode))
)

;; auto-enable treesitter modes, apart from yaml, which is not as good quite yet
(use-package treesit-auto
    :ensure t
    :custom
    (treesit-auto-install 'prompt)

    :config
    ; try just enabling all tree sitter, apart from yaml-mode
    ;(setq treesit-auto-langs '(python just bash sh dockerfile))
    ;(add-to-list 'global-treesit-auto-modes '(not yaml-mode))

    (delete 'yaml treesit-auto-langs)
    (global-treesit-auto-mode)
    ;(setq treesit-auto-install t)
)


(use-package which-key
  :ensure t
  :config
  (which-key-mode))


;; For inspecting certificates and private keys
(use-package x509-mode
 :ensure t
)


;; Snippet manager for creating and using custom code snippets
(use-package yasnippet
 :ensure t
 :config
   (yas-global-mode 1)
)


(provide 'tools)
;;; tools.el ends here
