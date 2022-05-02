#lang slideshow

(require slideshow-text-style
         "tree.rkt"
         "logo.rkt")

(provide title-slide
         part)

(define (part-text s #:size [size 48])
  (parameterize ([current-main-font '(italic . "Zapfino")]
                 [current-font-size size])
    (para #:align 'center s)))

(define sep
  (let ([w (* client-w 0.2)])
    (tree-pict (branch 0 0 (list
                            (branch (* -1/2 pi) w
                                    (branch 0 w (curly gap-size #t)))
                            (branch (* 1/2 pi) w
                                    (branch 0 w (curly gap-size #f))))))))

(define (part s)
  (slide
   #:name (format "-- ~a --" s)
   (inset sep
          0 (- gap-size) 0 gap-size)
   (part-text s)
   (rotate sep pi)))

(define (title-slide)
  (define us '("Gavin Gray"
               "Valentin Ogier"
               "Xavier Servot"
               "York von Schlabrendorff"))
  (with-text-style
    ([auth #:size 32 #:bold? #t #:color "firebrick"])
    (slide (part-text "Particle Swarm with Radial Basis Functions")
           (apply vc-append
                  ;; (current-line-sep)
                  (list* (current-line-sep)
                         (map (λ (name)
                                (auth name)) us)))
           (blank)
           #;(item #:align 'left eth-logo))))

(module+ main
  (title-slide))
