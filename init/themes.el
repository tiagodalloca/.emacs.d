(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'monokai-theme)
    (package-install 'monokai-theme))

(setq monokai-highlight-line "#3e3d32")
(load-theme 'monokai t)
