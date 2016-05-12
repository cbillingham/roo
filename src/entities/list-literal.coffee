class ListLiteral

  constructor: (@elements=[]) ->

  toString: ->
    "[#{@elements.join(', ')}]"

  analyze: (context) ->
    for element in @elements
      element.analyze context

  optimize: ->
    @elements = (element.optimize() for element in @elements)
    this

module.exports = ListLiteral