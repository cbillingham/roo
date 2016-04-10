class ObjectFieldAccess

  constructor: (@source, @field) ->

  toString: ->
    "(. #{@source} #{@field})"

  analyze: ->
    #todo

  optimize: ->
    #todo

module.exports = ObjectFieldAccess