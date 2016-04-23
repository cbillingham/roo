class ClassDeclaration

  constructor: (@name, @body) ->

  toString: ->
    "(Class #{@name} #{@body})"

  analyze: (context) ->
    #todo

  optimize: ->
    #todo

module.exports = ClassDeclaration