class IntegerLiteral
    constructor: (@value) ->

    value: ->
        @value

    toString: ->
        @value

    analyze:(context) ->

    optimize: ->
        this

module.exports = IntegerLiteral