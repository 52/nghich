---
title: Share code trong RSpec
categories: rspec
tags: rspec
description: 
permalink: 
---
Dùng include module bình thường chỉ share được helper methods giữa các example groups. Để có thể share để dùng lại được cả example, `let` và hooks, ta dùng *shared example groups*  

- A shared example group can contains examples, helper methods, `let` declarations, and hooks like a normal example group.
- A shared example group exists *only* to be shared.  

Keywords to define/use a shared group:    
- `shared_context` / `include_context` are for reusing *common setup* and *helper logic*  
- `shared_examples` / `include_examples` | `it_behaves_like` are for reusing *examples*

They're the same. Just a matter of 'get the words right'  

```ruby
# Sharing Context
RSpec.shared_context "API helpers" do
  include Rack::Test::Methods

  before do
    basic_authorize "user", "password"
  end
end

RSpec.describe "Expense Tracker API" do
  include_context "API helpers"
end
```
```ruby
# Sharing Example
RSpec.shared_examples "KV store" do |kv_store_class|
  let(:kv_store) { kv_store_class.new }

  it 'allows you to fetch previously stored values' do
    kv_store.store(:language, 'Ruby')
    expect(kv_store.fetch(:language)).to eq 'Ruby'
  end
end

RSpec.describe "Key-value stores" do
  it_behaves_like "KV Store", HashKVStore
  it_behaves_like "KV Store", FileKVStore

  # include_examples "KV Store", HashKVStore
  # include_examples "KV Store", FileKVStore
end
```

`it_behaves_like` vs `include_examples`:  

`include_examples` copy trực tiếp shared examples và paste vào `describe` block. Output:  
```
Key-value stores
  allows you to fetch previously stored values
  allows you to fetch previously stored values
```

`it_behaves_like` thì wrap shared examples bên trong một context trước khi paste vào `describe` block. Output:  
```
Key-value stores
  behaves like KV store
    allows you to fetch previously stored values
  behaves like KV store
    allows you to fetch previously stored values
```

When in doubt, use `it_behaves_like`  

Đọc thêm trong cuốn Effective Testing > Part 3: RSpec core > Chap 7: Structring Code Example > Sharing Example Groups > Nesting  

`it_behaves_like` cũng có thể nhận một block. Ví dụ:  

```ruby
RSpec.shared_examples "KV store" do
  it 'allows you to fetch previously stored values' do
    kv_store.store(:language, 'Ruby')
    expect(kv_store.fetch(:language)).to eq 'Ruby'
  end
end

require "tempfile"
RSpec.describe "Key-value stores" do
  it_behaves_like "KV Store" do
    let(:tempfile) {Tempfile.new("kv.store")}
    let(:kv_store) {FileKVStore.new(tempfile.path)}
  end
end
``` 
