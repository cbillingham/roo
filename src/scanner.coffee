fs        = require 'fs'
readline    = require 'readline'
XRegExp = require 'xregexp'
error     = require './error'

LETTER = XRegExp '[\\p{L}]'
DIGIT = XRegExp '[\\p{Nd}]'
WORD_CHAR = XRegExp '[\\p{L}\\p{Nd}_]'

KEYWORDS = /^(fun|global|if|else|for|while|break|continue|return|loop|true|false|to|by|is|isnt|in|and|or|class|null|new|insist)$/

TWO_CHAR_TOKENS = /[%<>=+\-*\/!]=|\+\+|--|->|\*\*|&&|\|\|/
ONE_CHAR_TOKENS = /[\[+%\-*\/(),:=<>\]\{\}!.]/

inComment = false
endOfString = '"'

module.exports = (filename, callback) ->
  baseStream = fs.createReadStream filename, {encoding: 'utf8'}
  baseStream.on 'error', (err) -> error(err)

  stream = readline.createInterface input: baseStream
  tokens = []
  linenumber = 0
  stream.on 'line', (line) ->
    scan line, ++linenumber, tokens
    tokens.push {kind: 'EOL', lexeme: 'EOL'} #after every line (even blanks)
  stream.on 'close', () ->
    tokens.push {kind: 'EOF', lexeme: 'EOF'}
    callback tokens

scan = (line, linenumber, tokens) ->
  return if not line

  [start, pos] = [0,0]

  emit = (kind, lexeme) ->
    tokens.push {kind, lexeme: lexeme or kind, line: linenumber, col: start+1}
  
  inString = false

  loop

    # Skip spaces
    pos++ while /\s/.test line[pos]
    start = pos

    # Nothing on line
    break if (pos >= line.length)

    #Multiline Comments
    if not inComment
      if (line[pos] is '/' and line[pos+1] is '#')
        inComment = true
        pos += 2
        continue

    if inComment
      inComment = !(line[pos-1] is '#' and line[pos] is '/')
      pos++
      continue

    # Line is comment
    break if (line[pos] is '#')

    # String Literals
    if inString
      pos++
      while line[pos] isnt endOfString
        pos++ 

      start++ # Ignore the opening "
      pos++   # Ignore the ending " next loop
      inString = false
      emit 'stringlit', line.substring start, pos-1

    else if line[pos] is "'" or line[pos] is '"'
      inString = true
      endOfString = line[pos]


    # Numeric literals
    else if DIGIT.test line[pos]
      pos++ while DIGIT.test line[pos]
      if line[pos] is '.'
        pos++ #go to next character after period
        if !DIGIT.test line[pos]
          pos--
          emit 'intlit' , line.substring start, pos
        else
          pos++ while DIGIT.test line[pos]
          emit 'floatlit' , line.substring start, pos
      else
        emit 'intlit', line.substring start, pos

    # Two-Character tokens
    else if TWO_CHAR_TOKENS.test line.substring(pos, pos+2)
      emit line.substring pos, pos+2
      pos += 2

    # One-Character tokens
    else if ONE_CHAR_TOKENS.test line[pos]
      #check for floats
      if line[pos] is '.'
        if DIGIT.test line[pos+1]
          pos++
          pos++ while DIGIT.test line[pos]
          emit 'floatlit' , line.substring start, pos
        else
          emit line[pos++]
      else
        emit line[pos++]

    # Reserved words or identifiers
    else if LETTER.test line[pos]
      pos++ while WORD_CHAR.test(line[pos]) and pos < line.length
      word = line.substring start, pos
      if KEYWORDS.test word
        if word is 'true' or word is 'false'
          emit 'boollit', word
        else if word is 'null'
          emit 'nulllit', word
        else
          emit word, word
      else
        emit 'id', word

    else
      error "Illegal character: '#{line[pos]}'", {line: linenumber, col: pos+1}
      pos++

