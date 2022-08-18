(with-eval-after-load 'org
  ;; org-agenda
  (setq org-agenda-files '("~/.emacs.d/"))

  (setq org-src-fontify-natively t)

  ;; use org-capture to take notes
  (setq org-capture-templates
	'(("t" "Todo" entry (file+headline "~/.emacs.d/gtd.org" "工作安排与进展")
	   "* TODO [#B] %?\n %i\n" :empty-lines 1))))
;; highlight source code in in org-mode



(provide 'init-org)

