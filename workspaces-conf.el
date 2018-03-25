(use-package perspeen
  :ensure t

  :config

  ;; overriding internal function - hack
  (defun perspeen-update-mode-string ()
  "Update `perspeen-modestring' when `perspeen-ws-list' is changed."
  (let* ((index 1)
	 (ws-name-list
	  (mapcar (lambda (ws)
		    (let* ((name (or (perspeen-ws-struct-name ws) "nil"))
			  (label (format "%d" index name)))
		      (setq index (1+ index))
		      (if (eq ws perspeen-current-ws)
			  (propertize label 'face 'perspeen-selected-face)
			(propertize label 'mouse-face 'mode-line-highlight))))
		  perspeen-ws-list)))
    (setq perspeen-modestring
	  (append (list (nth 0 perspeen-modestring-dividers)
			(mapconcat 'identity ws-name-list (nth 2 perspeen-modestring-dividers))
			(nth 1 perspeen-modestring-dividers))))))

  ;; new emtpy buffer
  (defun new-empty-buffer ()
    "Create a new empty buffer.
     New buffer will be named “untitled” or “untitled<2>”, “untitled<3>”, etc.
     It returns the buffer (for elisp programing)."
    (interactive)
    (let (($buf (generate-new-buffer "untitled")))
      (switch-to-buffer $buf)
      (funcall initial-major-mode)
      (setq buffer-offer-save t)
      $buf))

  ;; for shortcuts
  (defun goto-workspace-n (n) (perspeen-goto-ws n) (message "USG Ishimura %s" n))
  (defun goto-workspace-1 () (interactive) (goto-workspace-n 1))
  (defun goto-workspace-2 () (interactive) (goto-workspace-n 2))
  (defun goto-workspace-3 () (interactive) (goto-workspace-n 3))
  (defun goto-workspace-4 () (interactive) (goto-workspace-n 4))
  (defun goto-workspace-5 () (interactive) (goto-workspace-n 5))
  (defun goto-workspace-6 () (interactive) (goto-workspace-n 6))
  (defun goto-workspace-7 () (interactive) (goto-workspace-n 7))
  (defun goto-workspace-8 () (interactive) (goto-workspace-n 8))
  (defun goto-workspace-9 () (interactive) (goto-workspace-n 9))
  (defun goto-workspace-10 () (interactive) (goto-workspace-n 10))
  
  ;; configuration
  (setq perspeen-workspace-default-name "")
  (setq perspeen-modestring-dividers '("[" "]" ","))
  (perspeen-mode)
  (dotimes (_ 9 _)
    (perspeen-create-ws))
  (perspeen-goto-ws 1)
  (let ((new-buffer (new-empty-buffer)))
    (switch-to-buffer new-buffer)
    (markdown-mode)
    (insert
     "# We generate fears while we sit. We overcome them by action.\n"
     "# Security is mostly a superstition. Life is either a daring adventure or nothing.\n"
     "# Whether you think you can or think you can’t, you’re right.\n"
     "# You learn more from failure than from success. Don’t let it stop you. Failure builds character.\n"
     "# It’s not whether you get knocked down, it’s whether you get up.\n"
     "# People who are crazy enough to think they can change the world, are the ones who do.\n"
     "# Entrepreneurs are great at dealing with uncertainty and also very good at minimizing risk. That’s the classic entrepreneur.\n"
     "# Knowing is not enough; we must apply. Wishing is not enough; we must do.\n"
     "# Imagine your life is perfect in every respect; what would it look like?\n")))