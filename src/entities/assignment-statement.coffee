class AssignmentStatement
  
  constructor: (@target, @value, @global = false) ->

  toString: ->
    "(Assign #{if @global then 'global ' else ''}#{@target} = #{@value})"
  
  isGlobal: ->
    @global

  analyze: (context) ->
    #todo

  optimize: ->
    #TODO

module.exports = AssignmentStatement