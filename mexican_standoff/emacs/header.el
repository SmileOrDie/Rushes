(defun valid_header ()
  (interactive)
  (save-excursion
	(setq valid t)
	;line 1
	(goto-line 1)
	(setq line (thing-at-point 'line))
	(if (not (string= line "/* ************************************************************************** */\n"))
	  (setq valid nil)
	  )
	;line 2
	(goto-line 2)
	(setq line (thing-at-point 'line))
	(if (not (string= line "/*                                                                            */\n"))
	  (setq valid nil)
	  )
	;line 3
	(goto-line 3)
	(setq line (thing-at-point 'line))
	(if (not (string= line "/*                                                        :::      ::::::::   */\n"))
	  (setq valid nil)
	  )
	;line 4
	(goto-line 4)
	(setq line (thing-at-point 'line))
	(if (not (string-match "^/\\* \\{3\\}.\\{1,42\\} \\{3\\} \\{6\\}\:\\+\: \\{6\\}\:\\+\: \\{4\\}\:\\+\: \\{3\\}\\*/\n$" line))
	  (setq valid nil)
	  )
	;line 5
	(goto-line 5)
	(setq line (thing-at-point 'line))
	(if (not (string= line "/*                                                    +:+ +:+         +:+     */\n"))
	  (setq valid nil)
	  )
	;line 6
	(goto-line 6)
	(setq line (thing-at-point 'line))
;	(if (not (string-match "" line))
;	  (setq valid nil)
;	  )
	;line 7
	(goto-line 7)
	(setq line (thing-at-point 'line))
	(if (not (string= line "/*                                                +#+#+#+#+#+   +#+           */\n"))
	  (setq valid nil)
	  )
	;line 8
	(goto-line 8)
	(setq line (thing-at-point 'line))
	(if (not (string-match "^/\\* \\{3\\}Created: 20[0-9]\\{2\\}/[0-1]\\{1\\}[0-9]\\{1\\}/[0-3]\\{1\\}[0-9]\\{1\\} [0-2]\\{1\\}[0-9]\\{1\\}\:[0-5]\\{1\\}[0-9]\\{1\\}\:[0-5]\\{1\\}[0-9]\\{1\\} by .\\{1,8\\} \\{3\\} \\{7\\}\#\\+\# \\{4\\}\#\\+\# \\{13\\}\\*/\n$" line))
	  (setq valid nil)
	  )
	;line 9
	(goto-line 9)
	(setq line (thing-at-point 'line))
	(if (not (string-match "^/\\* \\{3\\}Updated: 20[0-9]\\{2\\}/[0-1]\\{1\\}[0-9]\\{1\\}/[0-3]\\{1\\}[0-9]\\{1\\} [0-2]\\{1\\}[0-9]\\{1\\}\:[0-5]\\{1\\}[0-9]\\{1\\}\:[0-5]\\{1\\}[0-9]\\{1\\} by .\\{1,8\\} \\{3\\} \\{6\\}\#\\{3\\} \\{3\\}\#\\{8\\}\\.fr \\{7\\}\\*/\n$" line))
	  (setq valid nil)
	  )
	;line 10
	(goto-line 10)
	(setq line (thing-at-point 'line))
	(if (not (string= line "/*                                                                            */\n"))
	  (setq valid nil)
	  )
	;line 11
	(goto-line 11)
	(setq line (thing-at-point 'line))
	(if (not (string= line "/* ************************************************************************** */\n"))
	  (setq valid nil)
	  )
	valid
	)
  )

(defun header_chop_str (str n)
  (if (> (length str) n)
	(let* ((max (- n 3))
		   (new (substring str 0 max)))
	  (concat new "..."))
	str)
  )


(defun insert_filename ()
  (insert "/*   ")
  (setq filename (header_chop_str (file-name-nondirectory (buffer-file-name)) 41))
  (insert filename)
  (setq c (length filename))
  (while (< c 42)
		 (insert " ")
		 (setq c (1+ c))
		 )
  (insert "         :+:      :+:    :+:   */")
  )

(defun insert_by ()
  (insert "/*   ")
  (setq by (concat "By: " login " <" mail "> "))
  (insert by)
  (setq c (length by))
  (while (< c 42)
		 (insert " ")
		 (setq c (1+ c))
		 )
  (insert "     +#+  +:+       +#+        */")
  )

(defun insert_created ()
  (insert "/*   ")
  (setq creat_line (concat "Created: " (format-time-string "%Y/%m/%d %T") " by " login))
  (insert creat_line)
  (setq c (length creat_line))
  (while (< c 42)
		 (insert " ")
		 (setq c (1+ c))
		 )
  (insert "        #+#    #+#             */") 
  )

(defun insert_updated ()
  (insert "/*   ")
  (setq upd_line (concat "Updated: " (format-time-string "%Y/%m/%d %T") " by " login))
  (insert upd_line)
  (setq c (length upd_line))
  (while (< c 42)
		 (insert " ")
		 (setq c (1+ c))
		 )
  (insert "       ###   ########.fr       */") 
  )

(defun insert_header ()
  (interactive)
  (save-excursion
	(goto-char (point-min))
	(insert "/* ************************************************************************** */") (newline)
	(insert "/*                                                                            */") (newline)
	(insert "/*                                                        :::      ::::::::   */") (newline)
	(insert_filename) (newline)
	(insert "/*                                                    +:+ +:+         +:+     */") (newline)
	(insert_by) (newline)
	(insert "/*                                                +#+#+#+#+#+   +#+           */") (newline)
	(insert_created) (newline)
	(insert_updated) (newline)
	(insert "/*                                                                            */") (newline)
	(insert "/* ************************************************************************** */") (newline)
	)
  )

(defun update_header ()
  (interactive)
  (save-excursion
	(if (buffer-modified-p)
	  (progn
		(goto-char (point-min))
		(if (search-forward "Updated" nil t)
		  (progn
			(delete-region
			  (progn (beginning-of-line) (point))
			  (progn (end-of-line) (point)))
			(insert_updated)
			(message "Header up to date."))))))
  nil)


(defun header()
  (interactive)
  (if (valid_header) nil
	(insert_header)
	)
  )

(global-set-key (kbd "C-c h") 'header)

(setq write-file-hooks (cons 'update_header write-file-hooks))

(set 'login (let ((login (header_chop_str (getenv "USER") 8)))
			  (if (string= login nil)
				"marvin"
				login)
			  )
	 )

(set 'mail (let ((mail (header_chop_str (getenv "MAIL") 22)))
			 (if (string= mail nil)
			   "marvin@42.fr"
			   mail)
			 )
	 )
