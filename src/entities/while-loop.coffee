BooleanLiteral = require './boolean-literal'

class WhileLoop

  constructor: (@condition, @body) ->

  toString: ->
    "(While #{@condition} #{@body})"

  analyze: (context) ->
    @condition.analyze context
    @body.analyze context.createChildContext({inLoop:true})

  optimize: ->
    @condition = @condition.optimize()
    @body = @body.optimize()
    if (@condition instanceof BooleanLiteral and @condition.value() is false)
      return null
    return this

module.exports = WhileLoop