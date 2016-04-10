class ListComprehension

  constructor: (@exp, @id, @source) ->

  toString: ->
    "[#{@exp} for #{@id} in #{@source}]"

  analyze: ->
    #todo

  optimize: ->
    #todo

module.exports = ListComprehension