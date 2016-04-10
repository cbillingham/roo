class IntegerLiteral

  constructor: (@value) ->

  toString: ->
    @value

  analyze: (context) ->
    #todo

  optimize: -> 
    this

module.exports = IntegerLiteral