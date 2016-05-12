class BinaryExpression

  constructor: (@op, @left, @right) ->

  toString: ->
    "(#{@op} #{@left} #{@right})"

  analyze: (context) ->
    @left.analyze context 
    @right.analyze context 

  optimize: ->
    @left = @left.optimize()
    @right = @right.optimize()
    this

module.exports = BinaryExpression