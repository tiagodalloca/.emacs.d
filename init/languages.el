;;  ▄▄▄▄▄▄▄▄▄▄▄                         ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄
;; ▐░░░░░░░░░░░▌                       ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
;; ▐░█▀▀▀▀▀▀▀▀▀                        ▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌
;; ▐░▌                                 ▐░▌          ▐░▌       ▐░▌▐░▌       ▐░▌
;; ▐░▌                ▄▄▄▄▄▄▄▄▄▄▄      ▐░▌          ▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌
;; ▐░▌               ▐░░░░░░░░░░░▌     ▐░▌          ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
;; ▐░▌                ▀▀▀▀▀▀▀▀▀▀▀      ▐░▌          ▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀▀▀
;; ▐░▌                                 ▐░▌          ▐░▌          ▐░▌
;; ▐░█▄▄▄▄▄▄▄▄▄                        ▐░█▄▄▄▄▄▄▄▄▄ ▐░▌          ▐░▌
;; ▐░░░░░░░░░░░▌                       ▐░░░░░░░░░░░▌▐░▌          ▐░▌
;;  ▀▀▀▀▀▀▀▀▀▀▀                         ▀▀▀▀▀▀▀▀▀▀▀  ▀            ▀


(use-package irony :ensure
  :commands (c++-mode-hook
             c-mode-hook
             objc-mode-hook)
  :init
  (progn
    (add-hook 'c++-mode-hook 'irony-mode)
    (add-hook 'c-mode-hook 'irony-mode)
    (add-hook 'objc-mode-hook 'irony-mode)
    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
    (setq w32-pipe-read-delay 0)))

(use-package company-irony :ensure
  :commands irony-mode-hook
  :init
  (eval-after-load 'company
    '(add-to-list 'company-backends 'company-irony)))

(use-package flycheck-irony :ensure
  :commands irony-mode-hook
  :init
  (add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(use-package arduino-mode :ensure
  :defer t
  :init
  (progn
    (setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
    (autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)
    (eval-after-load 'irony
      '(progn
         (add-to-list 'irony-supported-major-modes 'arduino-mode)
         (add-to-list 'irony-lang-compile-option-alist '(arduino-mode . "c++"))
         ;; Turn-on irony-mode on arduino-mode (on .ino file).
         (add-hook 'arduino-mode-hook 'irony-mode)))))

;;  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄
;; ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
;;  ▀▀▀▀▀█░█▀▀▀ ▐░█▀▀▀▀▀▀▀▀▀
;;       ▐░▌    ▐░▌
;;       ▐░▌    ▐░█▄▄▄▄▄▄▄▄▄
;;       ▐░▌    ▐░░░░░░░░░░░▌
;;       ▐░▌     ▀▀▀▀▀▀▀▀▀█░▌
;;       ▐░▌              ▐░▌
;;  ▄▄▄▄▄█░▌     ▄▄▄▄▄▄▄▄▄█░▌
;; ▐░░░░░░░▌    ▐░░░░░░░░░░░▌
;;  ▀▀▀▀▀▀▀      ▀▀▀▀▀▀▀▀▀▀▀


(use-package js2-mode :ensure
  :defer t)

;;
;;  ▄            ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄
;; ▐░▌          ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
;; ▐░▌           ▀▀▀▀█░█▀▀▀▀ ▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌
;; ▐░▌               ▐░▌     ▐░▌          ▐░▌       ▐░▌
;; ▐░▌               ▐░▌     ▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌
;; ▐░▌               ▐░▌     ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
;; ▐░▌               ▐░▌      ▀▀▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀▀▀
;; ▐░▌               ▐░▌               ▐░▌▐░▌
;; ▐░█▄▄▄▄▄▄▄▄▄  ▄▄▄▄█░█▄▄▄▄  ▄▄▄▄▄▄▄▄▄█░▌▐░▌
;; ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌
;;  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀


(use-package cider :ensure
  :commands (clojure-mode-hook
             cider-repl-mode-hook)
  :init
  (progn
    (setq cider-popup-stacktraces nil)
    (setq nrepl-popup-stacktraces nil)))

(setq all-lisps
      '(clojure-mode-hook
        emacs-lisp-mode-hook
        cider-repl-mode-hook
        lisp-interaction-mode-hook))

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
            (double-quote . "\"")))

(use-package smartparens :ensure
  :commands all-lisps
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
  (sp-pair "'" nil :actions :rem)
  (sp-pair "`" nil :actions :rem)
  :diminish 'smartparens-mode)

(use-package highlight-parentheses :ensure
  :commands all-lisps
  :init
  (progn
    (add-hook 'clojure-mode-hook #'highlight-parentheses-mode)
    (add-hook 'emacs-lisp-mode-hook #'highlight-parentheses-mode)
    (add-hook 'cider-repl-mode-hook #'highlight-parentheses-mode))
  :diminish highlight-parentheses-mode)

(use-package aggressive-indent :ensure
  :commands all-lisps
  :init
  (progn
    (add-hook 'clojure-mode-hook #'aggressive-indent-mode)
    (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
    (add-hook 'cider-repl-mode-hook #'aggressive-indent-mode))
  :diminish t)

(add-to-list 'auto-mode-alist '("\\.boot\\'" . clojure-mode))

(add-hook 'cider-repl-mode-hook #'electric-pair-mode)
(add-hook 'clojure-mode-hook #'electric-pair-mode)
(add-hook 'emacs-lisp-mode-hook #'electric-pair-mode)

;;  ▄▄       ▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄    ▄  ▄▄▄▄▄▄▄▄▄▄  
;; ▐░░▌     ▐░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌  ▐░▌▐░░░░░░░░░░▌ 
;; ▐░▌░▌   ▐░▐░▌▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░▌ ▐░▌ ▐░█▀▀▀▀▀▀▀█░▌
;; ▐░▌▐░▌ ▐░▌▐░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░▌▐░▌  ▐░▌       ▐░▌
;; ▐░▌ ▐░▐░▌ ▐░▌▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌▐░▌░▌   ▐░▌       ▐░▌
;; ▐░▌  ▐░▌  ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░▌    ▐░▌       ▐░▌
;; ▐░▌   ▀   ▐░▌▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀█░█▀▀ ▐░▌░▌   ▐░▌       ▐░▌
;; ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌     ▐░▌  ▐░▌▐░▌  ▐░▌       ▐░▌
;; ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌      ▐░▌ ▐░▌ ▐░▌ ▐░█▄▄▄▄▄▄▄█░▌
;; ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░▌  ▐░▌▐░░░░░░░░░░▌ 
;;  ▀         ▀  ▀         ▀  ▀         ▀  ▀    ▀  ▀▀▀▀▀▀▀▀▀▀  
                                                            

(use-package markdown-mode :ensure
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "C:\\MMDw\\bin\\multimarkdown"))

;; ascii art:
;; http://patorjk.com/software/taag/
