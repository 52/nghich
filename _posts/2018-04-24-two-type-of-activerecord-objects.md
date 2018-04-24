---
title: 2 types of ActiveRecord objects
categories: rails
tags: ActiveRecord
description: 
permalink: 
---
There are two kinds of Active Record objects: those that correspond to a row inside your database and those that do not.  
Active Record uses the `new_record?` instance method to determine whether an object is already in the database or not.  
```bash
$ rails c
>> p = Person.new name: "John Doe"
=> #<Person id: nil, name: "John Doe">
>> p.new_record?
=> true
>> p.save
=> true
>> p.new_record?
=> false
```
