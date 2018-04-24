---
title: Định dạng file schema
categories: rails
tags: schema
description: File schema có 2 định dạng :ruby và :sql
permalink: 
---
Schema là file mô tả cấu trúc của database. Khi chạy `rails db:setup`, Rails sẽ dùng file này để tạo database. Mỗi khi chạy migration, Rails sẽ tự động update schema. File schema chỉ nên dùng để tham khảo cấu trúc db. Nếu muốn thay đổi db thì dùng migration chứ không được edit trực tiếp file schema.  

File schema có thể có 2 định dạng: `:ruby` và `:sql`. Định dạng mặc định là `:ruby`.  
Có thể thay đổi định dạng file schema bằng cách config:
```ruby
# File config/application.rb
module AppName
  class Application < Rails::Application

    # Using sql schema
    config.active_record.schema_format = :sql
  end
end
```
- Nếu định dạng là `:ruby`, chạy task `rails db:schema:dump` sẽ tạo file schema `db/schema.rb`
- Nếu định dạng là `:sql`, chạy task `rails db:structure:sump` sẽ tạo file schema `db/structure.sql`

Sự khác biệt giữa 2 định dạng là `schema.rb` dùng DSL để tạo db. DSL có hạn chế là không thể biểu hiện được một số tính năng của sql db như constraint, trigger,..
