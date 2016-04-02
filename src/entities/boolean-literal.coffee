class BooleanLiteral
    constructor: (@name) ->

    value: ->
        name is true

    toString: ->
        @name

    analyze: (context) ->
        #todo

    optimize: -> 
        this

module.exports = BooleanLiteral