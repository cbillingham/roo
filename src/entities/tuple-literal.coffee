class TupleLiteral

  constructor: (@elements=[]) ->

  toString: ->
    if @elements.length is 1
      return "(#{@elements[0]},)"
    else
      "(#{@elements.join(', ')})"

  analyze: ->

  optimize: ->
    #todo

module.exports = TupleLiteral