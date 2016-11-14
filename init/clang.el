 (when (maybe-require-package 'irony)
  (use-package irony
    :config
    (progn
      (add-hook 'c++-mode-hook 'irony-mode)
      (add-hook 'c-mode-hook 'irony-mode)
      (add-hook 'objc-mode-hook 'irony-mode)
      (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
      (setq w32-pipe-read-delay 0))))

(when (maybe-require-package 'company)
  (use-package company
    :config
    (add-to-list 'company-backends 'company-irony)))

(when (maybe-require-package 'flycheck-irony)
  (use-package flycheck
    :config
    (add-hook 'flycheck-mode-hook #'flycheck-irony-setup)))

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
