class ListLiteral

  constructor: (@elements) ->

  toString: ->
    "[#{@elements.join(', ')}]"

  analyze: ->
    #todo

  optimize: ->
    #todo

module.exports = ListLiteral