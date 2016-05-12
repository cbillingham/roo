class InsistStatement
  constructor: (@condition) ->

  toString: ->
    "(Insist #{@condition})"

  analyze: (context)->
    @condition.analyze context

  optimize: ->
    @condition = @condition.optimize()
    this

module.exports = InsistStatement