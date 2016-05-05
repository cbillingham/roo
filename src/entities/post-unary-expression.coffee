class PostUnaryExpression

  constructor: (@op, @operand) ->

  toString: ->
    "(#{@operand} #{@op})"

  analyze: (context) ->
    #todo

  optimize: ->
    #todo

module.exports = PostUnaryExpression