class ObjectInstance

  constructor: (@class, @args) ->

  toString: ->
    "(Object #{@class} (#{@args.join(', ')}))"

  analyze: (context) ->
    @class.analyze context
    for arg in @args
      arg.analyze context

  optimize: ->
    @class = @class.optimize()
    @args = (@arg.optimize for arg in @args)
    this

module.exports = ObjectInstance