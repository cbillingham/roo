class ForLoop

  constructor: (@source, @body, @ids) ->

  toString: ->
    if ids?
      "(For #{@ids.join(', ')} in #{@source} #{@body})"
    else
      "(For #{@source} #{@body})"

  analyze: (context) ->
    @source.analyze context
    @body.analyze context.createChildContext({inLoop:true})

  optimize: ->
    @source = @source.optimize()
    @body = @body.optimize()
    this
    
module.exports = ForLoop