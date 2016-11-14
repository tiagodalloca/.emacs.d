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
            (brace        . "{")))

(when (maybe-require-package 'smartparens)
  (progn
    (use-package
      smartparens
      :init
      (progn
        (add-hook 'clojure-mode-hook 'smartparens-strict-mode)
        (add-hook 'emacs-lisp-mode-hook 'smartparens-strict-mode)
        (add-hook 'cider-repl-mode-hook 'smartparens-strict-mode)
        (unbind-key "\t"))
      :bind
      (:map smartparens-mode-map
       ("C-M-a" . sp-beginning-of-sexp)
       ("C-M-e" . sp-end-of-sexp)
       
       ("C-M-j"   . sp-down-sexp)
       ("C-M-i"   . sp-backward-up-sexp)
       ("C-j" . sp-backward-down-sexp)
       ("C-i" . sp-up-sexp)

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

       ("C-M-d" . sp-delete-sexp)
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
       ("C-c `"  . wrap-with-back-quotes)
       ("\t"  . indent-region))
      :config
      (progn
        (sp-pair "'" nil :actions :rem))
      :diminish 'smartparens-mode)))

(when (maybe-require-package 'highlight-parentheses)
  (use-package highlight-parentheses
    :config
    (progn
      (add-hook 'clojure-mode-hook #'highlight-parentheses-mode)
      (add-hook 'emacs-lisp-mode-hook #'highlight-parentheses-mode)
      (add-hook 'cider-repl-mode-hook #'highlight-parentheses-mode))))

(add-to-list 'auto-mode-alist '("\\.boot\\'" . clojure-mode))

(add-hook 'cider-repl-mode-hook #'electric-pair-mode)
(add-hook 'clojure-mode-hook #'electric-pair-mode)
(add-hook 'emacs-lisp-mode-hook #'electric-pair-mode)
