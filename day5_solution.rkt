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

(define (puzzle1 list maxId)
  (if (empty?  list)
      (display (string-append "Puzzle 1: " (number->string maxId) " is the highest boarding pass ID found."))
      (puzzle1 (rest list) (max (checkSeatId (calcCoords (string->list (first list)) defaultCoords)) maxId))))

(puzzle1 (file->lines "day5_given-boarding_passes.txt") 0)
