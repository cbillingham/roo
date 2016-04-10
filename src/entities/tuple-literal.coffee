class TupleLiteral

  constructor: (@elements) ->

  toString: ->
    "(#{@elemenst.join(', ')})"

  analyze: ->

  optimize: ->
    #todo

module.exports = TupleLiteral