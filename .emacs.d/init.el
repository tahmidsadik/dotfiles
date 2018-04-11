;; package management
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)

(add-to-list 'package-archives
	     '("org" . "https://orgmode.org/elpa") t)

(when (< emacs-major-version 24)
  (add-to-list 'package-archives
	       '("elpy" . "https://jorgenschaefer.github.io/packages/")
	       '("gnu" . "https://elpa.gnu.org/packages")))

(setq package-list
      '(use-package
	smex
	helm
	projectile
	smart-mode-line
	;;fuzzy file searching
	fzf
	;; auto completion engine
	company
	;;elixir stuff
	elixir-mode
	alchemist
	;;snippets
	yasnippet
	projectile
	;; file tree
	neotree
	;; icons yay
	all-the-icons))

(package-initialize)

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; disabling menubar, toolbar, scrollbar
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; helm-config
;; (require 'helm-config)
;; (global-set-key (kbd "M-i") 'helm-swoop)
;; (global-set-key (kbd "C-x b") 'helm-buffers-list)
(use-package helm-mode
  :config (helm-mode 1)
  :bind (("M-x" . 'helm-M-x)
	 ("M-y" . 'helm-show-kill-ring)
	 ("C-x C-f" . 'helm-find-files)
	 ("C-h i" . 'helm-info)
	 ("C-x C-d" . 'helm-browse-project)))

(use-package fzf
  :config 
  :bind
  ("M-t" . 'fzf-git-files)
  ("C-M-t" . 'fzf))

(use-package neotree
  :bind ("C-\\" . 'neotree-toggle))

;; neotree icon
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

(define-key helm-find-files-map "\t" 'helm-execute-persistent-action)

;; colors-themes
;; loading theme paths. Should add more themes later.
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;; font-config
(set-default-font "FiraCode Bold 13")

(add-hook 'elixir-mode-hook
	  (lambda ()
	    (company-mode)
	    (alchemist-mode)
	    (setq company-backends '((alchemist-company :with-company-yasnippet)))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
 '(custom-enabled-themes (quote (deeper-blue)))
 '(custom-safe-themes
   (quote
    ("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "54472f6db535c18d72ca876a97ec4a575b5b51d7a3c1b384293b28f1708f961a" default)))
 '(package-selected-packages
   (quote
    (neotree all-the-icons fzf yasnippet company-mode alchemist org-mode smart-mode-line use-package smex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
