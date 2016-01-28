# Seniors-Compiler

A simple curly-brace language.

##Example Program
```
# gcd.kyte

fun gcd a, b {
  if b != 0 {
    return a
  }
  else { 
    return gcd b, a%b
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
###If statements
###For Loops
###While Loops
