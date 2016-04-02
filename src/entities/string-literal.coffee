class StringLiteral 
    constructor: (@value)->

    value: ->
        @value

    analyze: ->
        #todo

    optimize: ->
        this

module.exports = StringLiteral