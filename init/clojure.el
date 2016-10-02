(when (maybe-require-package 'clojure-mode)
  (require-package 'cljsbuild-mode)
  (require-package 'elein))

(when (maybe-require-package 'cider)
  (setq nrepl-popup-stacktraces nil))

; (when (maybe-require-package 'flycheck-clojure)
;   (eval-after-load 'flycheck '(flycheck-clojure-setup))
;   (add-hook 'after-init-hook #'global-flycheck-mode)
;   (when (maybe-require-package 'flycheck-pos-tip)
;     (eval-after-load 'flycheck
;       '(setq flycheck-display-errors-function #'flycheck-pos-tip-error-messages))))


(add-to-list 'load-path "~/.emacs.d/vendor/parinfer-mode/")
(require 'parinfer-mode)
(add-hook 'clojure-mode-hook #'parinfer-mode)
(add-hook 'emacs-lisp-mode-hook #'parinfer-mode)

(when (maybe-require-package 'highlight-parentheses)
  (require 'highlight-parentheses)
  (add-hook 'clojure-mode-hook #'highlight-parentheses)
  (add-hook 'emacs-lisp-mode-hook #'highlight-parentheses)
  (add-hook 'cider-repl-mode-hook #'highlight-parentheses))

(when (maybe-require-package 'clojure-snippets)
  (require 'clojure-snippets))

(add-to-list 'auto-mode-alist '("\\.boot\\'" . clojure-mode))

(add-hook 'cider-repl-mode-hook #'electric-pair-mode)
(add-hook 'clojure-mode-hook #'electric-pair-mode)
(add-hook 'emacs-lisp-mode-hook #'electric-pair-mode)
