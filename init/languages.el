;; WEB

;; (use-package js2-mode
;;   :ensure t
;;   :pin gnu
;;   :defer t)

(use-package coffee-mode :ensure
	:defer t)

(use-package php-mode :ensure
  :defer t)

(use-package web-mode :ensure
	:defer t
	:init
	(progn (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
				 (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
				 (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
				 (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
				 (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
				 (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
				 (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode)))
	:config
	(progn (setq web-mode-markup-indent-offset 2)))

(use-package emmet-mode :ensure
  :defer t
	:bind
	(:map emmet-mode-keymap
				("C-." . emmet-expand-line))
	:init
	(progn (add-hook 'html-mode-hook #'emmet-mode)
				 (add-hook 'css-mode-bind #'emmet-mode)
				 (add-hook 'html-mode-hook #'emmet-mode)
				 (add-hook 'css-mode-bind #'emmet-mode)
				 (add-hook 'web-mode-hook #'emmet-mode)))

(use-package sass-mode :ensure
	:defer t)

(use-package ruby-mode
	:init
	(setq ruby-deep-indent-paren nil))

(use-package inf-ruby :ensure
	:defer t)

(use-package robe :ensure
	:defer t
	:commands (ruby-mode-hook))

;; PYTHON

(use-package elpy :ensure
	:init (progn (elpy-enable)
							 (setq python-shell-interpreter "python3"
										 python-shell-interpreter-args "-i"))
  :defer t)

;; LISP IN GENERAL


(defun clear-repl ()
  (interactive)
  (cider-clear-repl-buffer nil t))

(use-package clojure-mode
  :pin melpa-stable
  :ensure t
  :defer t
	:after '(flycheck-clj-kondo)
  :config
  (progn (require 'clojure-mode-extra-font-locking)
				 (define-clojure-indent
					 (defroutes 'defun)
					 (GET 2)
					 (POST 2)
					 (PUT 2)
					 (DELETE 2)
					 (HEAD 2)
					 (ANY 2)
					 (context 2))
				 (clj-refactor-mode 1)
				 (require 'flycheck-clj-kondo)))

(use-package flycheck-clj-kondo
  :ensure t
	:defer t)

(global-unset-key (kbd "C-x j"))
(use-package clj-refactor :ensure t :pin melpa-stable
	:defer t
	:commands (clojure-mode-hook)
	:config
	(progn
		(cljr-add-keybindings-with-prefix "C-x j r"))
	:diminish clj-refactor-mode)

(use-package cider :ensure
  :commands (clojure-mode-hook
             cider-repl-mode-hook)
  :init
  (progn
    (setq cider-popup-stacktraces nil)
    (setq nrepl-popup-stacktraces nil))
  :bind
  (("C-x j R" . cider-refresh)
   ("C-x j u" . cider-user-ns)
   ("C-x j c" . cider-repl-clear-buffer))
  :diminish cider-mode)

(setq all-lisps
      '(clojure-mode-hook
				emacs-lisp-mode-hook
        cider-repl-mode-hook
        lisp-interaction-mode-hook))

(defmacro def-pairs (pairs)
  `(progn
     ,@(cl-loop for (key . val) in pairs
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
	:defer t
	:init
	(progn (smartparens-global-mode)
				 (set 'sp-escape-quotes-after-insert nil)
				 (sp-with-modes '(clojure-mode emacs-lisp-mode cider-repl-mode)
					 (sp-local-pair "'" nil :actions nil)
					 (sp-local-pair "`" "'" :when '(sp-in-string-p sp-in-comment-p)))
         (add-to-list 'emulation-mode-map-alists
                      `((smartparens-mode . ,smartparens-mode-map))))
  :bind
  (:map smartparens-mode-map
        ("C-M-a" . sp-beginning-of-sexp)
        ("C-M-e" . sp-end-of-sexp)

        ("C-M-j"   . sp-down-sexp)
        ("C-M-i"   . sp-backward-up-sexp)
        ("C-S-j" . sp-backward-down-sexp)
        ("C-S-i" . sp-up-sexp)


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
  :diminish 'smartparens-mode)

(define-globalized-minor-mode
	global-highlight-parentheses-mode
	highlight-parentheses-mode
  (lambda () (highlight-parentheses-mode 1)))

(use-package highlight-parentheses :ensure
	:init (global-highlight-parentheses-mode)
  :diminish global-highlight-parentheses-mode)

(use-package aggressive-indent :ensure
	:defer t
  :init
  (aggressive-indent-global-mode)
  :diminish aggressive-indent-mode)

(use-package lsp-mode :ensure
  :defer
  :config
  (setq lsp-lens-enable t
        lsp-signature-auto-activate nil
        lsp-enable-indentation nil
        lsp-completion-enable nil)
  :hook
  ((clojure-mode . lsp)
   (clojurescript-mode . lsp)
   (clojurerc-mode . lsp)))

(add-to-list 'auto-mode-alist '("\\.boot\\'" . clojure-mode))

;; MARKDOWN


(use-package markdown-mode :ensure
	:defer t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)))

;; HASKELL

(use-package haskell-mode :ensure :defer t
  :commands (haskell-mode)
  :init
  (progn
    (aggressive-indent-mode 0)))

;;TYPESCRIPT

(use-package typescript-mode :ensure)

(use-package tide :ensure :defer t
	:after (typescript-mode company flycheck)
	:hook ((typescript-mode . tide-setup)
				 (typescript-mode . tide-hl-identifier-mode)))

;; ascii art:
;; http://patorjk.com/software/taag/


;; ???


(defun my-pretty-chars ()
  "make some word or string show as pretty Unicode symbols"
  (setq prettify-symbols-alist
        '(("lambda" . 955)
					("fn"  . 955)
					;; ("->"  . 8594)
					;; ("->>" . 8658)
					;; ("=>"  . 8658)
					)))

(global-prettify-symbols-mode t)
(add-hook 'clojure-mode-hook 'my-pretty-chars)
(add-hook 'lisp-mode-hook 'my-pretty-chars)
(add-hook 'elisp-mode-hook 'my-pretty-chars)
(add-hook 'lisp-interaction-mode-hook 'my-pretty-chars)
(add-hook 'haskell-mode-hook 'my-pretty-chars)
(add-hook 'javascript-mode-hook 'my-pretty-chars)
(add-hook 'shen-mode-hook 'my-pretty-chars)
(add-hook 'tex-mode-hook 'my-pretty-chars)
(add-hook 'typescript-mode-hook 'my-pretty-chars)
