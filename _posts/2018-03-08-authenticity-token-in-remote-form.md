---
title: Authenticity token trong remote form
categories: rails
tags: ajax form authenticity-token
description: 
permalink: 
---
Authenticity token dùng để chống CSRF *(cross site request forgery)*  
Khi dùng ajax, remote form lấy authenticity token ở `meta` tag trên `head`, do đó
việc chèn authenticity token vào form là không cần thiết.  
Tuy nhiên, nếu muốn hỗ trợ cả trong trường hợp người dùng disable Javascript, ví dụ như:
```ruby
respond_to do |format|
  format.html
  format.js
end
```
Khi đó, việc thêm authenticity token vào form là cần thiết. Lúc này cần set config:
```ruby
# File /config/application.rb
module SampleApp
  class Application < Rails::Application
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end
```
