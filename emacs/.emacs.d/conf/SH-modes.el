(defun c-c++-header ()
  "sets either c-mode or c++-mode, whichever is appropriate for
header"
  (interactive)
  (let ((c-file (concat (substring (buffer-file-name) 0 -1) "c")))
    (if (file-exists-p c-file)
        (c-mode)
      (c++-mode))))

;; C family
;; binds enter to newline-and-indent which is normally C-j
(add-hook 'c-mode-common-hook
	  (lambda()
	    (local-set-key (kbd "RET") 'newline-and-indent)
	    (setq indent-tabs-mode nil)
	    (setq c-indent-level 4)
	    (setq c-basic-offset 4)))

;; Indentation style for C-family code
(setq c-default-style
      '((c++-mode . "stroustrup") (c-mode . "k&r") (java-mode . "java")))
(setq c-basic-offset 4)
(c-set-offset 'innamespace 0)
 
(add-hook 'python-mode-hook
	  '(lambda ()
	     (setq python-indent 4)))

;; a find-file-other-frame for dired
(defun dired-find-file-other-frame ()
  "In dired, visit this file or directory in another frame."
  (interactive)
  (find-file-other-frame (dired-get-file-for-visit)))
(setq dired-load-hook
      (function
       (lambda ()
	 (define-key dired-mode-map "e" 'dired-find-file-other-frame))))

(require 'pmatch-mode)

(provide 'SH-modes)
