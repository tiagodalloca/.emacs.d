(require 'use-package)

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

(defmacro def-pairs (pairs)
  `(progn
     ,@(loop for (key . val) in pairs
          collect
            `(defun ,(read (concat
                            "wrap-with-"
                            (prin1-to-string key)
                            "s"))
                 (&optional arg)
               (interactive "p")
               (sp-wrap-with-pair ,val)))))

(def-pairs ((paren        . "(")
            (bracket      . "[")
            (brace        . "{")
            (single-quote . "'")
            (double-quote . "\"")
            (back-quote   . "`")))

(when (maybe-require-package 'smartparens)
  (progn
    (use-package
     smartparens-config
     :bind
     (("C-M-a" . sp-beginning-of-sexp)
      ("C-M-e" . sp-end-of-sexp)

      ("C-<down>" . sp-down-sexp)
      ("C-<up>"   . sp-up-sexp)
      ("M-<down>" . sp-backward-down-sexp)
      ("M-<up>"   . sp-backward-up-sexp)

      ("C-M-f" . sp-forward-sexp)
      ("C-M-b" . sp-backward-sexp)

      ("C-M-n" . sp-next-sexp)
      ("C-M-p" . sp-previous-sexp)

      ("C-S-f" . sp-forward-symbol)
      ("C-S-b" . sp-backward-symbol)

      ("C-<right>" . sp-forward-slurp-sexp)
      ("M-<right>" . sp-forward-barf-sexp)
      ("C-<left>"  . sp-backward-slurp-sexp)
      ("M-<left>"  . sp-backward-barf-sexp)

      ("C-M-t" . sp-transpose-sexp)
      ("C-M-k" . sp-kill-sexp)
      ("C-k"   . sp-kill-hybrid-sexp)
      ("M-k"   . sp-backward-kill-sexp)
      ("C-M-w" . sp-copy-sexp)

      ("C-M-d" . delete-sexp)

      ("M-<backspace>" . backward-kill-word)
      ("C-<backspace>" . sp-backward-kill-word)
      ([remap sp-backward-kill-word] . backward-kill-word)

      ("M-[" . sp-backward-unwrap-sexp)
      ("M-]" . sp-unwrap-sexp)

      ("C-x C-t" . sp-transpose-hybrid-sexp)

      ("C-c ("  . wrap-with-parens)
      ("C-c ["  . wrap-with-brackets)
      ("C-c {"  . wrap-with-braces)
      ("C-c '"  . wrap-with-single-quotes)
      ("C-c \"" . wrap-with-double-quotes)
      ("C-c _"  . wrap-with-underscores)
      ("C-c `"  . wrap-with-back-quotes))
     :ensure smartparens
     :config
     (progn
       (show-smartparens-global-mode t)))

    (add-hook 'clojure-mode-hook 'turn-on-smartparens-strict-mode)
    (add-hook 'cider-repl-mode-hook 'turn-on-smartparens-strict-mode)
    (add-hook 'emacs-lisp-mode-hook 'turn-on-smartparens-strict-mode)))



(when (maybe-require-package 'highlight-parentheses)
  (require 'highlight-parentheses)
  (add-hook 'clojure-mode-hook #'highlight-parentheses-mode)
  (add-hook 'emacs-lisp-mode-hook #'highlight-parentheses-mode)
  (add-hook 'cider-repl-mode-hook #'highlight-parentheses-mode))

(add-to-list 'auto-mode-alist '("\\.boot\\'" . clojure-mode))

(add-hook 'cider-repl-mode-hook #'electric-pair-mode)
(add-hook 'clojure-mode-hook #'electric-pair-mode)
(add-hook 'emacs-lisp-mode-hook #'electric-pair-mode)
