---
title: Customize test double
categories: rspec
tags: rspec test-double
description: 
permalink: 
---

## Configure responses for test double

```ruby
# The most flexible way to customize test double
# will run the block everytime call `double.message(args)`
allow(double).to receive(:message) do|args|
  do_something_with(args)
end
```
```ruby
allow(double).to receive(:message).and_return a_value
allow(double).to receive(:message).and_yield a_value_to_a_block
allow(double).to receive(:message).and_raise AnException
allow(double).to receive(:message).and_throw :a_symbol, optional_value
```
Với riêng partial double:  
```ruby
allow(object).to receive(:message).and_call_original
allow(object).to receive(:message).and_wrap_original do |original, args|
  original.call(args)
  ...
end
```
Chú ý:  

```
expect(existing_object).to receive(:mesage)
```
không chỉ tạo expectation mà còn thay đổi cả hành vi của object.  
khi chạy `existing_object.message` sẽ return `nil` và không làm gì khác.  
Để gĩư nguyên hành vi của object, ta dùng `and_call_original`  
Để thay đổi một chút hành vi của object, dựa trên hành vi có sẵn, ta dùng `and_wrap_original`. Ví dụ như khi truy vấn từ API, ta muốn giới hạn số item trả về trong test so với số lượng thực, để gĩư test ngắn gọn.  


## Set constraints for test double

#### Constrain arguments

```ruby
expect(movie).to receive(:record_review).with "Good"
```
More at: [relishapp.com](https://relishapp.com/rspec/rspec-mocks/v/3-7/docs/setting-constraints/matching-arguments)  

#### Constrain how many times a method gets called

```ruby
client = instance_double("NasdaqClient")
expect(client).to receive(:current_price).exactly(4).times.and_raise(Timeout::Error)
```
Others: `once`, `twice`, `thrice`, `at_least`, `at_most`  


#### Constrain ordering

```ruby
expect(greeter).to receive(:hello).ordered
expect(greeter).to receive(:goodbye).ordered

# This will fail:
greeter.goodbye
greeter.hello
```
