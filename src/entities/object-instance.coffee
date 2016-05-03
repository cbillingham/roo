class ObjectInstance

  constructor: (@class, @args) ->

  toString: ->
    "(Object #{@class} (#{@args.join(', ')}))"

  analyze: (context) ->
    #todo

  optimize: ->
    #todo

module.exports = ObjectInstance