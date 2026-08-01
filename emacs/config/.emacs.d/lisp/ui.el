;;; ui.el --- Summary
;;
;;; Commentary:
;;
;;; Code:

;; Nicer window moving keys
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings)

  )

;; smooth scrolling
(setq scroll-step           1
      scroll-conservatively 10000)

;;(defun font-available-p (font-name)
;;  (find-font (font-spec :name font-name)))
;;
;;;; Iosevka, Fira, Jetbrains Mono,
;;(cond
;;((font-available-p "Iosevka Nerd Font Mono")
;;  (set-frame-font "Iosevka Nerd Font Mono-10" nil t))
;; ((font-available-p "JetBrains Mono")
;;  (set-frame-font "JetBrains Mono-10" nil t))
;; ((font-available-p "Cascadia Code")
;;  (set-frame-font "Cascadia Code-12" nil t))
;; ((font-available-p "Hack")
;;  (set-frame-font "Hack-10" nil t))
;; ((font-available-p "DejaVu Sans Mono")
;;  (set-frame-font "DejaVu Sans Mono-12" nil t))
;; ((font-available-p "Inconsolata")
;;  (set-frame-font "Inconsolata-12" nil t)))


;; Set the default font.
;; For a list do fc-list
(set-face-attribute 'default nil
                    :family "Iosevka Nerd Font Mono"
                    :height 100
                    :weight 'normal)


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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package ace-window
  :ensure t
  :bind (("M-o" . ace-window))
)

(use-package display-fill-column-indicator
  :ensure nil
  :hook
  (((prog-mode-hook text-mode-hook) . (lambda()
                   ;(setq display-fill-column-indicator-column 140)
                   (display-fill-column-indicator-mode))))
)

(use-package display-line-numbers
  :ensure nil
  :hook
  (
   ((prog-mode-hook text-mode-hook conf-mode-hook) . (lambda () (display-line-numbers-mode t )))
  )
)

(use-package doom-modeline
  :ensure t
  :custom
    (doom-modeline-lsp t)
    (doom-modeline-buffer-file-name-style 'relative-to-project ) ; was 'truncate-with-project
    (doom-modeline-icon t)
    (doom-modeline-major-mode-icon t)
    (doom-modeline-major-mode-color-icon t)
    (doom-modeline-buffer-state-icon t)
    (doom-modeline-buffer-modification-icon t)
    (doom-modeline-buffer-encoding nil)
    (doom-modeline-workspace-name nil)
    (doom-modeline-enable-word-count nil)
    (doom-modeline-minor-modes nil)
  :hook (after-init-hook . doom-modeline-mode)
)


;; Show a nice hover box showing documentation via eldoc
(use-package eldoc-box
  :ensure t
  :hook (eglot-managed-mode-hook . eldoc-box-hover-at-point-mode) ; (lambda() (#'eldoc-box-help-at-point t))
)


;; important, run `nerd-icons-install-fonts` after first load
(use-package nerd-icons
    :ensure t
)


(use-package otpp
    :ensure t
    :after project
    :init
    (otpp-mode 1)
    (otpp-override-mode 1))


;; Make the tab-bar look more flat, like what's in neovim
(use-package vim-tab-bar
    :ensure t
    :commands vim-tab-bar-mode
    :hook
    (after-init-hook . vim-tab-bar-mode)
    :config
    (setq vim-tab-bar-show-groups t))



(provide 'ui)
;;; ui.el ends here
