;; NOT WELCOME SCREEN
(setq inhibit-startup-screen t)

;;TABS
(setq-default indent-tabs-mode nil)
(setq tab-width 2)

;; FONTS
(set-default-font "Consolas 13")
(require-package 'default-text-scale)
(global-set-key (kbd "C-M-=") 'default-text-scale-increase)
(global-set-key (kbd "C-M--") 'default-text-scale-decrease)

;; do not confirm a new file or buffer
(setq confirm-nonexistent-file-or-buffer nil)
(require 'ido)
(ido-mode 1)
(ido-everywhere 1)
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(setq ido-enable-tramp-completion nil)
(setq ido-enable-last-directory-history nil)
(setq ido-confirm-unique-completion nil) ;; wait for RET, even for unique?
(setq ido-show-dot-for-dired t) ;; put . as the first item
(setq ido-use-filename-at-point t) ;; prefer file names near point

;; ENCONDING
(prefer-coding-system 'utf-8)

;; LINE NUMBERS
(global-linum-mode)

;; MAXIMIZED SCREEN
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

;; TEMP FILES LOCATION
(setq auto-save-file-name-transforms
  `((".*" ,(concat user-emacs-directory "~/auto-save-list/") t)))
(setq backup-directory-alist `(("." . "~/auto-save-list/")))
