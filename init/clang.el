(require-package 'irony)
(require-package 'flycheck-irony)
(require-package 'company-irony)

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(setq w32-pipe-read-delay 0)

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
