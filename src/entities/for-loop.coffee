class ForLoop

  constructor: (@source, @body, @ids) ->

  toString: ->
    if ids?
      "(For #{@ids.join(', ')} in #{@source} #{@body})"
    else
      "(For #{@source} #{@body})"

  analyze: (context) ->
    #todo

  optimize: ->
    #todo

module.exports = ForLoop