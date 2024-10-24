;; global settings
(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p) ; no yes-or-no prompts

(setq transient-mark-mode t) ; selection coloring and stuff

;(linum-relative-global-mode 'display-line-numbers-mode)
(global-display-line-numbers-mode)
(setq rm-blacklist '("undo-tree-mode"))
(smart-mode-line-enable)
(column-number-mode)

(drag-stuff-global-mode 1)
(define-key drag-stuff-mode-map (drag-stuff--kbd 'up) 'drag-stuff-up)
(define-key drag-stuff-mode-map (drag-stuff--kbd 'down) 'drag-stuff-down)
(define-key drag-stuff-mode-map (drag-stuff--kbd 'right) 'drag-stuff-right)
(define-key drag-stuff-mode-map (drag-stuff--kbd 'left) 'drag-stuff-left)

(toggle-scroll-bar -1) ; no scroll bar
(tool-bar-mode -1) ; no tool bar
(global-font-lock-mode t)
(auto-compression-mode 1) ; when editing compressed files, uncompress first
(setq indent-tabs-mode nil)
(icomplete-mode t) ; minibuffer completion

(setq show-paren-delay 0)
(show-paren-mode 1) ; always highlight matching parens
 
;; I'm always accidentally invoking set-fill-column and don't need it
(global-set-key "\C-xf" 'find-file)
;; I can't believe there isn't a convenient binding for goto-line by default
(global-set-key "\M-g" 'goto-line)
(global-set-key [f10]  'start-kbd-macro)
(global-set-key [f11]  'end-kbd-macro)
(global-set-key [f12]  'call-last-kbd-macro)
 
(require 'find-file-root)
 
;; but don't offer to autocomplete files with these extensions
(setq completion-ignored-extensions
  '(".o" ".elc" ".class" ".ps" ".pdf"))
 
;; instead of dropping ~-suffixed backups everywhere, keep them here instead
;; (this directory has to exist and be writable)
(setq backup-directory-alist '(("" . "~/.emacs.d/emacs-backup")))
 
(load-theme 'deeper-blue t)

;; make the screen blink for attention, also works with emacs -nw
(setq visible-bell t)

;; (set-message-beep 'silent) ; disable beep altogether

;; Determine in what mode header files should be opened
(add-to-list 'auto-mode-alist '("\\.h\\'" . c-c++-header))
;; yacc/bison files
(add-to-list 'auto-mode-alist '("\\.yy$" . c++-mode))
;; flex files
(add-to-list 'auto-mode-alist '("\\.ll$" . c-mode))
 
;; define some functions
(defun save-and-kill-buffer ()
  (interactive)
  (save-buffer)
  (kill-buffer nil))
;; bind C-c C-c - this conflicts with various programming modes
;; (which override it), should choose something else
(global-set-key "\C-c\C-c" 'save-and-kill-buffer)
 
;; make split-window-vertically put next buffer in new window
(defadvice split-window-vertically
  (after my-window-splitting-advice first () activate)
  (set-window-buffer (next-window) (other-buffer)))

;; replace some special unicode punctuation with "old-fashioned" ascii
;; punctuation
(defun de-unicode-punct-region (from to)
  "Convert some unicode punctuation to ascii equivalents"
  (interactive "r")
  (if (use-region-p)
      (save-excursion
	(let ((char-replace-list (list
				  '("“" . "\"")
				  '("”" . "\"")
				  '("″" . "\"")
				  '("‘" . "'")
				  '("—" . "-")
				  '("„" . "\"")
				  '("’" . "'"))))
	  (dolist (replace-pair char-replace-list)
	    (goto-char from)
	    (while (search-forward (car replace-pair) to t)
	      (replace-match (cdr replace-pair) nil t)))))))

;; a find-file-other-frame that opens a new frame for all files we want
(defun find-file-other-frames (filename &optional wildcards)
  "Edit file FILENAME, in another frame.
 
Like `find-file-other-frame', but creates a new frame for each
file."
  (interactive (find-file-read-args "Find file(s) in other frame(s): " nil))
  (let ((value (find-file-noselect filename nil nil wildcards)))
    (if (listp value)
	(progn
	  (setq value (nreverse value))
	  (cons (switch-to-buffer (car value))
		(mapcar 'switch-to-buffer-other-frame (cdr value))))
      (switch-to-buffer-other-frame value))))
 
;; replace the keybinding for find-file-other-frame
(define-key
  (current-global-map) [remap find-file-other-frame] 'find-file-other-frames)

(global-undo-tree-mode)

(provide 'SH-global) ; this tells .emacs that (require 'SH-global) is satisfied
