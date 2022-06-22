#!/usr/bin/env racket
#lang rash

;; Script that builds a shared library with different
;; block sizes. A size of #false will use the usqrt4(N)
;; specifier as suggested by Toledo.
;;
;; Gavin Gray 06.2022

(define block-sizes '(#f 32 64 128 256 512))
(define lib-name 'libpso.dylib)

(define (make-path sy1 . ss)
  (string->symbol
   (apply string-append (symbol->string sy1)
          (map (lambda (s)
                 (cond [(symbol? s) (symbol->string s)]
                       [(boolean? s) "0"]
                       [(number? s) (number->string s)]
                       [(string? s) s]
                       [else (error "unsupported type")])) ss))))

(define (build-lib size)
  (define new-name
    (make-path lib-name size))
  (when size
    (putenv "AT_LU_BLOCK" (number->string size)))
  #{make clean
         (if size
             #{make DEBUG=0 PSO_SHARED=1 INC_MKL=0 AUTOTUNE_ENV=1}
             #{make DEBUG=0 PSO_SHARED=1 INC_MKL=0})
         mv $lib-name (make-path '../lib/ size lib-name)})

cd ../
(unless (directory-exists? "lib")
  #{mkdir lib})
cd opus
(for ([n (in-list block-sizes)])
  (build-lib n))
