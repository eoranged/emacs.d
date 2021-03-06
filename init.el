(defconst old-gc-cons-threshold gc-cons-threshold)
(setq gc-cons-threshold most-positive-fixnum)
(add-hook
 'emacs-startup-hook
 (lambda ()
   (let ((startup-time (float-time (time-subtract after-init-time before-init-time))))
     (message "Emacs ready in %.2f seconds with %d garbage collections." startup-time gcs-done))
   (setq gc-cons-threshold old-gc-cons-threshold)))

(require 'package)

;; Should be done as early as possible
(when (package-installed-p 'no-littering)
  (require 'no-littering))

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("marmalade" . "https://marmalade-repo.org/packages/")
        ;;("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")
        ("melpa-stable" . "http://stable.melpa.org/packages/")))

(package-initialize)

;; make sure that all data is placed properly
(unless (package-installed-p 'no-littering)
  (package-refresh-contents)
  (package-install 'no-littering)
  (require 'no-littering))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(org-babel-load-file (expand-file-name (locate-user-emacs-file "myinit.org")))

