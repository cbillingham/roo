class Range
  
  constructor: (@left="start", @right="end", @step=1) ->

  toString: ->
    "(Range #{@left} to #{@right} by #{@step})"

  analyze: (context) ->
    #TODO

  optimize: ->
    #TODO

module.exports = Range