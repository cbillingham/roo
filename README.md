![alt text](roo/roo.jpg)

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
}
