class PostUnaryExpression

  constructor: (@op, @operand) ->

  toString: ->
    "(#{@operand} #{@op})"

  analyze: (context) ->
    @operand.analyze context

  optimize: ->
    this

module.exports = PostUnaryExpression