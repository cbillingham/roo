class BooleanLiteral
    constructor: (@value) ->

    value: ->
        @value is "true"

    toString: ->
        @value

    analyze: (context) ->
        #todo

    optimize: -> 
        this

module.exports = BooleanLiteral