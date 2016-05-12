class AssignmentStatement
  
  constructor: (@target, @value, @global = false) ->

  toString: ->
    "(Assign #{if @global then 'global ' else ''}#{@target} = #{@value})"
  
  isGlobal: ->
    @global

  analyze: (context) ->
    @target.analyze context
    @value.analyze context

  optimize: ->
    @target = @target.optimize()
    @value = @value.optimize()
    this

module.exports = AssignmentStatement