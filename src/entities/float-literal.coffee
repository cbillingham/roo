class FloatLiteral

  constructor: (@value) ->

  toString: ->
    @value

  analyze: ->
    #todo

  optimize: ->
    this

module.exports = FloatLiteral