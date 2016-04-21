error = require './error'
VariableReference = require './entities/variable-reference'

class AnalysisContext

    constructor: (@parent) ->
        @symbolTable = {}

    @initialContext: () ->
        new AnalysisContext(null)

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