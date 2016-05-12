class FunctionCall

  constructor: (@function, @args) ->

  toString: ->
    "(Call #{@function} (#{@args.join(', ')}))"

  analyze: (context) ->
    for arg in @args
      arg.analyze context

  optimize: ->
    @args = (arg.optimize() for arg in @args)
    this

module.exports = FunctionCall