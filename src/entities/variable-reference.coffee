class VariableReference

  constructor: (@token) ->

  toString: ->
    @token.lexeme

  analyze: (context) ->
    #todo

  optimize: ->
    this

module.exports = VariableReference
