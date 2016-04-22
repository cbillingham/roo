class VariableReference

  constructor: (@token) ->

  toString: ->
    @token.lexeme

  analyze: (context) ->
    @referent = context.lookupVariable @token

  optimize: ->
    this

module.exports = VariableReference
