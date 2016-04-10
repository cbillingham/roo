class NullLiteral

  constructor: ->
    @value = null

  toString: ->
    @value

  analyze: (context) ->
    #todo

  optimize: -> 
    this

module.exports = NullLiteral