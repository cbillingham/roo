class FunctionCall

  constructor: (@function, @args) ->

  toString: ->
    "(Call #{@function} (#{@args.join(', ')}))"

  analyze: ->
    #todo

  optimize: ->
    #todo

module.exports = FunctionCall