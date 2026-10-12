;; copy-multi.lsp - Copy a selection several times along a step
;; Command: COPYN
;; Usage: select objects, base point, second point (the step), number of copies
(defun c:COPYN ( / ss base step n i dx dy tx ty )
  (setq ss (ssget "\nSelect objects to copy: "))
  (if ss
    (progn
      (setq base (getpoint "\nBase point: "))
      (setq step (getpoint base "\nSecond point (defines the step): "))
      (setq n (getint "\nNumber of copies <3>: "))
      (if (null n) (setq n 3))
      (setq dx (- (car step) (car base))
            dy (- (cadr step) (cadr base)))
      (setq i 1)
      (repeat n
        (setq tx (+ (car base) (* dx i))
              ty (+ (cadr base) (* dy i)))
        (command "_.COPY" ss "" base (list tx ty 0.0))
        (setq i (1+ i))
      )
      (princ (strcat "\nCopies created: " (itoa n)))
    )
  )
  (princ)
)
