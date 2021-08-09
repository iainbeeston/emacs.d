;; load package
(require 'package)
;; add melpa to the list of package archives
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; load use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq-default use-package-always-ensure t ; Auto-download package if not exists
	      use-package-always-defer t) ; Always defer load package to speed up startup

;; install counsel (for ivy autocompletion and more)
(use-package counsel
  :init (ivy-mode +1))

;; install ag mode (for searching)
(use-package ag)

;; install magit mode (for git)
(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status)
  ;; speed up magit by not showing tags on the status screen
  :config (remove-hook 'magit-status-sections-hook 'magit-insert-tags-header))

;; install ag mode (for searching)
(use-package pcre2el)

;; install projectile mode (for opening any file within a project)
(use-package projectile
  :ensure t
  :init (projectile-mode +1)
  :bind (:map projectile-mode-map ("C-c p" . projectile-command-map)))

;; show scratch buffer on startup
(setq inhibit-startup-screen t)

;; disable menu bar
(menu-bar-mode -1)

;; enable mouse mode
(xterm-mouse-mode)
(global-set-key [mouse-4] 'previous-line)
(global-set-key [mouse-5] 'next-line)

;; configure linum
(global-linum-mode)
(setq linum-format "%4d ")

;; show the column number
(setq column-number-mode t)

;; enable copy-paste on the terminal
(defun pbpaste ()
  (shell-command-to-string "pbpaste"))
(defun pbcopy (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))
(when (not window-system)
  (setq interprogram-paste-function 'pbpaste)
  (setq interprogram-cut-function 'pbcopy))

;; cleanup trailing whitespace before saving
(add-hook 'before-save-hook 'whitespace-cleanup)

;; store file backups to the temp directory
(setq backup-directory-alist `((".*" . , temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" , temporary-file-directory t)))

;; rebind meta-3 to # (so # works on a mac keyboard)
(define-key key-translation-map (kbd "M-3") (kbd "#"))

;; don't insert encoding comments at the top of ruby files
(setq ruby-insert-encoding-magic-comment nil)
