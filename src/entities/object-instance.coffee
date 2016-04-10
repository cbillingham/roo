class ObjectInstance

  constructor: (@class, @args) ->

  toString: ->
    "(Object #{@class} (#{@args.join(', ')}))"

  analyze: ->
    #todo

  optimize: ->
    #todo

module.exports = ObjectInstance