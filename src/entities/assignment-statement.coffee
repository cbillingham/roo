class AssignmentStatement
  
  constructor: (@variableReference, @value, @global = false, @constant = false) ->

  toString: ->
     "(Assign #{"global " if @global}#{"const " if @constant} #{@variableReference} = #{@value})"
  
  isGlobal: ->
    @global

  isConst: ->
    @const

  analyze: ->
     #TODO

  optimize: ->
     #TODO

module.exports = AssignmentStatement