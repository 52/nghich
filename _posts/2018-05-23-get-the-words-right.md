---
title: Get the words right
categories: rspec
tags: rspec
description: Chọn câu lệnh phù hợp trong RSpec
permalink: 
---
`describe` alias: `context`  

`it` alias: `example`, `specify`  

Chọn từ sao cho dễ hiểu, make sense nhất  

Có thể tự tạo alias bằng config (giống như `fit` đối với `it`):  

```ruby
RSpec.configure ​do​ |rspec|
​  rspec.alias_example_group_to ​:pdescribe​, ​pry: ​​true​
​  rspec.alias_example_to ​:pit​, ​pry: ​​true​
​   
​  rspec.after(​:example​, ​pry: ​​true​) ​do​ |ex|
​    require ​'pry'​
​    binding.pry
​  end​
​end​
```
