class InsistStatement
  constructor: (@condition) ->

  toString: ->
    "(Insist #{@condition})"

  analyze: (context)->

  optimize: ->

module.exports = InsistStatement