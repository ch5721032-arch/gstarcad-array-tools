;; copy-between.lsp - Space copies evenly between two points
;; Command: COPYBTW
;; Usage: select objects, base point, then pick the start and end of the run
(defun c:COPYBTW ( / ss base p1 p2 n i dx dy tx ty )
  (setq ss (ssget "\nSelect objects to copy: "))
  (if ss
    (progn
      (setq base (getpoint "\nBase point: "))
      (setq p1 (getpoint "\nStart of the run: "))
      (setq p2 (getpoint p1 "\nEnd of the run: "))
      (setq n (getint "\nNumber of copies <4>: "))
      (if (null n) (setq n 4))
      (setq dx (- (car p2) (car p1))
            dy (- (cadr p2) (cadr p1)))
      (setq i 1)
      (repeat n
        (setq tx (+ (car p1) (* dx (/ (float i) (float (1+ n)))))
              ty (+ (cadr p1) (* dy (/ (float i) (float (1+ n))))))
        (command "_.COPY" ss "" base (list tx ty 0.0))
        (setq i (1+ i))
      )
      (princ (strcat "\nCopies created: " (itoa n)))
    )
  )
  (princ)
)
