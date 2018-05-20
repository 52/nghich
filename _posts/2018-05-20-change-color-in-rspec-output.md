---
title: Change color in RSpec output
categories: rspec
tags: rspec
description: Chuyển màu failed test từ đỏ sang vàng 
permalink: 
---
#### Step 1:
Tạo file config
```ruby
# File ~/.spec_color.rb
RSpec.configure do |config|
  config.failure_color = :yellow
  config.color_mode = :on
end
```

#### Step 2:
Thêm option để tự động require file config mỗi lần chạy `rspec`
```ruby
# File ~/.rspec
--require "~/.spec_color"
```
