class ListComprehension

  constructor: (@exp, @id, @source) ->

  toString: ->
    "[#{@exp} for #{@id} in #{@source}]"

  analyze: (context) ->
    @exp.analyze context
    @source.analyze context

  optimize: ->
    @exp = @exp.optimize()
    @source = @source.optimize()
    this

module.exports = ListComprehension