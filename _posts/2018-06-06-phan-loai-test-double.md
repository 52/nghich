---
title: Phân loại test double
categories: rspec
tags: rspec test-double
description: 
permalink: 
---
Nhìn từ 2 góc độ:  

- Usage mode: what you're using it for, what you're expecting it to do
- Origin: How it is created

### Usage mode

#### Stub
Returns canned responses, avoid any meaningful computaion or I/O

#### Mock
Expect specific messages, will raise an error if it doesn't receive them by the end of the example

#### Null Object
Can stand in for any object, returns itself in response to any messages

#### Spy
Record the messages it receives, so that you can check them later

### Origin

#### Pure double
Behavior comes entirely from the test framework *(usually called mock object)*

#### Partial double
An existing Ruby object that takes on some test double behavior. Its interface is a mixture of real and fake implementations.

#### Verifying double
Totally fake like pure double.  
Constrains its interface based on a real object like partial double, matches the API it's standing in for.  

#### Stubbed Constant
A Ruby constant (class, or module name), which you create, remove, or replace for a single test



## Usage modes: stub, mock, spy

### Double chung chung
```ruby
ledger = double("Ledger")
```

### Stub
Returns canned responses, avoid any meaningful computaion or I/O.  
Best for simulating *query methods*  

```ruby
http_response = double "HTTPResponse", status: 200, body: "OK"
http_response.status # 200
http_response.body   # OK
```
```ruby
http_response = double "HTTPResponse"
allow(http_response).to receive_messages(
  status: 200,
  body:   "OK"
)
```

```ruby
http_response = double "HTTPResponse"
allow(http_response).to receive(:status).and_return 200
allow(http_response).to receive(:body).and_return "OK"
```

Stub ignore arguments, blocks  
```ruby
http_response.status(:args){:block} # 200
```
Muốn thêm arguments vào stub, dùng `with`:  
```ruby
allow(http_response).to receive(:body).with("application/json").and_return "OK"
http_response.body("application/json") # OK
```

### Mock
Expect specific messages, will raise an error if it doesn't receive them by the end of the example  

```ruby
expect(ledger).to receive :record
```
### Null Objects
Can stand in for any object, returns itself in response to any messages  

```ruby
>> yoshi = double("Yoshi").as_null_object
#> #<Double "Yoshi">

>> yoshi.eat :apple
#> #<Double "Yoshi">
```

### Spy

```ruby
class Game
  def self.play character
    character.jump
  end
end
```
Trong một số trường hợp, nếu dùng mock sẽ bị đảo lộn thứ tự 3A: Arrange/Act/Assert  
```ruby
# Arrange
mario = double "Mario"
# Assert
expect(mario).to receive :jump
# Act
Game.play mario

RSpec::Mocks.verify
```
Trong những trường hợp như thế, để gĩư đúng thứ tự 3A:  
```ruby
# Arrange
mario = double "Mario"
allow(mario).to receive :jump
#Act
Game.play mario
# Assert
expect(mario).to have_received :jump

RSpec::Mocks.verify
```
ta dùng spy:  
```ruby
# Arrange
mario = spy "Mario"
# Act
Game.play mario
#Assert
expect(mario).to have_received :jump

RSpec::Mocks.verify
```

Spy giống Null Object ở chỗ không cần phải allow to receive messages trước.  

___

## Origin: pure, partial, verifying doubles

### Pure double
All examples above are pure double  

### Partial double
An existing Ruby object that takes on some test double behavior. Its interface is a mixture of real and fake implementations.  
Tạo double dựa trên class/object đã có sẵn. Giống kiểu monkey patching.  
```ruby
random = Random.new

allow(random).to receive(:rand).and_return 0.1234

random.rand # 0.1234
```
### Verifying Double
Totally fake like pure double.  
Constrains its interface based on a real object like partial double, matches the API it's standing in for. 

Xét ví dụ dùng pure double trong spec test API:  
```ruby
ledger = double "ExpenseTracker::Ledger"
allow(ledger).to receive(:record).with(expense).and_return data
```
Nếu như sau này, ta đổi tên method `Ledger#record` thành `Ledger#record_expense`, spec vẫn pass bởi vì spec dựa trên method `record` gỉa được cung cấp.  

Nếu dùng verify double, RSpec sẽ đối chiếu xem method `record` có thực sự tồn tại hay không, nếu không, test sẽ fail.  

Để tạo verify double, dùng:  

- `instance_double(SomeClass)` giới hạn chỉ dùng instance methods
- `class_double(SomeClass)`  giới hạn chỉ dùng class methods
- `object_double(some_object)` giới hạn dùng interface của object

Tương ứng cũng có: `instance_spy`, `class_spy`, `object_spy`  

### Stubbed Constants
```ruby
stub_const("PasswordHash::COST_FACTOR", 1)
hide_const('ActiveRerord')
```
