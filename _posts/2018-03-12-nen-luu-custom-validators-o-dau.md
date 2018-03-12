---
title: Nên lưu custom validators ở đâu
categories: rails
tags: validation best-practice
description: 
permalink: 
---
## `app/validators`
Khi lưu trong folder `app`, validators sẽ được tự động load.
## `lib/validators`
Khi lưu trong folder `lib`, validators sẽ KHÔNG được load tự động.  
Để load validators cần config `autoload_paths`:
```ruby
# File /config/application.rb
config.autoload_paths << "#{config.root}/lib/validators/"
```
Cá nhân thích cách 2 hơn.
