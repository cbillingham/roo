class FloatLiteral

  constructor: (@value) ->

  toString: ->
    @value

  analyze: (context) ->
    #todo

  optimize: ->
    this

module.exports = FloatLiteral