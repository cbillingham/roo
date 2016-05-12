class FloatLiteral

  constructor: (@value) ->

  toString: ->
    @value

  analyze: (context) ->
    #pass

  optimize: ->
    this

module.exports = FloatLiteral