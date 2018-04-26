---
title: Customize validation error messages
categories: rails
tags: ActiveRecord validation I18n
description: Tùy biến thông báo lỗi validation
permalink: 
---
Ta có thể tùy biến thông báo lỗi validation bằng cách config locale sử dụng `I18n`.  
Ví dụ file `config/locales/en.yml`:
```yaml
en:
  activerecord:
    errors:
      models:
        user:
          attributes:
            name:
              blank: "can't be blank"
            age:
              not_a_number: "must be a number"
              not_an_integer: "must be an integer"

```
Mỗi một lỗi vi phạm validation, sẽ đi kèm với một symbol để chỉ lỗi đó.  
Như ví dụ ở trên:
- Vi phạm `validates_presence_of :name` sẽ dẫn đến lỗi `:blank`
- Vi phạm `validates_numericality_of :age` sẽ dẫn đến lỗi `:not_a_number`
- Vi phạm `validates_numericality_of :age, only_integer: true` sẽ dẫn đến lỗi `:not_an_integer`

Để biết symbol tương ứng với một lỗi cụ thể nào đó, ta tạo một object vi phạm lỗi đó và chạy `object.errors.details`. Ví dụ:
```bash
>> u = User.new name: "", age: 22.5

>> u.valid?
=> false

>> ap u.errors.details
```
Thông tin trả về:
```
{
  :name => [
    [0] {
      :error => :blank
    },

  ],

  :age => [
    [0] {
      :error => :not_an_integer,
      :value => 22.5
    }
  ]
}
```
Note: `ap` là câu lệnh của `awesome_print`  

Ta cũng có thể tùy biến tên của models cũng như attributes. Ví dụ:
```yaml
en:
  activerecord:
    models:
      user: "Customer"

    attributes:
      user:
        email: "E-mail address"

    errors:
      models:
        user:
          attributes:
            name:
              blank: "can't be blank"

```
