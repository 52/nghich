---
title: inverse_of
categories: rails
tags: ActiveRecord assocation
description: Bi-directional assocations với inverse_of
permalink: 
---
## Bi-directional assocations là gì?
```ruby
class Author < ApplicationRecord
  has_many :books
end

class Book < ApplicationRecord
  belongs_to :author
end
```
Hai model `Author` và `Book` như trên chia sẻ một bi-directional assocation.  
Nhờ thế mà ActiveRecord sẽ chỉ load duy nhất một `Author` object, sẽ giúp chương trình chạy nhanh hơn và đồng bộ dữ liệu. Ví dụ:  
```bash
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

ActiveRecord sẽ tự động xác định bi-directional assocation đối với các assocation dùng cách đặt tên theo chuẩn giống như ví dụ ở trên.  
ActiveRecord không thể tự động xác định được bi-directional assocation đối với các trường hợp:
- Assocation có scope
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
```bash
>> b.writer.object_id == a.object_id
#> false

>> a.name = "Tolkien"

>> b.writer.name
#> "John"
```
Để xác định bi-directional assocation, ta dùng `inverse_of`:
```ruby
class Author < ApplicationRecord
  has_many :books, inverse_of: :writer
end
```
```bash
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
```bash
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
