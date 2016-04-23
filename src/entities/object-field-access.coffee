class ObjectFieldAccess

  constructor: (@source, @field) ->

  toString: ->
    "(. #{@source} #{@field})"

  analyze: (context) ->
    #todo

  optimize: ->
    #todo

module.exports = ObjectFieldAccess