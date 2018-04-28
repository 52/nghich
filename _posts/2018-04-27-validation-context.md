---
title: Validation context với :on
categories: rails
tags: ActiveRecord validation context
description: 
permalink: 
---
```ruby
class User < ApplicationRecord
  validates_presence_of :name, :age
  validates_length_of :name, minimum: 3, on: :user
  validates_length_of :name, minimum: 1, on: :admin
end
```
```bash
>> u = User.new name: "ab"
=> #<User id: nil, name: "ab", age: nil>
```
Validate với scope `:user`:
``` bash
>> u.valid? :user
=> false

>> ap u.errors.messages
{
     :age => [
        [0] "can't be blank"
    ],
    :name => [
        [0] "is too short (minimum is 3 characters)"
    ]
}
```
Validate với scope `:admin`:
```bash
>> u.valid? :admin
=> false

>> ap u.errors.messages
{
    :age => [
        [0] "can't be blank"
    ]
}
```
Validate với scope mặc định:
```bash
>> u.valid?
=> false

>> ap u.errors.messages
{
    :age => [
        [0] "can't be blank"
    ]
}
```

ActiveRecord cung cấp sẵn 2 context:
- `on: :create` validation sẽ chạy khi tạo mới một object
- `on: :update` validation sẽ chạy khi update một object  


Cũng có thể chạy validation trong nhiều context

```ruby
validates_length_of :name, minimum: 3, on: [:user, :create]
```
