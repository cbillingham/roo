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

  @lambdas = '(Program
      (Block
        ((x, y) -> (Block (+ x y)))
        (() -> (Block (Return 3)))
        (() -> (Block()))
        ((x, y, z, a) -> (Block (Return 3)))))'
module.exports = ExpectedASTs