class NullLiteral

  constructor: ->
    @value = null

  toString: ->
    @value

  analyze: (context) ->
    #pass

  optimize: -> 
    this

module.exports = NullLiteral