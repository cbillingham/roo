![Logo](https://raw.githubusercontent.com/cbillingham/roo/master/roo.jpg)

A simple, curly-brace language that compiles to Javascript. Roo combines the scripting benefits of a dynamically typed language with a readable syntax that is inspired by Java and Swift. While the basic syntax of Roo is inspired by Java and Swift, Roo adds modern functionailty, such as list comprehensions, default parameters, and much more, to the programmers toolbelt.

## Compile
```
kanga helloworld.roo
```

##Example Program
```
# gcd.roo

fun gcd(a, b) {
  if b != 0 {
    return a
  } else { 
    return gcd(b, a%b)
  }
}
```

##Features
###Comments
Single line comments are created with #
```
# this is a comment
```
Multi-line comments are created with a /# ... #/
```
/#
this is a mult-line comment
still a comment?
yep, still a comment
#/
```
###Assignments
Variable assignments are simple. No keyword or special symbol necessary.
```
x
y = 3
z = "hello"
```
If you would like to create an immutable variable, just use const or final.
```
const ONE = 1
final TWO = 2
```
###Operators
Roo adds some additional keywords as operators for readability. The following is a list of operators that Roo supports.
```
Roo                                     JavaScript
--------                                --------------
>                                       >
>=                                      >=
<                                       <
<=                                      <=
is,   ==                                ===
isnt, !=                                !==
!                                       !
and,  &&                                &&
or,   ||                                ||
true                                    true
false                                   false
this                                    this

a ** b	                                Math.pow(a, b)
a // b	                                Math.floor(a / b)
```
###If Statements
```
if x > 3 {
  return "x is greater than 3"
} else {
  return "x is less than or equal to 3"
}

# is equivalent to

if x > 3 {return "x is greater than 3"}
else {return "x is less than or equal to 3"}
```
###For Loops
For loops use list comprehensions which allow you to easily loop through objects or lists.
```
people = ["jack", "jill"]

for person in people {
  goUpTheHill(person)
}

# if you need the index as well just use i

for person, i in people {
  setAge(person, 8+i)
}
```
List comprehensions will replace most cases where traditional loops are used.
Using `..` is inclusive:
```
for countdown in [10..1] {
  print countdown
}
```
When the above code is executed it returns:
```
10
9
8
7
6
5
4
3
2
1
```
If you don't need the values of your loop you can just run the following. Using `...` is exclusive:
```
for [0...count] {
  x = x/y
}
```
When the above code is executed it will divide x by y count times, looping through 0 to count-1.

###While Loops
While loops are standard syntax.
```
while x < y {
  print "x<y is true"
}
```
You can run a while true loop with the following:
```
loop {
  if x < y {
    break
  }
  print "x<y is true"
  x--
}
```
###Functions

Functions are declared with the keyword fun.
```
fun gcd(a, b) {
  if b != 0 {
    return a
  } else { 
    return gcd(b, a%b)
  }
}
```
In Roo functions are also objects, so they are first-class by default.
```
fun printResult(f, a) {
  print( f(a) )
}

fun square(a) {
  return a*a
}

fun double(a) {
  return a*2
}

printResult(square, 3)           # prints 9
printResult(double, 3)           # prints 6
```
Roo also allows anonymous functions by using the single arrow () ->
```
fun add(b) {
  return (a) -> {return a+b} 
}
  
add5 = add(5)
```

## Syntax
### Micro Syntax
```
letter = [\p{L}]
digit = [\p{Nd}]
keyword = 'global'|'if'|'else'|'for'|'while'|'break'|'continue'|'loop'|'true'|
          'false'|'to'|'by'|'is'|'isnt'|'in'|'and'|'or'|'insist'|'return'|'read'
id = letter(letter|digit|_)*
intlit = digit+
relop = '<'|'<='|'=='|'is'|'!='|'isnt'|'>='|'>'
addop = '+'|'-'
mulop = '*'|'/'|'//'
exp = '**'
prefixop = '!'|'-'
boolit = 'true'|'false'
skip = [\x09-\x0d \u2028\u2029\p{Zs}] |  '#' [^\r\n]* [\r\n]
```
