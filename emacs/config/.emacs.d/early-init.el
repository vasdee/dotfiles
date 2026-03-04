;;; early-init-.el starts

(setq package-enable-at-startup nil)
(setq gc-cons-threshold (* 300 1024 1024))
(setq byte-compile-warnings '(not obsolete))
(setq warning-suppress-log-types '((comp) (bytecomp)))
(setq native-comp-async-report-warnings-errors 'silent)
(setq inhibit-startup-echo-area-message (user-login-name))

(setq frame-resize-pixelwise t)

;; minimal UI
(menu-bar-mode -1) ;; disables menubar
(tool-bar-mode -1) ;; disables toolbar
(scroll-bar-mode -1) ;; disables scrollbar
(tooltip-mode -1)
(column-number-mode 1)

(setq inhibit-splash-screen t ;; no thanks
      use-file-dialog nil ;; don't use system file dialog
      tab-bar-close-button-show nil ;; don't show tab close button
      inhibit-startup-message t
      inhibit-startup-screen t
      initial-scratch-message nil
      inhibit-startup-echo-area-message t
      frame-inhibit-implied-resize t)

(setq default-frame-alist '((fullscreen . maximized)

                            ;; You can turn off scroll bars by uncommenting these lines:
                            ;; (vertical-scroll-bars . nil)
                            ;; (horizontal-scroll-bars . nil)

                            ;; Setting the face in here prevents flashes of
                            ;; color as the theme gets activated
                            (background-color . "#000000")
                            (foreground-color . "#ffffff")
                            (ns-appearance . dark)
                            (ns-transparent-titlebar . t)))
;;; early-init.el ends here
