class CollectionAccess

  constructor: (@source, @element) ->

  toString: ->
    "([] #{@source} #{@element})"

  analyze: (context) ->
    #todo

  optimize: ->
    #todo

module.exports = CollectionAccess