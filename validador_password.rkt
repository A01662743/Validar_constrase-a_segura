;;; Alejandro Contreras Magallanes
;;; 21/05/2026
;;; Validador de contraseña segura en racket, paradigma funcional

#lang racket

(require rackunit)
(require rackunit/text-ui)

;;; ================
;;; LÓGICA PRINCIPAL
;;; ================

;; Función auxiliar recursiva de cola que actúa como acumuladora de estados
(define (validar-acumulador-opt chars mayus? minus? num? esp?)
  (cond
    [(null? chars) (and mayus? minus? num? esp?)]
    [else
      ;; Estado final: Al vaciar la lista, todos los sub-autómatas deben estar en #t
     (let ([c (car chars)]
           [resto (cdr chars)])
       (cond
         [(and (not mayus?) (char-upper-case? c)) (validar-acumulador-opt resto #t minus? num? esp?)]
         
         [(and (not minus?) (char-lower-case? c)) (validar-acumulador-opt resto mayus? #t num? esp?)]
         
         [(and (not num?)   (char-numeric? c))    (validar-acumulador-opt resto mayus? minus? #t esp?)]
         
         [(and (not esp?)   (member c '(#\! #\@ #\# #\$ #\% #\*))) 
          (validar-acumulador-opt resto mayus? minus? num? #t)]
         
         [else (validar-acumulador-opt resto mayus? minus? num? esp?)]))]))

;; Predicado principal
(define (password-segura? str)
  (validar-acumulador (string->list str) #f #f #f #f))

;;; =====================
;;; PRUEBAS AUTOMATIZADAS
;;; =====================

(define password-tests
  (test-suite
   "Pruebas Unitarias para Validador de Contraseñas Seguras"

   (test-case "Contraseña válida"
     (check-true (password-segura? "Secr3t!"))
     (check-true (password-segura? "1aA*2bB#")))

   (test-case "Falta de mayúscula"
     (check-false (password-segura? "secr3t!")))

   (test-case "Falta de minúscula"
     (check-false (password-segura? "SECR3T!")))

   (test-case "Falta de numéros"
     (check-false (password-segura? "Secret!")))

   (test-case "Falta de caracteres especiales"
     (check-false (password-segura? "Secr3t99")))
   
   (test-case "Cadena vacía"
     (check-false (password-segura? "")))))

;; Ejecución de las pruebas
(run-tests password-tests)