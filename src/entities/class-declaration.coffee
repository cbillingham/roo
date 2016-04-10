class ClassDeclaration

  constructor: (@name, @body) ->

  toString: ->
    "(Class #{@name} #{@body})"

  analyze: ->
    #todo

  optimize: ->
    #todo

module.exports = ClassDeclaration