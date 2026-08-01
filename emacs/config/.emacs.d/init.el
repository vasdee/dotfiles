;;; init.el --- Summary
;;; Commentary:
;;; init-.el starts
;;; Code:

;; Following chadmacs conventions, separate config and language specific stuff into directories
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "lang" user-emacs-directory))

(require 'core)
(require 'ui)
(require 'tools)
(require 'navigation)
(require 'themes)

;; Custom language package includes
(require 'ansible-lang)
(require 'just-lang)
(require 'rust-lang)
(require 'python-lang)
(require 'docker-lang)
(require 'yaml-lang)
(require 'json-lang)
(require 'markdown-lang)
;(require 'web-lang)
;(require 'terraform-lang)
;(require 'sql-lang)

;; load a specifc theme from themes
(load-theme 'doom-one t)

;;----------------------------------------------------------------------------------------------------------------------
;; Custom Functions Configurations
;;----------------------------------------------------------------------------------------------------------------------

(defun my/base64-encode-region-no-break ()
  "Base 64 encode a region and ignore the line break."
  (interactive)
  (base64-encode-region (mark) (point) t))

(defun my/reload-dotemacs-file ()
  "Reload your .emacs file without restarting Emacs."
  (interactive)
  (load-file "~/.emacs.d/init.el")
)

(provide 'init)
;;; init.el ends here
