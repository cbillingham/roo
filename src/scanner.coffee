fs        = require 'fs'
byline    = require 'byline'
{XRegExp} = require 'xregexp'
error     = require './error'

LETTER = XRegExp '[\\p{L}]'
DIGIT = XRegExp '[\\p{Nd}]'
WORD_CHAR = XRegExp '[\\p{L}\\p{Nd}_]'

KEYWORDS = /^(global|if|else|for|while|break|continue|return|loop|true|false|to|by|is|isnt|in|and|or|class|null|new|insist)$/
TWO_CHAR_TOKENS = /<=|==|!=|>=|**/
ONE_CHAR_TOKENS = /[+\-*\/(),:=<>]/


module.exports = (filename, callback) ->
  baseStream = fs.createReadStream filename, {encoding: 'utf8'}
  baseStream.on 'error', (err) -> error(err)

  stream = byline baseStream, {keepEmptyLines: true}
  tokens = []
  linenumber = 0
  stream.on 'readable', () ->
    scan stream.read(), ++linenumber, tokens
  stream.once 'end', () ->
    tokens.push {kind: 'EOF', lexeme: 'EOF'}
    callback tokens

scan = (line, linenumber, tokens) ->
  return if not line

  [start, pos] = [0,0]

  emit = (kind, lexeme) ->
    tokens.push {kind, lexeme: lexeme or kind, line: linenumber, col: start+1}

  inComment = false

  loop

    # Skip spaces
    pos++ while /\s/.test line[pos]
    start = pos

    # Nothing on line
    break if pos >= line.length

    #Multiline Comments
    inComment = true if line[pos] is '/' and line[pos+1] is '#'
    inComment = false if line[pos] is '#' and line[pos+1] is '/'
    continue if inComment

    # Line is comment
    break if (line[pos] is '#')

    # Two-Character tokens
    if TWO_CHAR_TOKENS.test line.substring(pos, pos+2)
      emit line.substring pos, pos+2
      pos += 2

    # One-Character tokens
    else if ONE_CHAR_TOKENS.test line[pos]
      emit line[pos++]

    # Reserved words or identifiers
    else if LETTER.test line[pos]
      pos++ while WORD_CHAR.test(line[pos]) and pos < line.length
      word = line.substring start, pos
      emit (if KEYWORDS.test word then word else 'id'), word

    # Numeric literals
    else if DIGIT.test line[pos]
      pos++ while DIGIT.test line[pos]
      emit 'intlit', line.substring start, pos

    else
      error "Illegal character: #(line[pos])", {line: linenumber, col: pos+1}
      pos++



