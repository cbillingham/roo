class SetLiteral

  constructor: (@elements=[]) ->

  toString: ->
    "<#{@elements.join(', ')}>"

  analyze: (context) ->
    #todo

  optimize: ->
    #todo

module.exports = SetLiteral