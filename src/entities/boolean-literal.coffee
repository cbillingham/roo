class BooleanLiteral

  constructor: (@value) ->

  toString: ->
    @value

  analyze: (context) ->
    #pass

  optimize: -> 
    this

module.exports = BooleanLiteral