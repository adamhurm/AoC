#lang racket
(struct pos (x y))
(struct coordinates (x y))
(define defaultCoords (coordinates (pos 0 128) (pos 0 8)))

(define (checkCoords letter coords)
  (cond [(equal? letter #\F) (coordinates
                              (pos
                               (pos-x (coordinates-x coords))
                               (- (pos-y (coordinates-x coords)) (/ (- (pos-y (coordinates-x coords)) (pos-x (coordinates-x coords))) 2)))
                              (coordinates-y coords))]
        [(equal? letter #\B) (coordinates
                              (pos
                               (+ (pos-x (coordinates-x coords)) (/ (- (pos-y (coordinates-x coords)) (pos-x (coordinates-x coords))) 2))
                               (pos-y (coordinates-x coords)))
                              (coordinates-y coords))]
        [(equal? letter #\L) (coordinates
                              (coordinates-x coords)
                              (pos
                               (pos-x (coordinates-y coords))
                               (- (pos-y (coordinates-y coords)) (/ (- (pos-y (coordinates-y coords)) (pos-x (coordinates-y coords))) 2))))]
        [(equal? letter #\R) (coordinates
                              (coordinates-x coords)
                              (pos
                               (+ (pos-x (coordinates-y coords)) (/ (- (pos-y (coordinates-y coords)) (pos-x (coordinates-y coords))) 2))
                               (pos-y (coordinates-y coords))))]
        [else (print letter)]))

(define (checkSeatId coords)
  (+ (* 8 (pos-x (coordinates-x coords))) (pos-x (coordinates-y coords))))

(define (printCoords coords)
  (println (string-append "(" (number->string (pos-x (coordinates-x coords))) "," (number->string (pos-x (coordinates-y coords))) ") ID:" (number->string (checkSeatId coords)))))

(define (calcCoords line coords)
  (if (empty? line)
      coords
      (calcCoords (cdr line) (checkCoords (car line) coords))))

(define (testCoords)
  (for ([line (file->lines "day5_given-boarding_passes.txt")])
  (printCoords (calcCoords (string->list line) defaultCoords))))
;(testCoords)

(define (puzzle1 boardingPasses maxId)
  (if (empty? boardingPasses)
      (display (string-append "Puzzle 1: " (number->string maxId) " is the highest boarding pass ID found.\n"))
      (puzzle1 (rest boardingPasses) (max (checkSeatId (calcCoords (string->list (first boardingPasses)) defaultCoords)) maxId))))

(define (checkForMissing ids currId)
  (if (> (- (first ids) currId) 1)
      (+ currId 1)
      (checkForMissing (rest ids) (first ids))))

; puzzle 2 answer is 603 -- racket day5_solution.rkt | rev | cut -c-4 | rev | cut -c-3 | sort | grep 03
(define (puzzle2 boardingPasses ids)
  (if (empty? boardingPasses)
      (display (string-append "Puzzle 2: " (number->string (checkForMissing (cdr (sort ids <)) (car (sort ids <)))) " is the missing boarding pass ID. This must belong to me!\n"))
      (puzzle2 (rest boardingPasses) (cons (checkSeatId (calcCoords (string->list (first boardingPasses)) defaultCoords)) ids))))
 
(puzzle1 (file->lines "day5_given-boarding_passes.txt") 0)
(puzzle2 (file->lines "day5_given-boarding_passes.txt") '())
