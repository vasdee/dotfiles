;;; Core.el --- Summary
;;
;;; Commentary:
;;
;;; Code:

;; -------------------------------------------------------
;; Package management
;; -------------------------------------------------------
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

;; use-package is built-in since Emacs 29
(require 'use-package)
(setq use-package-hook-name-suffix nil)


;; Ensure var directory is defined (also in early-init.el)
(unless (boundp 'my/var-dir)
  (defconst my/var-dir (expand-file-name "var/" user-emacs-directory)
    "The central directory for package working files and data.")
  (make-directory my/var-dir t))

(use-package emacs
    :init
    ;; Initial buffer behaviour
    (setq initial-buffer-choice nil)
    (setq frame-title-format nil)

    ;; y/n instead of yes/no
    (setq use-short-answers t)
    (setq confirm-kill-emacs 'y-or-n-p)
    (defalias 'yes-or-no-p 'y-or-n-p)

    ;; No GUI dialogs
    (setq use-file-dialog nil)
    (setq use-dialog-box nil)
    (setq pop-up-windows t)

    ;; file handling and backups
    (setq enable-local-eval t)
    (setq make-backup-files nil)
    (setq auto-save-default nil)
    (setq create-lockfiles nil)

    ;; keep backup and save files in a dedicated directory
    ;; (~)
    (setq backup-directory-alist
        `((".*" . ,(expand-file-name "backup/" my/var-dir))))

    ;; Auto saves (#)
    (setq auto-save-file-name-transforms
        `((".*" ,(expand-file-name "auto-save/"  my/var-dir) t)))

    ;; Savehist (minibuffer history)
    (setq savehist-file (expand-file-name "history" my/var-dir))
    (savehist-mode 1)

    ;; Recentf (recent files/places)
    (setq recentf-save-file (expand-file-name "recentf" my/var-dir))
    (recentf-mode 1)

    ;; Save-place (cursor positions in files)
    (setq save-place-file (expand-file-name "places" my/var-dir))
    (save-place-mode 1)

    ;; Bookmarks
    (setq bookmark-default-file (expand-file-name "bookmarks" my/var-dir))
    (setq bookmark-save-flag 1)

    ;; Project list
    (setq project-list-file (expand-file-name "projects" my/var-dir))

     ;; default editing and fill
    (setq indent-tabs-mode nil)
    (global-hl-line-mode t)
    (show-paren-mode t)
    (setq fill-column 80)
    (setq confirm-nonexistent-file-or-buffer nil)

    ;; No bell notification
    (setq ring-bell-function 'ignore)
    (setq visible-bell 1)

    ;; Minor visual cleanups
    (setq indicate-empty-lines nil)
    (setq cursor-in-non-selected-windows nil)

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

    ;; UTF-8 everywhere
    (prefer-coding-system       'utf-8)
    (set-default-coding-systems 'utf-8)
    (set-terminal-coding-system 'utf-8)
    (set-keyboard-coding-system 'utf-8)
    (set-language-environment   'utf-8)

    ;; sometimes emacs will see variables blocks in hcl files as similar to dir-locals
    (add-to-list 'inhibit-local-variables-regexps "\\.hcl\\'")

    :bind
    ("C-x C-b" . 'ibuffer)

    :config
    (put 'upcase-region 'disabled nil)
    (put 'downcase-region 'disabled nil)

)

;(global-set-key (kbd "C-x C-b") 'ibuffer)

(provide 'core)

;;; core.el ends here
