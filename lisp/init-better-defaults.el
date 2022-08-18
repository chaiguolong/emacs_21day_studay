;; inhibit ring bell
(setq ring-bell-function 'ignore)

;; show line number
(global-linum-mode t)

;; selection delete
(delete-selection-mode t)

;; Auto-load file
(global-auto-revert-mode t)

;; no auto-backup and auto-save
(setq make-backup-files nil)
(setq auto-save-default nil)

;; show smarter parentheses
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
	(t (save-excursion
	     (ignore-errors (backward-up-list))
	     (funcall fn)))))

;; recentf-mode
(require 'recentf)
(recentf-mode t)
(setq recentf-max-menu-items 50)

;; abbrev-mode
(abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
					    ;; signature
					    ("vct" "vincent")
					    ;; emacs regex
					    ))


(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indented selected region."))
      (progn
        (indent-buffer)
        (message "Indented buffer.")))))

;; hippie expand is dabbrev expand on steroids
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))

;; less typing when Emacs ask you yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;; always delete and copy recursively
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)

(put 'dired-find-alternate-file 'disabled nil)

(require 'dired-x)

;; if there is a dired buffer displayed in the next window, use its
;; current subdir, instead of the current subdir of this dired buffer
(setq dired-dwim-target t)

(defun remove-dos-eol ()
  "Replace DOS eolns CR LF with UNIX eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match)))



;; Do What I Mean
(defun qoccur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
	    (buffer-substring-no-properties
	     (region-beginning)
	     (region-end))
	  (let ((sym (thing-at-point 'symbol)))
	    (when (stringp sym)
	      (regexp-quote sym))))
	regexp-history)
  (call-interactively 'occur))

(global-set-key (kbd "M-s o") 'qoccur-dwim)

(provide 'init-better-defaults)

