class AssignmentStatement
  
  constructor: (@target, @value, @global = false) ->

  toString: ->
    "(Assign #{if @global then 'global ' else ''}#{@target} = #{@value})"
  
  isGlobal: ->
    @global

  analyze: ->
    if 

  optimize: ->
    #TODO

module.exports = AssignmentStatement