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


(use-package eldoc
    :ensure nil ; built in
    :config
    (global-eldoc-mode -1)
    ;; never let eldoc expand the echo area or push text lines up
    (setq eldoc-echo-area-use-multiline-p nil)
    ;; Completely mute Eldoc's window/buffer display functions
    (setq eldoc-display-functions nil)
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

;; Display one tab per project, and a default tab called *dashboard*
(use-package otpp
    :ensure t
    ;:vc (:url "/home/millrt9/code/private/github.com/vasdee/one-tab-per-project")
    :after project
    :init
    ;; open files in a new project, or switch to an open project if the tab already exists
    (setq otpp-find-file-integration t)
    (setq otpp-default-tab-name "*dashboard*")
    (setq switch-to-prev-buffer-skip #'otpp-skip-external-buffers)
    :config
    (otpp-mode 1)
    (otpp-override-mode 1)
)

;; Shows a separate tab bar, underneath otpp which shows only project related buffers
(use-package tab-line
    :ensure nil
    :after otpp
    :config

    (defun my/tab-line-project-buffers ()
        "Return project buffers that are also in the default tab-line buffers."
        (if-let* ((pr (project-current))
                  (project-bufs (project-buffers pr))
                  (default-bufs (tab-line-tabs-window-buffers)))
            ;; Only show buffers that are in both the project and default list
            (seq-intersection project-bufs default-bufs)
            ;; Fallback to the default tab-line function
            (tab-line-tabs-window-buffers)))


    ;; Configure before enabling, so the first redisplay already uses these.
    (setq tab-line-tab-name-function #'tab-line-tab-name-truncated-buffer     ; Enable truncation logic
        tab-line-tab-name-truncated-max 12                                    ; Set max character length
        tab-line-tab-name-ellipsis "…"                                        ; Character to append when cut off
        tab-line-new-button-show nil                                          ; don't show the new + button a tab
        ;; this should filter out non project buffers, but it doesn't quite work
       tab-line-tabs-function #'my/tab-line-project-buffers
        )

    (global-tab-line-mode 1)

    ;; only activate tab-line mode after project.el has opened a buffer within the project.
    ;; this avoids the situation where tab-line mode inherits a buffer from the currently active buffer and
    ;; drags it into the new project tab-line
    ;;(advice-add 'project-switch-project :after
    ;;    (lambda (&rest _)
    ;;        (when (project-current)
    ;;            (tab-line-mode 1))))

    :bind
    ("C->" . 'tab-line-switch-to-next-tab)
    ("C-<" . 'tab-line-switch-to-prev-tab)
)

;; enable nerd icons within tab line mode tabs
(use-package tab-line-nerd-icons
    :ensure t
    :config
    (tab-line-nerd-icons-global-mode 1)
)

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
