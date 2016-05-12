class ObjectFieldAccess

  constructor: (@source, @field) ->

  toString: ->
    "(. #{@source} #{@field})"

  analyze: (context) ->
    @source.analyze context
    @field.analyze context

  optimize: ->
    @source = @source.optimize()
    @field = @field.optimize()
    this

module.exports = ObjectFieldAccess