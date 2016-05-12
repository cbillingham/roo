error = require './error'
VariableReference = require './entities/variable-reference'

class AnalysisContext
  constructor: (@parent, @inLoop = false, @inFunction = false) ->

  @initialContext: () ->
    new AnalysisContext(null)

  createChildContext: (opts) ->
    if opts.inLoop?
      inLoop = opts.inLoop
    else
      inLoop = @inLoop
    if opts.inFunction?
      inFunction = opts.inFunction
    else
      inFunction = @inFunction
    new AnalysisContext(this, inLoop, inFunction)

exports.initialContext = AnalysisContext.initialContext