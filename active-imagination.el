;;; active-imagination.el -*- lexical-binding: t; -*-

;; Author: Joshua Jones <joshuacharjones@gmail.com>
;; Version: 0.1
;; Package-Requires: ((emacs "24.3"))
;; Keywords: org, imagination
;; URL: http://github.com/sneakyfish1/active-imagination.el


;;; Commentary:
;; This mode is to help you with active imagination

;;; Code:

;;;###autoload

(autoload 'org-set-property "org")
(autoload 'org-entry-get "org")

(define-minor-mode active-imagination-mode
  "A minor mode for active imagination."
  :lighter " AI"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "C-c C-d") 'ai-dialogue-with-entity)
            (define-key map (kbd "C-c C-e") 'ai-entity-initiates-dialogue)
            map)
  (if active-imagination-mode
      (active-imagination-update-properties)
    (message "Active Imagination mode disabled.")))

(defun active-imagination-update-properties ()
  "Ask for properties and update the current Org entry."
  (interactive)
  (let ((starting-feels (read-string "Enter starting feelings: "))
        (taken-place (read-string "Enter taken place: "))
        (entities-name (read-string "Enter entities name: ")))
    (org-set-property "starting_feelings" starting-feels)
    (org-set-property "theater" taken-place)
    (org-set-property "entities_name" entities-name)))

(defun active-imagination-dialogue-with-entity ()
  "Create a dialogue with the entity defined in the properties."
  (interactive)
  (let ((entity (org-entry-get nil "entities_name"))
        my-message entity-reply)
    (when entity
      (setq my-message (read-string (format "What do you say to %s: " entity)))
      (setq entity-reply (read-string (format "What is %s's reply? " entity)))
      (insert (format "Me: %s\n\n%s: %s\n\n" my-message entity entity-reply)))
    (unless entity
      (message "No entity name found in properties."))))

(defun active-imagination-entity-initiates-dialogue ()
  "Handle a situation where the entity initiates the dialogue."
  (interactive)
  (let ((entity (org-entry-get nil "entities_name"))
        entity-question my-reply)
    (when entity
      (setq entity-question (read-string (format "%s asks: " entity)))
      (setq my-reply (read-string "Your reply: "))
      (insert (format "%s: %s\n\nMe: %s\n\n" entity entity-question my-reply)))
    (unless entity
      (message "No entity name found in properties."))))

(provide 'active-imagination)
;;; active-imagination.el ends here
