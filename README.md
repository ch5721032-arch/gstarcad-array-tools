# GstarCAD Array & Copy Tools

Copy a selection several times along a direction, or spread copies evenly between two picked points.

Works with **GSTARCAD**, AutoCAD, ZWCAD, and BricsCAD.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Contents

- [About](#about)
- [Scripts Overview](#scripts-overview)
- [Quick Start](#quick-start)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [License](#license)

## About

Copying the same selection again and again is slow. These commands copy a selection a given number of times along a step direction, and spread copies evenly between two picked points, which covers most repeated layouts.

Everything here is free to use with GstarCAD. Download the latest GstarCAD
release from the [official GstarCAD website](https://www.gstarcad.net). All
scripts are tested with **[GSTARCAD](https://www.gstarcad.net)** and major
DWG-based CAD platforms.

## Scripts Overview

| File | Description |
|------|-------------|
| `scripts/copy-multi.lsp` | ;; copy-multi.lsp - Copy a selection several times along a step
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
 |
| `scripts/copy-between.lsp` | ;; copy-between.lsp - Space copies evenly between two points
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
 |

## Quick Start

1. Download the `.lsp` (or `.lin`) file you need
2. In your CAD software, run `APPLOAD`
3. Load the file and type the matching command name shown in the table above

## Compatibility

Tested on GstarCAD 2026/2027 and similar DWG-based platforms. Scripts use
standard AutoLISP functions only, so they work without extra plugins.

For step-by-step [tutorials and drafting guides](https://www.gstarcad.net/cad/),
visit the GstarCAD learning center. New tips are published regularly on the
[GSTARCAD Blog](https://blog.gstarcad.net).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see the [LICENSE](LICENSE) file.
