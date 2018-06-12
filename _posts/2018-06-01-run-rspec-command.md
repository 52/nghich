---
title: Run rspec command
categories: rspec
tags: rspec
description: Chạy lệnh rspec trong terminal
permalink: 
---

#### `rspec -fd`
`rspec --format documentation`  
In output dưới dạng documentation

#### `rspec --profile 2`
List 2 examples chạy chậm nhất

#### chạy test cụ thể
```bash
>> rspec spec/unit
#> run tests in this dir and its subdirs

>> rspec spec/unit/specific_spec.rb
#> run this file

>> rspec spec/unit/specific_spec.rb:10
#> run the test on line 10
```

#### chạy test theo tên
```bash
>> rspec -e milk -fd
#> chạy tất cả các test có chứa từ 'milk' trong description
```

#### chỉ chạy lại failed tests
```bash
>> rspec --next-failure
#> chạy failed test tiếp theo

>> rspec --only-failures
#> chạy toàn bộ failed test
```
Để chạy được, trước tiên phải tạo một file để lưu status của tests, và config trong RSpec lưu đường dẫn tới file đó  
```ruby
RSpec.configure do |config|
  config.example_status_persistence_file_path = "/tmp/rspec"
end

```

#### run focused tests
Đánh dấu focused test bằng các từ khóa: `fdescribe`, `fcontext`, `fit`. Ví dụ:  
```ruby
RSpec.describe "a cup of coffee" do
  let(:coffee){Coffee.new}

  it "costs $1" do
    expect(coffee.price).to eq(1.00)
  end

  context "with milk" do
    before{coffee.add :milk}

    fit "costs $1.25" do
      expect(coffee.price).to eq(1.25)
    end
  end
end
```
hoặc thêm hash option ở test muốn focus   
```ruby
it "costs $1.25", focus: true do
  expect(coffee.price).to eq(1.25)
end
```

Khi chạy `rspec`, sẽ chỉ chạy test `a cup of coffee with milk costs $1.25`.  
Để chạy focused tests ta cần config:  
```ruby
RSpec.describe do |config|
  config.filter_run_when_matching :focus
end
```
hoặc chạy lệnh `rspec` với option:  
```bash
rspec --tag focus
```

#### Chạy spec theo tag

Chạy tất cả các spec có tag `:fast`:  
```bash
rspec --tag fast
```

Chạy tất cả các spec , trừ các spec có tag `:fast`:  
```bash
rspec --tag '~fast'
```

#### Các option khác

Option `--fail-fast` dừng ngay test khi có một example fail  

#### Cách set sẵn các option hay sử dụng

Có một số option ta hay sử dụng, để không phải type các options này mỗi lần chạy rspec, ta có thể lưu trong các file:  
- `~/.rspec` global personal preferences
- `./.rspec` preferences ở phạm vi project, dùng chung cho mọi người trong team 
- `./.rspec-local` preferences ở phạm vi project, dùng cho cá nhân, nên gitignore file này

Theo thứ tự, options ở file sau sẽ override options ở file trước.  
Cũng có thể set options trong environment variable `SPEC_OPTS`. Options ở đây sẽ override options ở tất cả các file trên.  
  
#### Tips

`rspec -rbyebug` require "byebug" trước khi chạy rspec. Tiện lợi khi debug spec.  

`rspec` sẽ tự động thêm 2 folder `./spec` và `./lib` vào `$LOAD_PATH` khi chạy. Vì thế ta có thể `require` các file trong 2 folders này, thay vì `require_ralative`  
