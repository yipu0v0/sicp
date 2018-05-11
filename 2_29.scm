(define (make-mobile left right)
    (list left right))
(define (left-branch mobile)
    (car mobile))
(define (right-branch mobile)
    (cadr mobile))

(define (make-branch length structure)
    (list length structure))
(define (branch-length branch)
    (car branch))
(define (branch-structure branch)
    (cadr branch))

(define (left-mobile mobile)
    (branch-structure (left-branch mobile)))
(define (right-mobile mobile)
    (branch-structure (right-branch mobile)))
(define (left-length mobile)
    (branch-length (left-branch mobile)))
(define (right-length mobile)
    (branch-length (right-branch mobile)))

(define (total-weight mobile)
    (newline)
    (display mobile)
    (cond 
        ((not (pair? mobile)) mobile)
        (else 
            (+ (total-weight (left-mobile mobile)) 
               (total-weight (right-mobile mobile))
            )
        )
    )
)

(define (balance mobile)
    (define (liju branch)
        (* (branch-length branch) (total-weight (branch-structure branch)))
    )
    (define (cur_balance mobile)
        (= 
            (liju (left-branch mobile)) 
            (liju (right-branch mobile))
        )
    )
    (if (not (pair? mobile))
        true
        (and (cur_balance mobile) (balance (left-mobile mobile)) (balance (right-mobile mobile)))
    )
 )

(define x (make-mobile (make-branch 1 2) (make-branch 2 1)))
(total-weight x)
(balance x)