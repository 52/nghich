---
title: Phạm vi tồn tại của test double
categories: rspec
tags: rspec test-double
description: Chỉ tồn tại trong phạm vi example
permalink: 
---
Phạm vi của double chỉ tồn tại trong mỗi example. Do đó example này không thể dùng lại double ở example khác.  
Cụ thể, sau mỗi example, RSpec sẽ chạy `RSpec::Mocks.teardown` để xóa double (nếu chạy `rspec/mocks/standalone` trong `irb` thì cần phải tự teardown, sau đó chạy `Rspec::Mocks.setup`)  

Do đó, để dùng double ở phạm vi ngoài example, ví dụ như trong hook `before :context`, cần đặt double trong `with_temporary_scope`:  
```ruby
before :context do
  RSpec::Mocks.with_temporary_scope do
    my_double = double foo: 12
    ...
  end
end
```
[Tham khảo thêm về scope trên relishapp.com](https://relishapp.com/rspec/rspec-mocks/v/3-7/docs/basics/scope)
