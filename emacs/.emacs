(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("45631691477ddee3df12013e718689dafa607771e7fd37ebc6c6eb9529a8ede5" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default))
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(apache-mode async bar-cursor bm boxquote browse-kill-ring color-theme-modern company compat counsel csv-mode dash diminish eproject folding graphviz-dot-mode helm helm-core htmlize initsplit ivy magit-section markdown-mode popup session smex swiper tabbar with-editor drag-stuff linum-relative php-mode use-package smart-mode-line nginx-mode python-black typescript-mode dockerfile-mode yaml-mode undo-tree magit))
 '(quack-default-program "csi"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; set load paths

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
    (add-to-list 'package-archives (cons "org" (concat proto "://orgmode.org/elpa/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/conf"))
;; for extra elisp packages
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
;; for personal elisp projects
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp-personal"))
 
;; load elisp customisations
(require 'SH-global)
(require 'SH-modes)
(require 'SH-temp)

