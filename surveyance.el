;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Surveyance: see a directory of source files at a glance
;;
;; Rationale:
;; I often have a directory of source files which I want to see at a glance.
;;
;; problem: given a directory (possibly directory tree) of source files,
;; open the lot of them in as many separate buffers as can sensibly be
;; displayed simultaneously.
;;
;; subproblems:
;;  [ ] determine how many buffers to create,
;;  [ ] determine appropriate size of a window
;;  [ ] don't open uninteresting files
;;  [ ] write reusable helper functions
;;    [x] open several files
;;    [ ] create new window as appropriate
;;  [ ] use available plumbing smartly
;;    [ ] see what's available
;;    [ ] make sense of windowing euristics
;;    [ ] make sense of windowing euristics
;;
;;  Interface:
;;    [ ] get-dir-interesting-files :: dir -> (files)
;;      [ ] survey-dir :: dir -> IO (files, buffers)
;;      [ ] get-dir-contents          :: dir -> (inodes)
;;      [ ] get-dir-leaves            :: dir -> (files)
;;    [x] files-display-first-n     :: (files) -> IO (buffers)
;;      [ ] open-one-more-file
;;    
;;    ;; bunch of new buffers
;;    ...
;;    ...
;;    consider:
;;
;;    remember-guesses-as-bad
;;    remember-guesses-as-appropriate
;;
;;  Plumbing:
;;
;;  get-directory-contents
;;    find-file
;;    find-file-read-args
;;    find-file-noselect
;;    find-file-other-window
;;    create-file-buffer
;;
;;  [ ] display-file-in-a-new-window
;;
;;
;;  Write a program that takes a directory and opens source files inside in a bunch of windows.
;; n, p: default values of arguments
;; files-from-dir with subdirs: collect leaves from a tree
;;
;; where are the primitives?
;;
(defun take (n l)
  (if (> n 0)
      (cons (car l) (take (- n 1) (cdr l)))
    ()))
;; 
;;;;;;;;;;;;;;;;;; design
;;;;;; outtakes
(open-several-files-from-dir (dir n filename-mask)
  (dolist open-file-in-new-window
   (take n (filter filename-mask (files-from-a-dir dir)))))

;; 
;;;;;; alternates
;;

(defun open-n-files-from-a-list-recursive (n files)
  (if (> n 0)
      (find-file-other-window (car files))
    nil)
  (open-n-files-from-a-list (- n 1) (cdr files)))
;; open-n-files-from-a-list-recursive loops infinitely
(> 0 0)
(> 1 0)
(cdr files-to-be-opened)


(defun open-n-files-from-a-list-mapcar (n files)
  (mapcar 'find-file-new-window (take n files)))


;; should be available: open-file-in-new-window

;;
;;;;;; aliases
;;

(defalias 'open-n-files 'open-n-files-from-a-list-mapcar)
(defalias 'find-file-new-window 'find-file-other-window)

;;;;;;;;;;;;;;;;;; testing
;;
(setq file-to-be-opened "agoraphobia.hs")
(setq another-file "jimmies.hs")
(setq files-to-be-opened (list file-to-be-opened another-file "foo.bar" "REAMDE"))

(open-n-files 4 files-to-be-opened)

(take 3 '(1 2 3 4 5 6))

(find-file "agoraphobia.hs")
(find-file file-to-be-opened)
(find-file (expand-file-name (car files-to-be-opened)))
