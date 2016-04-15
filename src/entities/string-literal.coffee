class StringLiteral 

  constructor: (@value) ->

  toString: ->
<<<<<<< HEAD
   "\"#{@value}\""
=======
    "\"#{@value}\""
>>>>>>> master

  analyze: (context) ->
    #todo

  optimize: -> 
    this

module.exports = StringLiteral