(when (maybe-require-package 'arduino-mode)
  (progn
    (setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
    (autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)
    (use-package irony
      :config
      (progn
        (add-to-list 'irony-supported-major-modes 'arduino-mode)
        (add-to-list 'irony-lang-compile-option-alist '(arduino-mode . "c++"))
        ;; Turn-on irony-mode on arduino-mode (on .ino file).
        (add-hook 'arduino-mode-hook 'irony-mode)))))
