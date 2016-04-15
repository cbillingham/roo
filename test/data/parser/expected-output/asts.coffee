class ExpectedASTs

  # Note: newline is a space when using single line coffeescript string literal

  @empty = '(Program (Block ))'

  @gcd = '(Program (Block
    (Function gcd (a, b)
      (Block
        (If (is b 0)
          (Block (Return a))
        else
          (Block (Return
            (Call gcd (b, (% a b))))))))
    (Call print
      ((Call gcd (9, 3))))))'

  @countdown = '(Program (Block
    (Function countdown ()
      (Block 
        (For (Range 10 to 1 by 1)
          (Block
           (Call print (countdown))))))))'

<<<<<<< HEAD
  @whileLoop = '(Program (Block (While (< x 10) (Block (Call print ("x is less than 10"))))))'

  @assignmentStatements = '(Program
   (Block 
    (Assign int = 4) 
    (Assign string = "hello") 
    (Assign boolean = true) 
    (Assign float = 3.14159) 
    (Assign theNull = null) 
    (Assign list = [1, 0, 2, 3, 4])
     (Assign map = {first: 1, second: 2})))'
  
  @objects = '(Program
      (Block
        (Assign x =
          (Object Object ()))
        (Assign y = (Object Object2 ())))))'

  @assignmentStatements = '(Program (Block (Assign int = 4) (Assign string = "hello") (Assign boolean = true) (Assign float = 3.14159) (Assign theNull = null) (Assign list = [1, 2, 3, 4]) (Assign map = {first: 1, second: 2})))'

  @fibonacci = '(Program (Block
    (Function fibonacci (max)
      (Block
        (Assign a = 0)
        (Assign b = 1)
        f
        (For (Range 1 to max by 1)
          (Block
            (Assign f = (+ a b))
            (Assign a = b)
            (Assign b = f)))
        (Return f)))
    (Call print
      ((Call fibonacci (5))))))'

  @anonymousFun = '(Program (Block 
    (Function add (b) 
      (Block
        (Return ((a) -> (Block (Return (+ a b)))))))
    (Assign add5 = (Call add (5)))))'

  @listComprehension = '(Program (Block
    (Assign x = [(Range 0 to 3 by 1)])
    (Assign l = ["hi", "bye", 1, 3])
    (Assign y = ([] l (Range 0 to 1 by 1)))
    (Assign z = ([] l (Range 0 to 2 by 2)))
    (Assign n = [0, 1, 2, 3])
    (Assign y = [(* x 2) for x in n])))'

  @collections = '(Program (Block
    []
    [1, 2, 3, 4]
    <>
    <1, 2, 3, 4>
    {}
    {x: 1, y: 2}
    ()
    1
    (1,)
    (1, 2, 3)
    (1, 2, 3)))'

  @mapLiterals = '(Program (Block
    (Assign a = {x: 1, y: 2, z: 3})
    (Assign b = {x: "hey", y: "whatsup", z: "hello"})
    (Assign c = {a: 7.274482, b: "hi", c: "1738"})))'

  @forLoop = '(Program (Block
    (Assign people = ["jack", "jill"])
    (For people
      (Block 
        (Call goUpTheHill (person))))
    (Assign count = 8)
    (For (Range 1 to count by 2)
      (Block 
        (Assign x = (/ x y))))))'

  @lambdas = '(Program
      (Block
        ((x, y) -> (Block (+ x y)))
        (() -> (Block (Return 3)))
        (() -> (Block()))
        ((x, y, z, a) -> (Block (Return 3)))))'
  
  @prefixOp = '(Program (Block 
    (Assign t = (! false))
    (Assign f = (! true))))'

  @postfixOp = '(Program (Block 
    (Assign a = 1)
    (a ++)
    (Assign b = 2)
    (b --)))'

  @orderOfOperations = '(Program (Block 
    (Assign a = (+ (* 2 10) (* 5 (/ 6 2))))
    (Assign b = (+ (* (/ 12 4) 3) 10))
    (Assign c = (+ (* 1 (+ (* (- 4 7) 2) (/ 4 2))) (/ 16 4)))
    (Assign d = (/ (+ 5 5) 2))
    (Assign e = (/ (* (** 5 5) 5) 5))
    (Assign f = (+ (* 1 (+ (* (- 4 7) 2) (/ 4 2))) (** 16 4)))
    (Assign g = (* (/ 20 4) (** 2 3)))
    (Assign h = (> (/ 20 4) (** 2 3)))
    (Assign i = (< (+ 2 (/ 10 5)) (+ 5 4)))
    (Assign j = (< (/ (+ 5 5) 2) (** 5 (+ 5 (/ 4 2)))))
    (Assign k = (< (/ (+ 5.143 5.0532) 2) (** 5 (+ 5.353 (/ 4 2.657)))))))'
=======
  @helloworld = '(Program (Block
    (Call print ("hello world"))))'

    
>>>>>>> master

module.exports = ExpectedASTs