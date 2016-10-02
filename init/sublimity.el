(when (maybe-require-package 'sublimity)
  (require 'sublimity)
  (require 'sublimity-scroll)
  (require 'sublimity-map)

  (add-hook 'sublimity-map-setup-hook
    (lambda ()
      (setq buffer-face-mode-face '(:family "Monospace"))
      (buffer-face-mode))))
