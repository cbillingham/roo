class PreUnaryExpression

  constructor: (@op, @operand) ->

  toString: ->
    "(#{@op} #{@operand})"

  analyze: (context) ->
    @operand.analyze context

  optimize: ->
    @operand = @operand.optimize()
    if @op.lexeme is 'not' and @operand instanceof BooleanLiteral
      new BooleanLiteral(not @operand.value)
    else if @op.lexeme is '-' and @operand instanceof IntegerLiteral
      new IntegerLiteral(- @operand.value)
    else
      this

module.exports = PreUnaryExpression