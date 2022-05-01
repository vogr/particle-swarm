#lang slideshow

(require slideshow/balloon
         slideshow/code)

(provide progress-slides)

(define (progress-slides)
  (slide #:title "Progress: The First State"))

(module+ main
  (progress-slides))
