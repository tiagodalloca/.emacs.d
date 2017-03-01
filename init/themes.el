;; (when (maybe-require-package "monokai")
;;   (use-package monokai
;;     :config
;;     (setq monokai-highlight-line "#3e3d32")))

(use-package darktooth-theme :ensure
	:config
	(progn
		(load-theme 'darktooth-theme t t)
		(enable-theme 'darktooth-theme)))

;; (use-package ample-theme :ensure
;; 	:config
;; 	(progn
;; 		(load-theme 'ample t t)
;; 		(enable-theme 'ample)))
