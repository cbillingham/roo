class VariableReference

  constructor: (@token) ->

  toString: ->
    @token.lexeme

  analyze: (context) ->
    #runtime undeclared var error

  optimize: ->
    this

module.exports = VariableReference
