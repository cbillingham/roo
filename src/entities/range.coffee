class Range
  
  constructor: (@left="start", @right="end", @step=1) ->

  toString: ->
    "(Range #{@left} to #{@right} by #{@step})"

  analyze: ->
    #TODO

  optimize: ->
    #TODO

module.exports = AssignmentStatement