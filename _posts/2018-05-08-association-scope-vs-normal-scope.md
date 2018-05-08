---
title: association scope VS. normal scope
categories: rails
tags: ActiveRecord association scope
description: Không có sự khác biệt về query giữa 2 trường hợp
permalink: 
---
#### Normal scope
```ruby
class Book < ApplicationRecord
  belongs_to :author
  scope :sold_out, ->{where sold_out: true}
end

class Author < ApplicationRecord
  has_many :books
end
```

#### Scope in Association
```ruby
class Book < ApplicationRecord
  belongs_to :author
end

class Author < ApplicationRecord
  has_many :books
  has_many :sold_out_books, ->{where sold_out: true}, class_name: :Book
end  
``` 

#### So sánh
Không có sự khác biệt giữa 2 trường hợp.  
`@author.books.sold_out` và `@author.sold_out_books` đều generate cùng một SQL query:
```sql
SELECT  "books".* FROM "books"
WHERE "books"."author_id" = $1 AND "books"."sold_out" = $2 
[["author_id", 1], ["sold_out", "t"]]
```
