#lang slideshow

(require slideshow/balloon
         slideshow/code
         slideshow/play
         images/logos)

(provide fish-2-slides)

(define plt-img
  (bitmap (plt-logo #:height 20)))

(define val (standard-fish 100 50 #:direction 'right))
(define jol-val (jack-o-lantern 80 "blue" "khaiki" "salmon"))
(define gav (standard-fish 100 50 #:direction 'left #:color "firebrick"))
(define together (hc-append 200 val gav))
(define together-jol (hc-append 200 jol-val gav))

(define (make-fish-slide #:obj [obj 'none] #:n [n 0])
  (slide
   #:title "A Tale of Two Fish"
   (cond [(eq? obj 'none) together]
         [(eq? obj 'howdy) (pin-balloon (wrap-balloon (text "Howdy!")
                                                      'se 5 3)
                                        (cc-superimpose (blank 300 150) together)
                                        gav
                                        lt-find)]
         [(eq? obj 'ask) (pin-balloon (wrap-balloon (text "Slideshow?") 'sw -5 3)
                                      (cc-superimpose (blank 300 150) together)
                                      val
                                      rt-find)]
         [(eq? obj 'racket?) (pin-under together
                                        (/ (pict-width together) 2)
                                        (- (/ (pict-height gav) 2))
                                        (desktop-machine 1 '(plt binary)))]
         [(eq? obj 'really) (pin-balloon (wrap-balloon (text "(((λ)))?") 'sw -5 3)
                                         (cc-superimpose (blank 300 150) together)
                                         val
                                         rt-find)]
         [(eq? obj 'change-image) (pin-balloon (wrap-balloon (text "Swap images?") 'sw -5 3)
                                               (cc-superimpose (blank 300 150) together)
                                               val
                                               rt-find)]
         [(eq? obj 'change) (pin-balloon (wrap-balloon (scale (code (standard-fish)) 0.5)
                                                       'se 5 3)
                                         (cc-superimpose (blank 300 150) together)
                                         gav
                                         lt-find)]
         [(eq? obj 'jack) (pin-balloon (wrap-balloon (hc-append (scale (code (jack-o-lantern)) 0.4)
                                                                (t "?"))
                                                     'se 5 3)
                                       (cc-superimpose (blank 300 150) together)
                                       gav
                                       lt-find)]
         [(eq? obj 'new-together) together-jol]
         [(eq? obj 'can-move) (pin-balloon (wrap-balloon (text "Moving s@$*?") 'sw -5 3)
                                           (cc-superimpose (blank 300 150) together-jol)
                                           jol-val
                                           rt-find)]
         [(eq? obj 'tell-me) (pin-balloon (wrap-balloon (text "You tell me...")
                                                        'se 5 3)
                                          (cc-superimpose (blank 300 150) together-jol)
                                          gav
                                          lt-find)])))

(define (fish-2-slides)
  (make-fish-slide)
  (make-fish-slide #:obj 'howdy)
  (make-fish-slide #:obj 'ask)
  (make-fish-slide #:obj 'racket?)
  (make-fish-slide #:obj 'really)
  (make-fish-slide #:obj 'change-image)
  (make-fish-slide #:obj 'change)
  (make-fish-slide #:obj 'jack)
  (make-fish-slide #:obj 'new-together)
  (make-fish-slide #:obj 'can-move)
  (make-fish-slide #:obj 'tell-me)
  (play-n
   #:title "A Tale of Two Fish"
   #:skip-first? #t
   (λ (i) (slide-pict together-jol
                      (disk 25)
                      gav jol-val i))))

(module+ main
  (fish-2-slides))
