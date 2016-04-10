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

module.exports = ExpectedASTs