class CollectionAccess

  constructor: (@source, @element) ->

  toString: ->
    "([] #{@source} #{@element})"

  analyze: (context) ->
    @source.analyze context
    @element.analyze context

  optimize: ->
    @source = @source.optimize()
    @element = @element.optimize()
    this

module.exports = CollectionAccess