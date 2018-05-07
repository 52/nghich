---
title: counter_cache
categories: rails
tags: ActiveRecord association performance
description: Finding the number of belonging objects more efficient
permalink: 
---
1 author has_many books.  
Để đếm số lưọng books của 1 author, ta dùng counter_cache thay vì chạy query COUNT.  

#### Bước 1:
Thêm column `books_count` vào table `authors`
```ruby
class AddBooksCountToAuthors < ActiveRecord::Migration[5.2]
  def change
    add_column :authors, :books_count, :integer
  end
end
```

#### Bước 2:
Thêm option `counter_cache: true` vào `belongs_to`
```
class Book < ApplicationRecord
  belongs_to :author, counter_cache: true
end
```

#### Chú ý:
Dùng `@author.books.size` để lấy số lượng sách, chứ không dùng `@author.books.count`. Vì dùng count sẽ chạy query COUNT trong db.
