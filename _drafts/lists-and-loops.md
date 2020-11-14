# List and Loops

## Hello World.

Yep good old `hello world` cliché

My name is Nicholas Stanley

* I graduated from DePaul University with a Bachelors Degree in Computer Science in 2016
* I also graduated from DePaul with a Master in Software Engineering in 2019
* During my master program I was in the Graduate Assistant program has a Tutor.
* I am currently working at Backstop solutions as a Senior DevOps Engineer leading a team of 4.
 
## Overview and Goals

* A quick list review
* Introduction into the For Loop
* Explore Loop patterns Counter, Accumulator, index iteration

### Assumptions
* You already have a basic understanding of the python syntax. (indentation, `print()`, variable expressions)
* You are aware if what a list is and just need a quick refresher.

## Quick List Overview

We humble human need to keep track of multiple things in our daily lives and to do that we make lists, a todo list, shopping list, a book list.

In programming sometime you need to do the same thing and keep track of multiple values.

To accomplish this, Python as a built in type and, because we programmers are unimaginative and like quick and effective communication, it called you guest it a list.

A list in python is just a sequence of objects for example: `vehicles = ['sedan','train','truck','plane']`

List are represented as a comma-separated sequence enclosed with square brackets.

```
vehicles = ['sedan','train','truck','plane']
#          ▲   ▲   ▲                       ▲
#          |   |   |                       |
#          |   |   |                       +--- end of list with closed square bracket ]
#          |   |   |
#          |   |   +--------------------------- comma-separates items ,
#          |   |
#          |   +------------------------------- item in a list can be any type they are strings
#          |
#          +----------------------------------- start of list with open square bracket [

```

A list's items are indexed starting a zero. You can also thing of index has position. Like get me the item at position 2.
```
# index/position:
#              0       1       2       3
vehicles = ['sedan','train','truck','plane']
```
To access individual items in the list we can use the indexing operator `list[index]`.

Lets access `'trains'` which is the 2nd item, but b/c indexing starts at 0 the 2nd item is at position 1.
```
>>> vehicles = ['sedan','train','truck','plane']
>>> vehicles[1]
>>> 'train'
```

Joke?

Lists are incredibly powerful objects and have a lot of built in methods to solve a whole host of problems, but for the purpose of this talk we are going to skip over them and focus on `for` loop and use the list to explore `for` list usability.


## `for` Loop

The `for` loop can be used to iterate over the items of a list.

iterate - the act of repeating; a repetition. its when you do something over and over again.

In programing we call objects that can be iterated over **iterable**.

```
for <variable> in <sequence>:
    <indented code block>
<non-indented statement>
```

The `<sequence>` must refer to an object that can be iterated over, for this introduction we are only going use `lists` for the sequence, but keep in mind there are many python objects that are iterable you will learn about later.

When the for loop is executed  it assigns the values in the `<sequence>` to `<variable>` one by one. Anything in the `<indented code block>` will be executed every time the loop runs until the last time in the `<sequence>` is reached.

Lets explore our first of many for loops.

### Loop 1 - List in `<sequence>`
```
print('Start.')

for i in ['sedan','train','truck','plane']:
    print(i)

print('Done.')
```
In this first example we can see `i` in the `<variable>` position with our familiar vehicles list in the `<sequence>` position and a print statement with `i` in the `<indented code block>`.

Lets run it:
```
--- output ---

Start.
sedan
train
truck
plane
Done.
```
It prints all the values in the list.

Lets look at another version of the same list.

### Loop 2 - List Variable in `<sequence>`
```
print('Start.')

vehicles = ['sedan','train','truck','plane']
for i in vehicles:
    print(i)

print('Done.')
```
In this one you can see instead of having the list itself in the `<sequence>` section we have the `vehicles` variable which is the same list defined above the for loop.
```
--- output ---
Start.
sedan
train
truck
plane
Done.
```
This illiterates the `<sequence>` can use iterable variables in our case a list variable.

Lets make another change.

### Loop 3 - `<variable>` Definition

#### Loop 3a
```
print('Start.')

vehicles = ['sedan','train','truck','plane']
for v in vehicles:
    print(v)

print('Done.')
```
We changed the `<variable>` from `i` to `v`. The `<variable>` doesn't need to be `i` it can be any variable.
```
--- output ---
Start.
sedan
train
truck
plane
Done.
```
`<variable` can even be something like `vehicle_var`
#### Loop 3b
```
print('Start.')

vehicles = ['sedan','train','truck','plane']
for vehicle_var in vehicles:
    print(vehicle_var)

print('Done.')
```
Yet again the same behavior.
```
--- output ---
Start.
sedan
train
truck
plane
Done.
```

### Loop 4 - No `<variable>` in `<indented code block>`

Even thought we have used the `<variable>` in the `<indented code block>` for every example so far that is not a requirement of `for` loops.

#### Loop 4a
```
print('Start.')

vehicles = ['sedan','train','truck','plane']
for vehicle_var in vehicles:
    print("hello")

print('Done.')
```
Here we can see the output is 4 hellos.
```
--- output ---
Start.
hello
hello
hello
hello
Done.
```

#### Loop 4b
```
print('Start.')

vehicles = ['sedan','train','truck','plane']
for vehicle_var in vehicles:
    x = 1

print('Done.')
```
```
--- output ---
Start.
Done.
```

## Counter Loop





## Accumulator Loop



## for Loop iteration thought indexes


## The End.



