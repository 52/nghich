---
title: Association extensions
categories: rails
tags: ActiveRecord association
description: Mở rộng association
permalink: 
---
## Cách 1
```ruby
class Author < ApplicationRecord
  has_many :books, inverse_of: :author do
    def sold_out
      where sold_out: true
    end

    def available
      where sold_out: false
    end
  end
end
```
## Cách 2
```ruby
module AuthorBooksAssociationExtension
  def sold_out
    where sold_out: true
  end

  def available
    where sold_out: false
  end  
end

class Author < ApplicationRecord
  has_many :books, ->{extending AuthorBooksAssociationExtension},
           inverse_of: :author
end
```

## Cách 3
```ruby
class Book < ApplicationRecord
  belongs_to :author

  scope :sold_out, ->{where sold_out: true}
  scope :available, ->{where sold_out: false}
end  
```

## Cách 4
```ruby
class Book < ApplicationRecord
  belongs_to :author

  class << self
    def sold_out
      where sold_out: true
    end

    def available
      where sold_out: false
    end
  end
end  
```
## Nhận xét

Cách 1, 2 sử dụng association extensions  
Cả 4 cách đều như nhau, đều có thể sử dụng `@author.books.sold_out`, `@author.books.sold_out.create`  
Với cách 3, 4 có thể sử dụng `Book.sold_out`, `Book.available`

## Association scope
Về bản chất, association scope là một association extension đặc biệt
```ruby
class Author < ApplicationRecord
  has_many :books, ->{where sold_out: true},
           inverse_of: :author
end
```
