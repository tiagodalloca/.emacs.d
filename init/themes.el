(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'monokai-theme)
    (package-install 'monokai-theme))

(load-theme 'monokai t)
