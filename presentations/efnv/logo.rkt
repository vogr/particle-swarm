#lang slideshow

(require racket/runtime-path)

(provide eth-logo)

(define-runtime-path eth-logo-png
  "images/eth_logo_kurz_pos.png")

(define eth-logo
  (scale (bitmap eth-logo-png) 0.5))
