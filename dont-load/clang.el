(when (maybe-require-package 'irony)
  (progn
      (when (maybe-require-package 'flycheck-irony))
      (when (maybe-require-package 'company-irony)
        (eval-after-load 'company
          '(add-to-list 'company-backends 'company-irony)))
      (maybe-require-package 'irony-server)
      (maybe-require-package 'irony-cdb)))
