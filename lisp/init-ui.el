(tool-bar-mode 0)

(menu-bar-mode 0)

(scroll-bar-mode 0)

(load-theme 'gruvbox t)
;;(load-theme 'gruvbox-dark-hard t)

(setq inhibit-splash-screen t)
(setq-default cursor-type 'bar)

(global-hl-line-mode t)

(setq initial-frame-alist (quote ((fullscreen . maximized))))

(provide 'init-ui)
