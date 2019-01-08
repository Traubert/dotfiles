(defvar pmatch-highlights nil "first element for `font-lock-defaults'")

(setq pmatch-highlights
      '(("{[^}]+}" . font-lock-string-face)
	("![^\n]+" . font-lock-comment-face)
	("[dD]efine \\([1234567890abcdefghijklmnopqrstuvwxyxåäö_ABCDEFGHIJKLMNOPQRSTUVWXYZÅÖÄ]+\\)" . (1 font-lock-function-name-face))
	("Unlike\\|Like\\|Lit\\|Cap\\|OptCap\\|DownCase\\|UpCase\\|OptUpCase\\|OptDownCase\\|AnyCase\\|Explode\\|Implode\\|LC\\|RC\\|NLC\\|NRC\\|OR\\|AND\\|\\.t\\|\\.tag\\|\\.with\\|Lst\\|Exc\\|Interpolate\\|Sigma\\|Counter" . font-lock-builtin-face)
	("[dD]efine\\|DefFun\\|DefIns\\|regex\\|set\\|list\\|Ins\\|EndTag\\|Capture\\|@vec\\|@bin\\|@include\\|@txt\\|@stxt\\|@pl\\|@lexc\\|@re" . font-lock-keyword-face)
	("Alpha\\|UppercaseAlpha\\|LowercaseAlpha\\|Num\\|Punct\\|Whitespace" . font-lock-constant-face)
	("[1234567890\.]+" . font-lock-negation-char-face)
	("[1234567890abcdefghijklmnopqrstuvwxyxåäö_ABCDEFGHIJKLMNOPQRSTUVWXYZÅÖÄ]+" . font-lock-variable-name-face)))

(define-derived-mode pmatch-mode fundamental-mode "pmatch"
  "major mode for editing pmatch scripts."
  (setq font-lock-defaults '(pmatch-highlights)))

(provide 'pmatch-mode)
