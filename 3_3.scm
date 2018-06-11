(define (make-account balance password)
    (define (withdraw amount)
        (if (>= balance amount)
            (begin (set! balance (- balance amount)) balance)
            "Insufficient funds"))
    (define (deposit amount)
        (set! balance (+ balance amount))
        balance)
    (define (dispatch m)
        (cond 
            ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            (else (error "Unknown request -- MAKE_ACCOUNT" m))))
    (define (dispatch_pwd in_pwd m)
        (if (eq? in_pwd password)
            (dispatch m)
            (error "Incorrect password")))
    dispatch_pwd
)

(define acc (make-account 100 'secret-password))
((acc 'secret-password 'withdraw) 40)
((acc 'wrong-pwd 'deposit) 10)