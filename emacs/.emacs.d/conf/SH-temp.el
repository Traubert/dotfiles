(when (member "Segoe UI Emoji" (font-family-list))
  (set-fontset-font
    t 'symbol (font-spec :family "Segoe UI Emoji") nil 'prepend))

(defun detexify ()
  "Remove tex comments and put lines in paragraphs"
  
  (interactive)
  (beginning-of-buffer)
  (let ((due-for-linechange nil))
    (while (< (point) (point-max))
      (cond
       ;; remove any preceding spaces (they sometimes occur before comments)
       ((= (char-after) ? ) (delete-char 1))
       ;; kill comment lines (and the following newline) without affecting kill ring
       ((= (char-after) ?%) (kill-line 1) (setq kill-ring (cdr kill-ring)))
       ((= (char-after) ?\n)
	;; we're at a blank line - if we're due for a newline, delete the trailing
	;; space we've left and leave a blank line here - otherwise kill the blank
	(if due-for-linechange
	    (progn (setq due-for-linechange nil) (delete-backward-char 1) (insert ?\n) (next-line))
	  (progn (kill-line) (setq kill-ring (cdr kill-ring)))))
       ;; else: this is a regular line of text, so from now on we're due for a line change
       ;; in the case of blank lines. Delete the ending newline, add a space for the next line
       ;; of text.
       (t (setq due-for-linechange t) (end-of-line) (delete-char 1) (insert ? ))))
    (if due-for-linechange
	(delete-backward-char 1)))
  ;; next, remove some commands and handle titles
  (beginning-of-buffer) (replace-regexp "\\\\title{\\([^}]+\\)}" "\n\n\\1\n\n")
  (beginning-of-buffer) (replace-regexp "\\\\author{\\([^}]+\\)}" "\n\n\\1\n\n")
  (beginning-of-buffer) (replace-regexp "\\\\subsection\\*?{\\([^}]+\\)}" "\n\n\\1\n\n")
  (beginning-of-buffer) (replace-regexp "\\\\emph{\\([^}]+\\)}" "\\1")
  (beginning-of-buffer) (replace-regexp "\\\\begin\\(\\[.+\\]\\)?{[^}]+}" "")
  (beginning-of-buffer) (replace-regexp "\\\\end{[^}]*}" "")
  (beginning-of-buffer) (replace-regexp "\\\\date{[^}]*}" "")
  (beginning-of-buffer) (replace-regexp "\\\\maketitle" "")
  (beginning-of-buffer) (replace-regexp "\\\\pagebreak" "")
  (beginning-of-buffer) (replace-regexp "\\\\documentclass\\(\\[.+\\]\\)?{[^}]+}" "")
  (beginning-of-buffer) (replace-regexp "\\\\usepackage\\(\\[.+\\]\\)?{[^}]+}" "")
  (beginning-of-buffer) (replace-regexp "\\\\footnote{\\([^}]+\\)}" "\n\nfootnote:\\1\n\n")
  (beginning-of-buffer) (replace-regexp "``\\(\\([^']+'?\\)+\\)\'\'" "\"\\1\"")
  (beginning-of-buffer) (replace-regexp "`\\([^']+\\)'" "'\\1'")
  ;; remove trailing comments
  (beginning-of-buffer) (replace-regexp "\\([^\\]\\)%.+" "\\1")
  (beginning-of-buffer) (replace-string "\\\"a" "ä")
  (beginning-of-buffer) (replace-string "\\\"o" "ö")
  (beginning-of-buffer) (replace-string "\\\"u" "ü")
  (beginning-of-buffer) (replace-string "\\`e" "è")
  (beginning-of-buffer) (replace-string "\\'e" "é")
  )

  ;; (defun handle-line (due-for-linechange)
  ;;   (if (< (point) (point-max))
  ;; 	(progn (cond
  ;; 		;; remove any preceding spaces (they sometimes occur before comments)
  ;; 		((= (char-after) ? ) (delete-char 1))
  ;; 		;; kill comment lines (and the following newline) without affecting kill ring
  ;; 		((= (char-after) ?%) (kill-line 1) (setq kill-ring (cdr kill-ring)))
  ;; 		((= (char-after) ?\n)
  ;; 		 ;; we're at a blank line - if we're due for a newline, delete the trailing
  ;; 		 ;; space we've left and leave a blank line here - otherwise kill the blank
  ;; 		 (if due-for-linechange
  ;; 		     (progn (setq due-for-linechange nil) (delete-backward-char 1) (insert ?\n) (next-line))
  ;; 		   (progn (kill-line) (setq kill-ring (cdr kill-ring)))))
  ;; 		;; else: this is a regular line of text, so from now on we're due for a line change
  ;; 		;; in the case of blank lines. Delete the ending newline, add a space for the next line
  ;; 		;; of text.
  ;; 		(t (setq due-for-linechange t) (end-of-line) (delete-char 1) (insert ? )))
  ;; 	       ;; recurse
  ;; 	       (handle-line due-for-linechange))
  ;;     ;; finally: we may have inserted an extra space at the end of the buffer, delete it
  ;;     (if due-for-linechange
  ;; 	  (delete-backward-char 1))))

  ;; (interactive) (beginning-of-buffer) (handle-line nil))

(provide 'SH-temp)
