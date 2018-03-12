---
title: Create password in fixture for Devise users
categories: rails
tags: devise fixture minitest password
description: Cách tạo password cho user có sử dụng Devise trong fixture
permalink: 
---
Ví dụ, ta có model `User` sử dụng Devise. Để tạo password cho users trong fixture
để dùng trong test, ta làm như sau:  
```ruby
john:
  email: john@local.com
  encrypted_password: <%= User.new.send :password_digest, "john_password" %>
```
