---
title: spacer_template 
categories: rails
tags: view partials template
description: Ngăn cách giữa các phần tử khi dùng collection based partials trong view
permalink: 
---
```ruby
# File /app/views/posts/_post.html.erb
<h1><%= post.title %></h1>
<p><%= post.content %></p>
<hr/>
```

```ruby
# File /app/views/posts/index.html.erb
<%= render @posts %>
```
Thay vì phải đặt `<hr/>` cuối mỗi post để ngăn cách các posts, ta có thể dùng `spacer_template` như sau:  
```ruby
# File /app/views/posts/index.html.erb
<%= render partial: @posts, spacer_template: "post_ruler" %>
```

```ruby
# File /app/views/posts/_post_ruler.html.erb
<hr/>
```
