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
;;   determine how many buffers to create,
;;   determine appropriate size of a window
;;   don't open uninteresting files
;;   write reusable helper functions
;;   use available plumbing smartly
;;     see what's available
;;
;;  Interface:
;;    survey-dir :: dir -> IO (files, buffers)
;;    get-dir-contents          :: dir -> (inodes)
;;    get-dir-leaves            :: dir -> (files)
;;    get-dir-interesting-files :: dir -> (files)
;;    files-display-first-n     :: (files) -> IO (buffers)
;;    
;;    ;; bunch of new buffers
;;    ...
;;    ...
;;    
;;    remember-guesses-as-bad
;;    remember-guesses-as-appropriate
;;    open-one-more-file
;;
;;  Write a program that takes a directory and opens source files inside in a bunch of windows.
;; n, p: default values of arguments
;; files-from-dir with subdirs: collect leaves from a tree
;; 
(open-several-files-from-dir (dir n filename-mask)
  (dolist open-file-in-new-window
   (take n (filter filename-mask (files-from-a-dir dir)))))

;; should be available: open-file-in-new-window
