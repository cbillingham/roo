class TupleLiteral

  constructor: (@elements=[]) ->

  toString: ->
    if @elements.length is 1
      return "(#{@elements[0]},)"
    else
      "(#{@elements.join(', ')})"

  analyze: (context) ->
    for element in @elements
      element.analyze context

  optimize: ->
    @elements = (element.optimize() for element in @elements)
    this

module.exports = TupleLiteral