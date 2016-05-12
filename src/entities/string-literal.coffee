class StringLiteral 

  constructor: (@value) ->

  toString: ->
    "\"#{@value}\""

  analyze: (context) ->
    #pass

  optimize: -> 
    this

module.exports = StringLiteral