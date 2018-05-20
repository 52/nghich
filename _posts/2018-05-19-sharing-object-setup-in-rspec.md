---
title: Sharing object setup in RSpec
categories: rspec
tags: rspec
description: Object setup dùng chung giữa các test trong RSpec
permalink: 
---

Giả sử mỗi test đều cần một instance object `Sandwich`. Để giữ code DRY ta có thể setup object chung giữa các test theo một trong 3 cách sau  

##### Hook
```ruby
RSpec.describe "a sandwich" do
  before {@sandwich = Sandwich.new "delicious", []}

  it "is delicious" do
    expect(@sandwich.taste).to eq("delicious")
  end  
end
```
Dùng hook để setup object có những hạn chế:
- Hook sẽ chạy trước mỗi test, ngay cả test không cần dùng tới instance object @sandwich
- Phải đổi lại tên object trong tất cả các test thành instane variable `@sandwich`
- Nếu misspell tên biến `@sandwich` thì biến sẽ có giá trị là `nil`, rất khó để debug  

##### Helper method
```ruby
RSpec.describe "a sandwich" do
  def sandwich
    @sandwich ||= Sandwich.new "delicious", []
  end

  it "is delicious" do
    expect(sandwich.taste).to eq("delicious")
  end
end
```
Chú ý:  
- Phạm vi của `RSpec.describe ... do end` như là phạm vi của một class definition. Cho nên method `sandwich` là một instance method của class này
- Phạm vi của `it ... do end` như là phạm vi của một instance object của class ở trên
 
Helper method trên dùng memoization pattern. [Đọc thêm](http://www.justinweiss.com/articles/4-simple-memoization-patterns-in-ruby-and-one-gem/)  

##### `let`
```ruby
RSpec.describe "a sandwich" do
  let(:sandwich){Sandwich.new "delicious", []}

  it "is delicious" do
    expect(sandwich.taste).to eq("delicious")
  end
end
```

Nguồn: Effective Testing with RSpec 3, Chap 1, Sharing Setup
