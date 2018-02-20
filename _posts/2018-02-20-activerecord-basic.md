---
title: ActiveRecord basic
categories: rails
tags: ActiveRecord
description: Một vài lệnh ActiveRecord căn bản
permalink:
---
## Create
```ruby
john = User.new name: "John", email: "john@local.com"
john.save
```
Or:
```ruby
john = User.create name: "John", email: "john@local.com"
```

## Destroy
```ruby
john.destroy
```

## Update
```ruby
john.name = "John Doe"

# To revert changes, using `reload` based on database information
john.reload # {name: "John", email: "john@local.com"}

john.save
```
Or:
```ruby
# alias: `update`
john.update_attributes name: "John Doe", email: "johndoe@local.com"
```
`update_attributes` sẽ chạy validations, callbacks trước khi `save`.  
Trả về `true` nếu thành công, `false` nếu thất bại.  

Update 1 attribute:
```ruby
john.update_attribute :name, "John Doe"
```
`update_attribute` không chạy validations, có chạy callbacks  

Ngoài ra có thể update trực tiếp vào database dùng `update_columns`.  
`update_columns` khác `update_attributes` ở 3 điểm:  
- Không chạy validations
- Không chạy callbacks
- Không cập nhật timestamp `update_at`

## Query
### `find`
- Tìm theo `id`
- Raise exception nếu không tìm thấy  

```ruby
User.find 1
# => <#User id: 1, name: "John", email: "john@local.com">
```
### `first`, `last`
- `first(n)` lấy n phần tử đầu tiên
- `last(n)` lấy n phần tử cuối cùng
- `first`, `second`, `third`, `fouth`, `fifth` lần lượt lấy 5 phần tử đầu tiên
- `last`, `second_to_last`, `third_to_last` lần lượt lấy 3 phần tử cuối cùng  

Tất cả đều trả về `nil` nếu không tìm thấy.  
Nếu không có order thì mặc định order theo primary key
### `take`
`take(n)` lấy ra n phần tử. Nếu không có order thì không đặt order mặc định
### `find_by`
```ruby
Post.find_by name: 'Spartacus', rating: 4
Post.find_by "published_at < ?", 2.weeks.ago
```
Trả về record đầu tiên thỏa mãn điều kiện.  
Trả về `nil` nếu không tìm thấy  
### `where`
### `select`
### `order`
### `pluck`
### `exist?`

## method!
Các method của ActiveRecord có dạng `method!` đều raise exception khi thất bại thay
vì trả về `false` hay `nil`. Ví dụ:   
- `save` trả về `nil` khi thất bại
- `save!` raise exception khi thất bại
