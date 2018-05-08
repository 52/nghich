---
title: inverse_of
categories: rails
tags: ActiveRecord association
description: Bi-directional associations với inverse_of
permalink: 
---
## Bi-directional associations là gì?
```ruby
class Author < ApplicationRecord
  has_many :books
end

class Book < ApplicationRecord
  belongs_to :author
end
```
Hai model `Author` và `Book` như trên chia sẻ một bi-directional association.  
Nhờ thế mà ActiveRecord sẽ chỉ load duy nhất một `Author` object, sẽ giúp chương trình chạy nhanh hơn và đồng bộ dữ liệu. Ví dụ:  
```ruby
>> a = Author.first
#> <#Author id: 1, name: "John">

>> b = a.books.first

>> b.author.object_id == a.object_id
#> true

>> a.name = "Tolkien"

>> b.author.name
#> "Tolkien"
```
Trong ví dụ trên, `a` và `b.author` là một object.  

ActiveRecord sẽ tự động xác định bi-directional association đối với các association dùng cách đặt tên theo chuẩn giống như ví dụ ở trên.  
ActiveRecord không thể tự động xác định được bi-directional association đối với các trường hợp:
- Association có scope
- Dùng option `:foreign_key`
- Dùng option `:through`  

Đối với các trường hợp này, ta phải sử dụng option `inverse_of`.

## `inverse_of` với `:foreign_key`
```ruby
class Author < ApplicationRecord
  has_many :books
end

class Book < ApplicationRecord
  belongs_to :writer, class_name: :Author, foreign_key: :author_id
end
```
```ruby
>> b.writer.object_id == a.object_id
#> false

>> a.name = "Tolkien"

>> b.writer.name
#> "John"
```
Để xác định bi-directional association, ta dùng `inverse_of`:
```ruby
class Author < ApplicationRecord
  has_many :books, inverse_of: :writer
end
```
```ruby
>> b.writer.object_id == a.object_id
#> true

>> a.name = "Tolkien"

>> b.writer.name
#> "Tolkien"
```

## `inverse_of` với `:through`
```ruby
class Doctor < ApplicationRecord
  has_many :appointments
  has_many :patients, through: :appointments
end

class Patient < ApplicationRecord
  has_many :appointments
end

class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
end
```
```ruby
>> d = Doctor.first
>> p = Doctor.patients.build name: "P"

>> p.save

#> INSERT INTO "patients" ("name") VALUES ($1) RETURNING "id"  [["name", "P"]]
```
Trong trường hợp trên, tạo một patient từ một doctor chỉ tạo mới patient chứ không tạo mới appointment tương ứng.  
Để tạo mới cả appointment tương ứng khi thêm patient từ một doctor object, ta dùng `inverse_of`:
```ruby
class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient, inverse_of: :appointments
end
```
```bash
>> d = Doctor.first
>> p = Doctor.patients.build name: "P"

>> p.save

#> INSERT INTO "patients" ("name") VALUES ($1) RETURNING "id"  [["name", "P"]]
#> INSERT INTO "appointments" ("doctor_id", "patient_id") VALUES ($1, $2) RETURNING "id"  [["doctor_id", 1], ["patient_id", 1]]
```

#### Tips:
Nên luôn set option `inverse_of` trong mọi association  
Để kiểm tra một association có inverse hay không:
```ruby
Author.reflect_on_association(:books).has_inverse?
```
```ruby
@author.books.target
@author.books.proxy_association
@author.books.proxy_association.owner
@author.books.proxy_association.target
@author.books.proxy_association.reflection
```
