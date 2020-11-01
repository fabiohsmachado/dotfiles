;;;;;;;;; Package Management ;;;;;;;;;;
;; `MELPA'
(require 'package)
(add-to-list 'package-archives
 '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; `Use-Package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
;;;;;;;;;;

;;;;;;;;; Defaults ;;;;;;;;;;
(use-package emacs
  :config
  (setq inhibit-startup-screen t)
  (setq ring-bell-function 'ignore)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (toggle-scroll-bar -1)
  (defalias 'yes-or-no-p 'y-or-n-p)
)

(use-package display-line-numbers
  :hook (prog-mode . display-line-numbers-mode)
  :config
  (setq-default display-line-numbers-width 3))

(use-package "window"
  :config
  (setq split-width-threshold 140))

;;;;;;;;;;

;;;;;;;;;; Theme ;;;;;;;;;;
(use-package ewal-spacemacs-themes :ensure t
  :config
  (load-theme 'spacemacs-dark t))

(use-package treemacs-icons-dired
  :after treemacs dired
  :ensure t
  :config (treemacs-icons-dired-mode))

;; Disable modelines
(use-package delight :ensure t)
(use-package undo-tree :delight)
(use-package eldoc :delight)
;;;;;;;;;;

;;;;;;;;;; Ivy ;;;;;;;;;;
(use-package ivy :ensure t
  :delight
  :config
  (setq ivy-re-builders-alist
	'((counsel-M-x . ivy--regex-fuzzy)
	  (t . ivy--regex-ignore-order)))
  (setq ivy-use-virtual-buffers t)
  (ivy-mode 1))

(use-package ivy-hydra :ensure t
  :after (ivy hydra))

(use-package counsel :ensure t
  :delight
  :after ivy
  :hook (ivy-mode . counsel-mode))

(use-package swiper :ensure t
  :delight
  :after ivy)

(use-package ivy-rich :ensure t
  :delight
  :after ivy
  :custom
   (ivy-rich-path-style 'abbrev))
  :config

;; Run `M-x all-the-icons-install-fonts' on a fresh Linux install
(use-package all-the-icons-ivy-rich :ensure t
  :after ivy-rich
  :init (all-the-icons-ivy-rich-mode 1))

;;;;;;;;;; Keybindings ;;;;;;;;;;
(use-package evil :ensure t
  :delight
  :config (evil-mode 1))
(use-package evil-tutor :ensure t)
(use-package evil-numbers :ensure t)

(use-package which-key :ensure t
  :delight
  :config (which-key-mode 1))
	
(use-package general :ensure t
  :config
  (general-define-key
   :states '(normal visual insert emacs)
   :prefix "SPC"
   :non-normal-prefix "C-SPC"

   "/"   'swiper
   "TAB" '(switch-to-other-buffer :which-key "Previous Buffer")
   "u"   'undo-tree-visualize

   "b"   '(:ignore t :which-key "Buffers")
   "bb"	  'ivy-switch-buffer
   "bd"	  'kill-buffer-and-window
   "bk"   'kill-buffer
   "bs"	  'counsel-switch-buffer-other-window
   
   "f"   '(:ignore t :which-key "Files")
   "fb"  'counsel-bookmark
   "ff"  'counsel-find-file
   "fr"  'counsel-recentf

   "p"   '(:ignore t :which-key "Projects")
   "pf"  'projectile-find-file
   "pp"  'projectile-switch-project
   "pt"  'treemacs-select-window
   "p/"  'counsel-git-grep

   "w"   '(:ignore t :which-key "Windows")
   "wb"  'balance-windows
   "wd"  'delete-window
   "ww"  'other-window
   "wo"  'treemacs-delete-other-windows
   "w/"  'split-window-horizontally
   "w-"  'split-window-vertically

   "e"   '(:ignore t :which-key "Eval")
   "eb"  'eval-buffer
   "er"  'eval-region
   
   ;; Applications
   "d" 'dired
   "g" 'magit-status

   "m"   '(:ignore t :which-key "Markdown")
   "mp"  'markdown-preview
   "mt"  'markdown-toc-generate-or-refresh-toc
   "md"  'markdown-toc-delete-toc
  )

  (general-define-key
   :states '(visual emacs)

   "v" 'er/expand-region
  )

  (general-define-key
   "M-0" 'winum-select-window-0
   "M-1" 'winum-select-window-1
   "M-2" 'winum-select-window-2
   "M-3" 'winum-select-window-3
   "M-4" 'winum-select-window-4
   "M-5" 'winum-select-window-5
   "M-6" 'winum-select-window-6
   "M-7" 'winum-select-window-7
   "M-8" 'winum-select-window-8
   "M-9" 'winum-select-window-9
   "M-+" 'evil-numbers/dec-at-pt 
   "M--" 'evil-numbers/inc-at-pt
  )
)
;;;;;;;;;;

;;;;;;;;;; Essentials ;;;;;;;;;;
(use-package hydra :ensure t)

(use-package anzu :ensure t
  :config
  (global-anzu-mode +1))

(use-package wgrep :ensure t)

(use-package expand-region :ensure t)

(use-package magit :ensure t)

(use-package magit-gitflow :ensure t
  :after magit
  :hook (magit-mode . turn-on-magit-gitflow))

(use-package projectile :ensure t
  :init
  (setq projectile-completion-system 'ivy)
  :config
  (setq projectile-mode-line-function '(lambda () (format " [%s]" (projectile-project-name))))
  (projectile-mode 1))

(use-package winum :ensure t
  :config
  (winum-mode))

(use-package treemacs :ensure t
  :delight
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t))

(use-package treemacs-evil
  :after treemacs evil
  :ensure t)

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package treemacs-magit
  :after treemacs magit
  :ensure t)
;;;;;;;;;;

;;;;;;;;;; Text ;;;;;;;;;;
(use-package org
  :config
  (setq org-todo-keywords '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)")
                            (sequence "CODE(c)" "BLOCK(b)" "REVIEW(r)" "|" "FINISHED(f)")))
  (setq org-enforce-todo-checkbox-dependencies t)
  (setq org-enforce-todo-dependencies t)
  (setq org-refile-targets (quote ((nil :maxlevel . 2))))
  (setq org-refile-use-outline-path t)
  (setq org-outline-path-complete-in-steps nil)
  (setq org-confirm-babel-evaluate nil)
  (add-to-list
   'org-src-lang-modes '("plantuml" . plantuml))
  (org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t))))

(use-package plantuml-mode :ensure t
  :config
  (setq plantuml-default-exec-mode 'executable)
  (setq plantuml-output-type "png") ;;TODO: Remove when plantuml fixes bug for svg
  (setq org-plantuml-jar-path (expand-file-name "/usr/share/plantuml/plantuml.jar"))
)

(use-package markdown-mode :ensure t
  :mode (("\\.md\\'" . gfm-mode))
  :init
  (setq markdown-fontify-code-blocks-natively t)
  (setq markdown-command "pandoc")
  :config
  (defalias 'markdown-add-xhtml-header-and-footer 'as/markdown-add-xhtml-header-and-footer)
  (defun as/markdown-add-xhtml-header-and-footer (title)
    "Wrap XHTML header and footer with given TITLE around current buffer."
    (goto-char (point-min))
    (insert "<!DOCTYPE html5>\n"
	    "<html>\n"
	    "<head>\n<title>")
    (insert title)
    (insert "</title>\n")
    (insert "<meta charset=\"utf-8\" />\n")
    (when (> (length markdown-css-paths) 0)
      (insert (mapconcat 'markdown-stylesheet-link-string markdown-css-paths "\n")))
    (insert "\n</head>\n\n"
	    "<body>\n\n")
    (goto-char (point-max))
    (insert "\n"
	    "</body>\n"
	    "</html>\n"))
  )

(use-package markdown-toc :ensure t)
;;;;;;;;;;


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default)))
 '(ivy-rich-path-style (quote abbrev))
 '(package-selected-packages
   (quote
    (impatient-mode grip-mode markdown-toc vmd-mode markdown-preview-mode plantuml-mode markdown-mode evil-numbers expand-region evil-tutor magit-gitflow wgrep general which-key use-package winum treemacs-projectile treemacs-magit treemacs-icons-dired treemacs-evil neotree ivy-posframe ivy-hydra ewal-spacemacs-themes delight counsel anzu all-the-icons-ivy-rich))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
