---
title: Load `lib` folder in Rails 5
categories: rails
tags: config loading
description: 
permalink: 
---
Đôi khi có một số component chúng ta muốn tách riêng và lưu trong thư mục `lib`.  
Để Rails load thư mục `lib` khi chương trình khởi tạo, ta phải config trong file `/config/application.rb` như sau:
```ruby
# File /config/application.rb

module AppName
  class Application < Rails::Application
    # Load `lib` directory
    config.eager_load_paths << "#{Rails.root}/lib"
  end
end
```
