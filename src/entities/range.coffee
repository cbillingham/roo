class Range
  
  constructor: (@left="start", @right="end", @step=1) ->

  toString: ->
    "(Range #{@left} to #{@right} by #{@step})"

  analyze: (context) ->
    if @left is not "start"
      @left.analyze context
    if @right is not "end"
      @right.analyze context
    if @step.analyze?
      @step.analyze context

  optimize: ->
    if @left is not "start"
      @left = @left.optimize()
    if @right is not "end"
      @right = @right.optmize()
    if @step.analyze?
      @step = @step.optmize()
    this

module.exports = Range