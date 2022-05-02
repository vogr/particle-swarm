#lang slideshow

(require slideshow/balloon)

(provide fish-1-slides)

(define (make-fish-slide #:obj [obj 'none])
  (define val (standard-fish 100 50 #:direction 'right))
  (slide
   #:title "There Once Was a Fish Named Valentin ..."
   (cond [(eq? obj 'salut) (pin-balloon (wrap-balloon (text "Salut!") 'sw -5 3)
                                        (cc-superimpose (blank 300 150) val)
                                        val
                                        rt-find)]
         [(eq? obj 'comp) (hc-append val (desktop-machine 1))]
         [else val])))

(define (fish-1-slides)
  (make-fish-slide)
  (make-fish-slide #:obj 'salut)
  (make-fish-slide #:obj 'comp))

(module+ main
  (fish-1-slides))
