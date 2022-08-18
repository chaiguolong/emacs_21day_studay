(require 'cl)

(when (>= emacs-major-version 24)
  (require 'package)
  (setq package-archives '(("gnu-tuna"    .  "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			   ("melpa-tuna"  .  "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/"))))

;; add whatever package you want here
(defvar vincent/packages '(
			   company
			   dracula-theme
			   monokai-theme
			   gruvbox-theme
			   hungry-delete
			   counsel
			   swiper
			   smartparens
			   exec-path-from-shell
			   js2-mode
			   nodejs-repl
			   popwin
			   reveal-in-osx-finder
			   web-mode
			   js2-refactor
			   expand-region
			   iedit
			   org-pomodoro
			   ) "Default packages")
(setq package-selected-packages vincent/packages)

(defun vincent/packages-installed-p ()
  (loop for pkg in vincent/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))

(unless (vincent/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg vincent/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

;;;;;;;;; customize settings ;;;;;;;
;; if your OS is MacOXX, you need add below settings.
(when (memq window-system '(mac ns))
  (setq exec-path-from-shell-check-startup-files nil)
  (exec-path-from-shell-initialize))

(global-company-mode t)

;;config for web mode
(defun my-web-mode-indent-setup ()
  (setq web-mode-markup-indent-offset 2)     ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset 2)        ; web-mode, css in html file
  (setq web-mode-code-indent-offset 2)       ; web-mode, js code in html file
  )

(add-hook 'web-mode-hook 'my-web-mode-indent-setup)


(defun my-toggle-web-indent ()
  (interactive)
  ;; web development
  (if (or (eq major-mode 'js-mode) (eq major-mode 'js2-mode))
      (progn
	(setq js-indent-level (if (= js-indent-level 2) 4 2))
	(setq js2-basic-offset (if (= js2-basic-offset 2) 4 2))))

  (if (eq major-mode 'web-mode)
      (progn
	(setq web-mode-markup-indent-offset (if (= web-mode-markup-indent-offset 2) 4 2))
	(setq web-mode-css-indent-offset (if (= web-mode-css-indent-offset 2) 4 2))
	(setq web-mode-code-indent-offset (if (= web-mode-code-indent-offset 2) 4 2))))
  (if (eq major-mode 'css-mode)
      (setq css-indent-offset (if (= css-indent-offset 2) 4 2)))


  (setq indent-tabs-mode nil))





;; Popwin mode
(require 'popwin)
(popwin-mode t)

;; hungry-delete mode
(require 'hungry-delete)
(global-hungry-delete-mode)

;; ivy-mode
(ivy-mode t)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

(smartparens-global-mode t)
(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
;; Configure js2-mode for js files.
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode)
	 ("\\.html\\'" . web-mode)
	 )
       auto-mode-alist))

;;config for js2-refactor
(add-hook 'js2-mode-hook #'js2-refactor-mode)

(require 'org-pomodoro)

(provide 'init-packages)

