# Roo

A simple curly-brace language.

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
```
for x in [1..5] {
  return x
}
```
###While Loops
