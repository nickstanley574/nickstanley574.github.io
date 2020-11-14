# List and Loops

## Hello World.

Yep the `hello world`

* DePaul University - Bachelors in Computer Science in 2016
* DePaul University - Master in Software Engineering in 2019
* During my master program I was in the Graduate Assistant program has a Tutor.
* I am currently working at Backstop solutions as a Senior DevOps Engineer leading a team of 4. I have been at backstop for about a year and a have now.
* Before Backstop I worked a Discovery Education for 4 years as a System/DevOps Engineer.

## Overview and Goals

* A quick list review
* Introduction into the For Loop
* Explore Loop patterns Counter, Accumulator, index iteration

### Assumptions
* You already have a basic understanding of the python syntax. (indentation, `print()`, variable expressions)
* You are aware if what a list is and just need a quick refresher.

## Quick List Overview

We humble human need to keep track of multiple things in our daily lives and to do that we make lists, a todo list, shopping list, a book list.

In programming sometime you need to do the same thing and keep track of multiple values, add items.

To accomplish this python as a built in type and, because we programmers are unimaginative and like quick and affective communication, it called you guest it a list.

A list in python is just a sequence of objects for example: `vehicles = ['sedan','train','truck','plane']`

List are represented as a comma-separated enclosed with square brackets.

```
vehicles = ['sedan','train','truck','plane']
#          ▲       ▲           ▲           ▲
#          |       |           |           |
#          |       |           |           +--- end of list with closed bracket ]
#          |       |           |
#          |       |           +--------------- item in a list can be any type they are strings
#          |       |
#          |       +--------------------------- comma-separates items ,
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
 lists are incredibly powerful objects and have a lot of built in methods at solve a whole host of problems, but for the purpose of this talk we are going to skip over them and focus on `for` loop and use the list to explore `for` list usability.


## `for` Loop

The `for` loop can be used to iterate over the items of a list.

iterate - the act of repeating; a repetition. When you dp something over and over again, that is iteration.

In programing we call objects that can be iterated over **iterable**.

```
for <variable> in <sequence>:
    <indented code block>
<non-indented statement>
```

the `<sequence>` must refer to an object that can be iterated over, for this introduction we are only going use `lists` for the sequence, but keep in mind there are many python objects that are iterable you will learn about later.

When the for loop is executed  it assigns the values in the `<sequence>` to `<variable>` one by one after each loop integration. Anything in the `<indented code block>` will be executed every time the loop until the last time in the `<sequence>`.

Lets explore our first of many for loops.

### Loop 1
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

### Loop 2
```
print('Start.')
vehicles = ['sedan','train','truck','plane']
for i in vehicles:
    print(i)
print('Done.')
```
In this one you can see instead of have the list itself in the `<sequence>` section we have the `vehicles` variable which is the same list defined above.
```
--- output ---
Start.
sedan
train
truck
plane
Done.
```
This illiterates the sequence vaiables 

### Loop 3
```
print('Start.')
vehicles = ['sedan','train','truck','plane']
for v in vehicles:
    print(v)
print('Done.')

--- output ---
Start.
sedan
train
truck
plane
Done.
```


## Counter Loop





## Accumulator Loop



## for Loop iteration thought indexes


## The End.



