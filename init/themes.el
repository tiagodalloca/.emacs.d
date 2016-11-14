;; (when (maybe-require-package "monokai")
;;   (use-package monokai
;;     :config
;;     (setq monokai-highlight-line "#3e3d32")))

(when (maybe-require-package 'ample-theme)
  (use-package ample-theme
    :init (progn (load-theme 'ample t t)
                 (load-theme 'ample-flat t t)
                 (load-theme 'ample-light t t)
                 (enable-theme 'ample))
    :defer t
    :diminish))
