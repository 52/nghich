---
title: 
categories: 
tags: 
description: 
permalink: 
---
Em có câu hỏi về association trong ActiveRecord mong mọi người giải thích dùm ạ  
Em có 2 model `Author` và `Book` như sau:
```ruby
class Author < ApplicationRecord
  has_many :books
end

class Book < ApplicationRecord
  belongs_to :author

  class << self
    def sold_out
      where sold_out: true
    end
  end
end

a = Author.first
```

Em muốn hỏi:  
1, `a.books` là object của class nào?  
Khi em chạy `a.books` trong console thì được trả về 1 instance object của class `ActiveRecord::Associations::CollectionProxy`. Nhưng khi em thử:
```ruby
>> a.books.instance_of? ActiveRecord::Associations::CollectionProxy
#> false

>> a.books.class
#> Book::ActiveRecord_Associations_CollectionProxy

>> a.instance_of? Book::ActiveRecord_Associations_CollectionProxy
#> NameError: private constant #<Class:0x00005638f48f85d0>::ActiveRecord_Associations_CollectionProxy referenced from (irb):5
```

2, Mối quan hệ cụ thể đằng sau của `a.books` với class `Book` là như thế nào? Tại sao lại có thể chạy class method `sold_out`
