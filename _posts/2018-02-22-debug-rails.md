---
title: Một vài mẹo debug Rails
categories: rails
tags: debug byebug
description: 
permalink: 
---
## `debug(params)`
Thêm vào cuối layout:  
```ruby
# app/views/layouts/application.html.erb
<%= debug(params) if Rails.env.development? %>
```
Refresh browser, sẽ hiện lên thông tin của `params` dưới dạng YAML:
```yaml
--- !ruby/object:ActionController::Parameters
parameters: !ruby/hash:ActiveSupport::HashWithIndifferentAccess
  controller: users
  action: show
  id: '1'
permitted: false
```
## `console`
Thêm vào cuối layout:
```ruby
# app/views/layouts/application.html.erb
<%= console if Rails.env.development? %>
```
Refresh browser sẽ hiện lên console, dùng console này để debug.
## Dùng gem `byebug`
Đặt `debugger` ở điểm muốn breakpoint. Ví dụ:
```ruby
class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    debugger
  end
end
```
Sau khi reload địa chỉ `localhost:3000/users/1`, ở cửa sổ `rails server` sẽ xuất
hiện con trỏ `(byebug)`. Dùng con trỏ này để debug. 
