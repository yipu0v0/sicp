(define (assoc key records)
    (cond ((null? records) false)
        ((equal? key (caaar records)) 
            (car records))
        (else (assoc key (cdr records)))))

(define (make-table)
    (let ((local-table (list '*table*)))
        (define (lookup-table keys table)
            (let ((subtable 
                (assoc (car keys) (cdr table))))
                (if subtable
                    (if (null? (cdr keys))
                        (cdar subtable)
                        (lookup-table (cdr keys) subtable))
                    false)))
        (define (lookup keys)
            (lookup-table keys local-table))
        (define (insert-table! keys value table)
            (let ((subtable 
                (assoc (car keys) (cdr table))))
            (if subtable
                (if (null? (cdr keys))
                    (set-cdr! (car subtable) value)
                    (insert-table! (cdr keys) value subtable))
                (if (null? (cdr keys))
                    (set-cdr! table (cons (list (cons (car keys) value)) (cdr table)))
                    (begin
                        (set-cdr! table (cons (list (cons (car keys) '())) (cdr table)))
                        (insert-table! (cdr keys) value (assoc (car keys) (cdr table)))))))
        'ok)
    (define (insert! keys value)
        (insert-table! keys value local-table))
    (define (dispatch m)
        (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation: 
                          TABLE" m))))
    dispatch))

(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

(put (list 2 1) 3)
(get (list 2 1))
(put (list 2) 4)
(get (list 2))
(put (list 2 1) 100)
(get (list 2 1))