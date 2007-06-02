(module servlet-env-test mzscheme
  (require (planet "test.ss" ("schematics" "schemeunit.plt" 2))
           (lib "servlet-env.ss" "web-server"))
  (provide servlet-env-tests)
  
  (define servlet-env-tests
    (test-suite
     "Servlet Environment"))

  ; XXX Turn below into tests
  
  ; request-number : str -> num
  (define (request-number which-number)
    (string->number
     (extract-binding/single
      'number
      (request-bindings (send/suspend (build-request-page which-number))))))
  
  ; build-request-page : str -> str -> response
  (define (build-request-page which-number)
    (lambda (k-url)
      `(html (head (title "Enter a Number to Add"))
             (body ([bgcolor "white"])
                   (form ([action ,k-url] [method "post"])
                         "Enter the " ,which-number " number to add: "
                         (input ([type "text"] [name "number"] [value ""]))
                         (input ([type "submit"] [name "enter"] [value "Enter"])))))))
  #;(on-web
     `(html (head (title "Sum"))
            (body ([bgcolor "white"])
                  (p "The sum is "
                     ,(number->string (+ (request-number "first") (request-number "second")))))))
  
  (define (test)
    (on-web 9000 (+ (request-number "first") (request-number "second")))))