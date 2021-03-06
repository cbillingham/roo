![Logo](/images/roo.jpg?raw=true)

A simple, curly-brace language that compiles to Javascript. Roo combines the scripting benefits of a dynamically typed language with a readable syntax that is inspired by Java and Swift. While the basic syntax of Roo is inspired by Java and Swift, Roo adds modern functionailty, such as list comprehensions, default parameters, and much more, to the programmers toolbelt.

### About
Roo was created as part of the compilers class at Loyola Marymount University during the spring 2016 semester. It is the brain child of:
* [Cameron Billingham](https://github.com/cbillingham)
* [Jeff Fennell](https://github.com/jtfennell)
* [Matt Flickner](https://github.com/mwflickner)
* [Misa Pham](https://github.com/misaqpham)
* [Joseph Barbosa](https://github.com/jbarbosa1)

## Compile
```
kanga helloWorld.roo
```

## Hello World
```
# helloWorld.roo

print("Hello, World!")
```

## Example Program
```
# gcd.roo

fun gcd(a, b) {
  if b is 0 {
    return a
  } else { 
    return gcd(b, a%b)
  }
}

print( gcd(9,3) )      # prints 3
```

## Syntax
Check out a railroad diagram of our grammar here: [Roo Railroad Diagram](https://cbillingham.github.io/roo/railroaddiagram)
### MicroSyntax
```
endofline ::= newline | $
newline   ::= [\s* (\r*\n)+]
letter    ::= [\p{L}]
digit     ::= [\p{Nd}]
keyword   ::= 'global'|'if'|'else'|'for'|'while'|'break'|'continue'|'loop'|'true'
            | 'false'|'to'|'by'|'is'|'isnt'|'in'|'and'|'or'|'insist'|'return'|'null'
            | 'class'|'new'
id        ::= letter(letter|digit|_)*
intlit    ::= digit+
floatlit  ::= digit* '.' digit+
assignop  ::= '='|'+='|'-='|'*='|'/='|'%='
relop     ::= '<'|'<='|'=='|'is'|'!='|'isnt'|'>='|'>'
addop     ::= '+'|'-'
mulop     ::= '*'|'/'|'%'|'//'
expop     ::= '**'
prefixop  ::= '!'|'-'
postfixop ::= '++'|'--'
boollit   ::= 'true'|'false'
char      ::= [^\p{Cc}'"\\] | [\\] [rnst'"\\]
stringlit ::= ('"' char* '"') | ("'" char* "'")
nulllit   ::= 'null'
skip      ::= [\x09-\x0d \u2028\u2029\p{Zs}] | comment
comment   ::= '#' [^\n]* newline
            | '/#' .* '#/'
```
### MacroSyntax
```
Program       ::= Block
Block         ::= (Stmt? endofline)*
Stmt          ::= WhileLoop | IfStmt | Loop | ForLoop | Dec | Exp
                | ReturnStmt | BreakStmt | ContinueStmt

Dec           ::= AssignStmt | FunDec | ObjectDec
AssignStmt    ::= 'global'? Var assignop Exp | Increment
Increment     ::= Var postfixop
FunDec        ::= 'fun' id Params Body
Params        ::= '(' (Param (',' Param)*)? ')'
Param         ::= id '=' Exp | id
ObjectDec     ::= 'class' id Body

Loop          ::= 'loop' Body
WhileLoop     ::= 'while' Exp Body
ForLoop       ::= 'for' Exp Body
IfStmt        ::= 'if' Exp Body (ElseIfStmt)* ElseSmt?
ElseIfStmt    ::= 'else if' Exp Body
ElseStmt      ::= 'else' Body
BreakStmt     ::= 'break'
ContinueStmt  ::= 'continue'
ReturnStmt    ::= 'return' Exp

Body          ::= '{' Block? '}'
Exp           ::= Exp1 (( 'or' | '||' ) Exp1)*
Exp1          ::= Exp2 (( 'and' | '&&' ) Exp2)*
Exp2          ::= Exp3 (relop Exp3)?
Exp3          ::= Range | Exp4
Range         ::= Exp4 'to' Exp4 step?
                | Exp4 '..' step?
                | '..' Exp4 step?
Step          ::= 'by' Exp4
Exp4          ::= Exp5 (addop Exp5)*
Exp5          ::= Exp6 (mulop Exp6)*
Exp6          ::= PrefixOp? Exp7
Exp7          ::= Exp8 (expop Exp8)?
Exp8          ::= ObjectCreation | Var | Exp9
Exp9          ::= Literal | '(' Exp ')' | Lambda | Comprehension

Literal       ::= nulllit | boollit | intlit | floatlit | stringlit
                | TupleLit | ListLit | SetLit | MapLit
Var           ::= id ( '[' Exp ']' | '.' id | '(' ExpList ')' )*
ExpList       ::= Exp (',' Exp)*
Lambda        ::= Params '->' Body
Comprehension ::= '[' Exp 'for' id 'in' Exp ']'
ObjCreation   ::= 'new' Var '(' ExpList ')'
TupleLit      ::= '(' TupleList? ')'
TupleList     ::= Exp ',' (Exp (',' Exp)* ','?)?
ListLit       ::= '[' ExpList? ']'
SetLit        ::= '<' ExpList? '>'
MapLit        ::= '{' BindingList? '}'
BindingList   ::= Binding (',' Binding)*
Binding       ::= endofline? id ':' Exp endofline?
```

## Features
### Comments
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
### Assignments
Variable assignments are simple. No keyword or special symbol necessary.

```
x
y = 3
z = "hello"
```
### Types
Roo has the following built-in primitive types:

```
x = 3                      # int

y = 3.0                    # double
y = 3.4
y = 0.4
y = .3
y = 3.                     # syntax error

w = true                   # bool
w = false

z = null                   # roo has a null type, which can be assigned to variables
```
Roo also has built in reference types including String, List, Set, Tuple, and Map.

```
s = "a"                    # Roo does not have characters, only strings
s = "hello"                
s = 'a'                    # Strings can use both single or double quotes
s = 'hello'

a = [1,2,3]                # lists are ordered and mutable

b = (1,2,3)                # tuples are ordered and immutable

c = <1,2,3>                # sets are unordered and mutable

d = {x:1, y:2, z:3}        # maps are a mutable collection of key-value pairs
```

#### List Ranges, Comprehensions, and Slices
Roo adds modern list functionality to make your code more readable and easier to write.

```
x = [0 to 3]               # using list ranges is the same as saying [0,1,2,3]
```
Use a similar syntax for returning list slices

```
l = ['hi','bye',1,3]
y = l[0 to 1]               # y = ['hi','bye']
y = l[0 to 2 by 2]          # y = ['hi',1]
```

Roo also has list comprehensions.

```
l = [0,1,2,3]
y = [x*2 for x in l]        # y = [0,2,4,6]
```

###String Interpolation
To compose string literals containing values from expressions, use string interpolation.
```
dogName = 'pluto'
print("The dog's name is \{dogName}.") # prints "The dog's name is pluto."
```

### Classes
You can define a class to create your own data types.

```
class CartesianPoint {
  fun constructor(xCoordinate, yCoordinate) {
    self.xCoordinate = xCoordinate
    self.yCoordinate = yCoordinate
  }
  
  fun translate(newXCoordinate, newYCoordinate) {
    self.xCoordinate = newXCoordinate
    self.yCoordinate = newYCoordinate
  }
  
  fun toString() {
    print('\{self.xCoordinate}, \{self.yCoordinate}')
  }
}
```
To create an instance of a class, use the new keyword.
```
homeCoordinate = new CartesianPoint(0,0)
homeCoordinate.translate(7,7)  #homeCoordinate is now at (7,7)
```

### Operators
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

a ** b	                                Math.pow(a, b)
a // b	                                Math.floor(a / b)

a * b                                   a * b
a / b                                   a / b
a % b                                   a % b

a++                                     a = a + 1
a--                                     a = a - 1
```
### If Statements
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
### For Loops
For loops use list comprehensions which allow you to easily loop through objects or lists.

```
people = ["jack", "jill"]

for person in people {
  goUpTheHill(person)
}
```
If you need the index as well just use the built in enumerate function.

```
for index, person in enumerate(people) {
  setAge(person, 8+index)
}
```
For looping over a certain range of numbers use the 'to' keyword.

```
for countdown in 10 to 1 {
  print(countdown)
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
If you don't need the values of your loop you can just run the following. Also use the 'by' keyword to change your iteration number.

```
                                     # Javascript equivalent

count = 8                            # var count = 8

for 1 to count by 2 {                # for (int i = 1; i <= count; i=i+2) {
  x = x/y                            #    x = x/y
}                                    # }
```
When the above code is executed it will divide x by y 4 times, looping through 1 to 8, increasing by 2 each time.

### While Loops
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
### Functions

Functions are declared with the keyword fun.

```
fun gcd(a, b) {
  if b is 0 {
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
### Insist Statement

To easily check function arguments, you can use the insist keyword to remove the boilerplate of throwing exceptions for illegal arguments.

```
fun divide(x, y) {
  insist y isnt 0
  
  return x / y
}

divide(4,0)        # throws an illegal argument exception
```

## Scoping

Roo uses lexical, function scoping. Variable declarations are bound to the local scope, unless the __**global**__ keyword is used.
Variables declared in lower scopes shadow those in higher scopes with the same name.

```
x = 4                   #local
```

```
() -> {
  global x = 4         #global 
}
```

```
x = 4 

fun add1(y) {
  return x + 1          # returns 5
}
```

```
x = 4 

fun add1(y) {
  x = 7
  return x + 1          # returns 8
}
```

```
x = 4 

fun printNum(z) {
  global y = 47
  print(z)                
}

printNum(x)            #prints 4
printNum(y)            #prints 47
```

```
x = 47

fun printANumber() {
   x = 4
   fun doThePrinting() {
      print(x)          
   }
   doThePrinting()
}

printANumber()        #prints 4
```
