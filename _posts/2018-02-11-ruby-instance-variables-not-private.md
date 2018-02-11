---
title: Modify private instance variables
categories: ruby
tags: private instance-variables
description: In Ruby, instance variables aren't truly "private"
permalink: /ruby/instance-variables-not-private
---

You can access and modify an object's instance variables using `instance_variable_get` and `instance_variable_set` method.  
Example:
```ruby
class C
  def initialize
    self.x = 2
  end

  private
  attr_accessor :x
end

c = C.new

# NoMethodError: private methods `x` and `x=`called
c.x = 4
puts c.x

# But this is alright
c.instance_variable_set :@x, 4
c.instance_variable_get :@x # => 4
```
