
(setq package-enable-at-startup nil)
;; minimal UI
(menu-bar-mode -1) ;; disables menubar
(tool-bar-mode -1) ;; disables toolbar
(scroll-bar-mode -1) ;; disables scrollbar
(tooltip-mode -1)
(column-number-mode 1)

(setq inhibit-splash-screen t ;; no thanks
      use-file-dialog nil ;; don't use system file dialog
      tab-bar-new-button-show nil ;; don't show new tab button
      tab-bar-close-button-show nil ;; don't show tab close button
      tab-line-close-button-show nil ;; don't show tab close button
      inhibit-startup-message t
      inhibit-startup-echo-area-message t
      )
;;; early-init.el ends here
