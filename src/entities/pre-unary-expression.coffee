class PreUnaryExpression

  constructor: (@op, @operand) ->

  toString: ->
    "(#{@op} #{@operand})"

  analyze: ->
    #todo

  optimize: ->
    #todo

module.exports = PreUnaryExpression