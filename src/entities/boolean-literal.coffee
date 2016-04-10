class BooleanLiteral

  constructor: (@value) ->

  toString: ->
    @value

  analyze: (context) ->
    #todo

  optimize: -> 
    this

module.exports = BooleanLiteral