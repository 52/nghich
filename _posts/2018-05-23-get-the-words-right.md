---
title: Get the words right
categories: rspec
tags: rspec
description: Chọn câu lệnh phù hợp trong RSpec
permalink: 
---
`example_group` có alias: `describe`, `context`  

`example` có alias: `it`, `specify`  

Chọn từ sao cho dễ hiểu, make sense nhất  

Có thể tự tạo alias bằng config (giống như `fit` đối với `it`):  

```ruby
RSpec.configure ​do​ |rspec|
​  rspec.alias_example_group_to ​:pdescribe​, ​pry: ​​true​
​  rspec.alias_example_to ​:pit​, ​pry: ​​true​
​   
​  rspec.after(​:example​, ​pry: ​​true​) ​do​ |ex|
​    require ​"pry-byebug"
​    binding.pry
​  end​
​end​
```

Giải thích ví dụ:  
```ruby
pit "can use pry-byebug to debug" do
end
```
Với mỗi example defined với `pit`, hoặc example group defined với `pdescribe` sẽ được gắn tag `pry: true` vào metadata.  
Các example hoặc example group có tag này sẽ được `require "pry-byebug"` chèn `binding.pry` ở cuối (bằng cách dùng hook `after`) để có thể debug.
