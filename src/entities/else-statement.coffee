class ElseStatement
    constructor: (body) ->

    toString: ->
        "Else #{@body}"

    analyze: ->
        #todo

    optimize: ->
    #todo

module.exports = ElseStatement