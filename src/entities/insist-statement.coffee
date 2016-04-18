class InsistStatement
  constructor: (@condition) ->

  toString: ->
    "(Insist #{@condition})"

  analyze: ->

  optimize: ->

module.exports = InsistStatement