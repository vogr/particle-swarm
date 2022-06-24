#!/usr/bin/env racket
#lang rash

(require racket/stream
         racket/list
         racket/math)

;; Script that builds a shared library with different
;; block sizes. A size of #false will use the usqrt4(N)
;; specifier as suggested by Toledo.
;;
;; Gavin Gray 06.2022

(define lib-name 'libpso.dylib)
(define l1-size 32e3)
(define l1-line-size 64)
(define l2-size 1e6)

(define (make-path sy1 . ss)
  (string->symbol
   (apply string-append (symbol->string sy1)
          (map (lambda (s)
                 (cond [(symbol? s) (symbol->string s)]
                       [(boolean? s) "0"]
                       [(number? s) (number->string s)]
                       [(string? s) s]
                       [else (error "unsupported type")])) ss))))


(define (build-lib size #:M [M 192] #:N [N 2048] #:K [K 384])
  (define new-name
    (make-path lib-name size))
  (when size
    (putenv "AT_LU_BLOCK" (number->string size)))
  (putenv "AT_M_BLOCK" (number->string M))
  (putenv "AT_N_BLOCK" (number->string N))
  (putenv "AT_K_BLOCK" (number->string K))
  #{touch src/lu_solve.c
    touch src/blas/dgemm.c
    (if size
        #{make DEBUG=0 PSO_SHARED=1 INC_MKL=0 AUTOTUNE_ENV=1}
        #{make DEBUG=0 PSO_SHARED=1 INC_MKL=0})
    mv $lib-name (make-path '../lib/ size '- M '- N '- K '- lib-name)})

;; ----

(define model-nb
  (let ([val (lambda (n)
               (+ (ceiling (/ (* n n) l1-line-size))
                  (* 3 (ceiling (/ n l1-line-size))) 1))])
    ((compose exact-floor
              last
              (lambda (l)
                (filter (lambda (v)
                          (= 0 (modulo v 8))) l)))
     (for/list ([i (in-naturals)]
                #:break (> (val i)
                           (/ l1-size l1-line-size)))
       (val i)))))


cd ../
(unless (directory-exists? "lib")
  #{mkdir lib})
cd opus

(for ([n (in-list '(#f 32 64 128 256 512))]
      #:when (and n (= n 64))) ;; Remove for full autotuning
  (begin (for ([nb (in-naturals 16)]
               #:final (<= (sqrt l1-size) nb))
           (build-lib n #:M nb #:N nb #:K nb))
         ;; Hand chosen values
         (for ([mb (in-list (list model-nb 96 32 192))]
               [nb (in-list (list model-nb 198 64 2048))]
               [kb (in-list (list model-nb 512 256 384))])
           (build-lib n #:M mb #:N nb #:K kb))))
