class CollectionAccess

  constructor: (@source, @element) ->

  toString: ->
    "([] #{@source} #{@element})"

  analyze: ->
    #todo

  optimize: ->
    #todo

module.exports = CollectionAccess