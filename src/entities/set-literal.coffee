class SetLiteral

  constructor: (@elements) ->

  toString: ->
    "<#{@elemenst.join(', ')}>"

  analyze: ->
    #todo

  optimize: ->
    #todo

module.exports = SetLiteral