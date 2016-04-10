class ListLiteral

  constructor: (@elements) ->

  toString: ->
    "[#{@elemenst.join(', ')}]"

  analyze: ->
    #todo

  optimize: ->
    #todo

module.exports = ListLiteral