class StringLiteral 

  constructor: (@value) ->

  toString: ->
    @value

  analyze: (context) ->
    #todo

  optimize: -> 
    this

module.exports = StringLiteral