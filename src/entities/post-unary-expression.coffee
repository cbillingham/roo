class PostUnaryExpression

  constructor: (@op, @operand) ->

  toString: ->
    "(#{@operand}#{@op})"

  analyze: ->
    #todo

  optimize: ->
    #todo

module.exports = PostUnaryExpression