(eval-after-load 'company
  '(progn 
  	  (setq company-backends (delete 'company-semantic company-backends))
  	  (add-hook 'c++-mode-hook 
  	  	(lambda ()
  	  	  (local-set-key (kbd "tab") 'company-complete)))
  	  (add-hook 'c-mode-hook 
  	  	(lambda ()
  	  	  (local-set-key (kbd "tab") 'company-complete)))))

(when (maybe-require-package 'irony)
  (progn
      (maybe-require-package 'flycheck-irony)
      (maybe-require-package 'irony-server)))

(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
