;; (when (maybe-require-package "monokai")
;;   (use-package monokai
;;     :config
;;     (setq monokai-highlight-line "#3e3d32")))

(use-package ample-theme
  :config
  (progn
    (load-theme 'ample t t)
    (enable-theme 'ample)))
