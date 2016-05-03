class PreUnaryExpression

  constructor: (@op, @operand) ->

  toString: ->
    "(#{@op}#{@operand})"

  analyze: (context) ->
    #todo

  optimize: ->
    #todo

module.exports = PreUnaryExpression