class SetLiteral

  constructor: (@elements=[]) ->

  toString: ->
    "<#{@elements.join(', ')}>"

  analyze: ->
    #todo

  optimize: ->
    #todo

module.exports = SetLiteral