error = require './error'
VariableReference = require './entities/variable-reference'

class AnalysisContext
  constructor: (@parent, global) ->
    @symbolTable = {}
    if global
      @global = @symbolTable
    else
      @global = @parent.global

  @initialContext: () ->
    new AnalysisContext(null, global = true)

  createChildContext: ->
    new AnalysisContext(this)

  addVariable: (name, entity) ->
    @symbolTable[name] = entity

  lookupVariable: (token) ->
    variable = @symbolTable[token.lexeme]
    if variable
      variable
    else if not @parent
      error "Variable #{token.lexeme} not found", token
    else
      @parent.lookupVariable token

exports.initialContext = AnalysisContext.initialContext