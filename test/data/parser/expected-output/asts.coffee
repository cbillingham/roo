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

  @whileLoop = '(Program (Block (While (< x 10) (Block (Call print ("x is less than 10"))))))'

  @assignmentStatements = '(Program (Block (Assign int = 4) (Assign string = "hello") (Assign boolean = true) (Assign float = 3.14159) (Assign theNull = null) (Assign list = [1, 0, 2, 3, 4]) (Assign map = {first: 1, second: 2})))'

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
    (Assign n = [0,1,2,3])
    (Assign y = [(* x 2) for x in l])))'


# (Assign y = l[(Range 0 to 1 by 1)])
# (Assign z = l[(Range 0 to 2 by 2)])







module.exports = ExpectedASTs