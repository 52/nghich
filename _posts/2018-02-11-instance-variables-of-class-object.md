---
title: Maintaining per-class stats with instance variables of class objects
categories: ruby
tags: class-object instance-variables
description: 
permalink: 
---

## The problem
Let's say you have a class and you want to keep track of number of its instances. Using a **class variable** may be the first thing that come to your mind.
Consider this example:
```ruby
class Car
  @@total_count = 0
  def initialize
    @@total_count += 1
  end
  def self.total_count
    @total_count
  end
end

c1 = Car.new
c2 = Car.new

puts "Number of cars: #{Car.total_count}"
# => Number of cars: 2
```
It looks good and all until someone creates a new class that inherits from your class:
```ruby
class Hybrid < Car
end
h = Hybrid.new
```
You come back to check your code, and now the number of cars changed:
```ruby
puts "Number of cars: #{Car.total_count}"
# => Number of cars: 3
```
`@@total_count` increased after creating a new instance of `Hybrid` because *class variables are shared between a class and its sub-classes*.  
You could say a `Hybrid` car *is_a* `Car`, so the number of cars increased is totally understandable. But what if you don't want that? What if you want to protect a class stats from being changed by its sub-classes?

## The solution
In Ruby, everything is object, even class. Classes are just special objects. In fact, every class is an instance of a class called `Class`:
```ruby
Car.instance_of? Class
# => true
```

Because a class is an object ( we'll call it  a **class object** (object of class `Class`) ), so it can have its own instance variables, which only accessible by the class object itself. Therefore, we could use class object's instance variables to store stats about itself.

*(Note: class object's instance variables are totally different from instance variables of its instances.) (Example about this at footnote.)*
```ruby
class Car
  # define getter for the class object
  def self.total_count
    # @total_count is instance variable of the class object
    @total_count ||= 0
  end

  # define setter for the class object
  def self.total_count= value
    @total_count = value
  end

  def initialize
    self.class.total_count += 1
  end
end

c1 = Car.new
c2 = Car.new

puts "Number of cars: #{Car.total_count}"
# => Number of cars: 2
```
And now, when someone creates a subclass inherits from your class, that subclass will have its own instance variable `@total_count`, will have its own stats:
```ruby
class Hybrid < Car
end
h = Hybrid.new

puts "Number of cars: #{Car.total_count}"
# => Number of cars: 2

puts "Number of hybrid: #{Hybrid.total_count}"
# => Number of cars: 1
```
--------
**Note**: *class object's instance variables are totally different from instance variables of its instances.*
```ruby
class Car
  attr_writer :total_count # line 2
  def total_count
    @total_count #line 4
  end
  def self.total_count
    @total_count ||= 0 # line 7
  end
end
```
- `@total_count` on line 7 is instance variable of **class object** `Car`
- `@total_count` on line 2 and 4 is instance variable of instances of class `Car`
 
Source: **The Well-grounded Rubyist, 2nd Edition** *(p143)* by **David Black**
*(I rephrased according to my understanding.)*
