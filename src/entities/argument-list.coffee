class ArgumentList

  constructor: (@expressions) ->

  toString: ->
    "(#{@expressions.join(', ')})"

  analyze: (context) ->
    for expression in @expressions
      expression.analyze context

  optimize: ->
    @expressions = (e.optimize() for e in @expressions)
    this

module.exports = ArgumentList