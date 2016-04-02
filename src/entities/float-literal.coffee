class FloatLiteral
    constructor: (@value) ->

    value: ->
        @value

    toString: ->
        @value

    analyze: ->
        #todo

    optimize: ->
        this

module.exports = FloatLiteral