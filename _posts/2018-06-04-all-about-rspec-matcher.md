---
title: Tổng quan về matchers
categories: rspec
tags: rspec matcher
description: Tất tần tật về RSpec::Matchers
permalink: 
---

## RSpec expectations

Ví dụ về một expectation:  
```ruby
expect(deck.cards.count).to eq(52), "not playing with a full deck"
```
Một expectation gồm 3 phần:  

- A subject: what we test
- A matcher: what we expect to be true about the subject
- A custom failure message (optional)
___

## 3 ways to composing matchers

#### Pass one matcher into another
```ruby
expect([]).to start_with(a_value_within(0.1)of(Math::PI))
```

#### Embed matchers in array and hash data structures

```ruby
presidents = [
  {name: "Washington", birth_year: 1732},
  {name: "Jefferson", birth_year: 1743},
  ...
]

expect(presidents).to start_with(
  {name: "Washington", birth_year: a_value_within(1730, 1740)}
)
```

#### Combine with and/or

```ruby
alphabet = ("a".."z").to_a
expect(alphabet).to start_with("a").and end_with("z")
```
alias for and/or: `&`, `|`  
```ruby
start_with("a") & end_with("z")
```
___

## Matcher description

Mỗi matcher đi kèm với một description  
```ruby
a_string_starting_with('a').description
#> "a string starting with 'a'"
```
Nếu example không cung cấp description, RSpec sẽ dùng description của matcher. Ví dụ:  
```ruby
specify do
  expect(Cookie.new.ingredients).to include(:chocolate, :eggs)
end
```
có description giống với  
```ruby
it "should include :chocolate, and :eggs" do
  expect(Cookie.new.ingredients).to include(:chocolate, :eggs)
end
```

___

## List of matchers

Nguyên tắc chọn matchers:  

- Express exactly how you want the code to behave, without being to strict or too lax
- Get percise feedback when something breaks so you can find exactly where the failure happened

Matchers trong `rspec-expectations` chia làm 3 loại:  

- Primitive matchers
- Higher-order matchers
- Block matchers

### Primitive matchers

#### Equality and Identity

##### Value equality `eq`
```ruby
expect(Math.sqrt(9)).to eq(3)
```
Bản chất là so sánh: `Math.sqrt(9) == 3`  

##### Identity `equal`
Check if `a` and `b` are the same object, not only have the same value, use `equal`:  
```ruby
expect(a).to equal(b)
```
Về bản chất bên trong là so sánh: `a.equal? b`  

`equal` có alias là `be`:  

```ruby
expect(a).to be(b)
```

##### `eql`
```ruby
expect(3).to eq 3.0      # 3 == 3.0   => true
expect(3).not_to eql 3.0 # 3.eql? 3.0 => false
```

Alias:  
- `an_object_eq_to` aliases `eq`
- `an_object_equal_to` aliases `equal`
- `an_object_eql_to` aliases `eql`

#### Truthiness
```ruby
expect(1).to be_truthy
expect(nil).to be_falsey
```
Alias:  

- `a_truthy_value` aliases `be_truthy`
- `a_falsey_value` aliases `be_falsey`

#### Operator comparisons
```ruby
expect(1).to be == 1
expect(1).to be < 2
expect("foo").to be === String
expect(/foo/).to be =~ "food"

expect([1, 2, 3]).to include(a_value > 0)
```

#### Range Comparison

##### Absolute Difference

```ruby
expect(0.1 + 0.2).to be_within(0.00001).of(0.3)
```

##### Relative Difference

```ruby
population = 1237
expect(population).to be_within(25).percent_of(1000)
```
Alias: `a_value_within`  

*fluent interface*

##### Range

```ruby
expect(population).to be_between(750, 1500)
```

- `be_between(x, y).inclusive`
- `be_between(x, y).exclusive`

Alias: `a_value_between`  


#### Kiểm tra true/false
*dynamic predicates*  

`be_`, `be_a_`, `be_an_` sẽ bị loại bỏ và thêm `?` ở cuối. 
Ví dụ 1:  

```ruby
expect(array).to be_empty
```
RSpec sẽ gọi `array.empty?`  

Ví dụ 2:  
object `user` có hàm (predicate method) `admin?`. Khi đó trong RSpec:  

```ruby
expect(user).to be_an_admin
# expect(user).to be_admin
```
tương đương với:  
```ruby
expect(user.admin?).to be true
```
Trong trường hợp predicate method là thứ ta trực tiếp muốn test thì nên so sánh trực tiếp kết quả trả về với true/false. Nếu không thì dùng dynamic predicate.  

#### Satisfy

Dùng khi logic test phức tạp, không có matcher phù hợp  
```ruby
expect(1).to satisfy {|number| number.odd?}
expect([1, 2, 3]).to include(an_object_satisfying(&:even?))
```
`satisfy` như là một adapter, wrap một đoạn code Ruby và adapt vào matcher của RSpec.  


### Higher-order matchers

#### Collections and Strings

##### `include`

```ruby
expect('a string') to include('str')
expect([1, 2, 3]).to include(3, 2)

h = {name: "Harry", age: 17}
expect(h).to include(:name)
expect(h).to include(age: 17)
```
Alias:  

- `a_collection_including`
- `a_string_including`
- `a_hash_including`

##### `start_with`, `end_with`
```ruby
expect([1, 2, 3]).to start_with(1, 2)
```
Alias:  
- `a_string_starting_with` / `a_string_ending_with`
- `a_collection_starting_with` / `a_collection_ending_with`

##### `all`
`all` always takes another matcher as an argument  

```ruby
expect([2, 4, 6]).to all be_even
```
Chú ý: Mảng rỗng cũng có thể pass test trên  
```ruby
expect([]).to all be_even
```
Do đó cần test mảng rỗng hay không:  
```ruby
RSpec::Matchers.define_negated_matcher :be_non_empty, :be_empty

expect([]).to be_non_empty.and all be_even
```

##### `match`
```ruby
children = [
  {name: "Coen", age: 6},
  {name: "Dan",  age: 4},
  {name: "Phil", age: 2}
]

expect(children).to match [
  {name: "Coen", age: a_value > 5},
  {name: "Dan",  age: a_value_between(3, 5)},
  {name: "Phil", age: a_value < 3}  
]
```
`match` yêu cầu các element phải đúng thứ tự  

Alias:  

- `an_object_matching`
- `a_string_matching`

##### `contain_exactly`
`contain_exactly` thoáng hơn `match`, không yêu cầu phải đúng thứ tự  
```ruby
expect(children).to contain_exactly(
  {name: "Phil", age: a_value < 3}    
  {name: "Coen", age: a_value > 5},
  {name: "Dan",  age: a_value_between(3, 5)},
)
```

#### Object attributes

```ruby
require "uri"
uri = URI("https://github.com/rspec/rspec")

expect(uri).to have_attributes(host: "github.com")
```

### Block Matchers
Với các matcher kể trên, ta truyền vào `expect` một object thông thường để kiểm tra thuộc tính của object đó.  
Với block matcher, ta kiểm tra thuộc tính của một đoạn code. 
```ruby
expect{raise "boom"}.to raise_error "boom"
```

#### Raising and throwing

##### `raise_error`

```ruby
expect{"hello".world}.to raise_error NoMethodError
expect{"hello".world}.to raise_error(/undefined method/)
expect{"hello".world}.to raise_error NoMethodError, /undefined method/

expect{"hello".world}.to raise_error(NoMethodError)
  .with_message(/undefined method/)

expect{"hello".world}.to raise_error(NoMethodError)
  .with_message a_string_including("undefined method")

expect{"hello".world}.to raise_error(NoMethodError) do |ex|
  expect(ex.message).to include "undefined method"
end
```
Alias: `rais_exception`  

##### `throw_symbol`
```ruby
expect{throw :found}.to throw_symbol :found
```

#### Yield

##### `yield_control`
```ruby
def just_yield
  yield
end

expect {|block| just_yield(&block)}.to yield_control

expect {|block| 4.times(&block)}.to yield_control.exactly(4).times
```

##### `yield_with_args`
```ruby
def just_yield_these *args
  yield *args
end

expect {|block| just_yield_these "food", 10, &block}.to yield_with_args(
  /foo/, a_value > 9)
```

##### `yield_with_no_args`
```ruby
expect {|block| just_yield_these &block}.to yield_with_no_args
```

##### `yield_successive_args`
Dùng để kiểm tra các hàm yield nhiều lần  

```ruby
expect {|block| ['foot', 'ball'].each_with_index &block}.to yield_successive_args(
    [/foo/, 0],
    [/ba/,  1]
  )
```

#### Mutation

```ruby
array = [1, 2, 3]
expect {array << 4}.to change {array.size}
```
Matcher trên chạy theo thứ tự như sau:  

- Chạy block change (`array.size`) và lưu kết quả làm gía trị ban đầu
- Chạy code trong block test (`array << 4`)
- Chạy block change (`array.size`) lần 2, lưu kết quả làm gía trị lúc sau
- So sánh nếu gía trị lúc đầu và lúc sau, nếu khác nhau -> pass

Để test cụ thể xem gía trị change bao nhiêu:  
```ruby
expect {array.concat [1, 2, 3]}.to change {array.size}.by(3)
expect {array.concat [1, 2, 3]}.to change {array.size}.by_at_least(2)
expect {array.concat [1, 2, 3]}.to change {array.size}.by_at_most(4)
```
```ruby
array = [1, 2, 3]
expect {array << 4}.to change {array.size}.from(3).to(4)
```
Chú ý: gía trị của `array` sẽ không reset sau mỗi lần 'expect'. Cụ thể:  
```ruby
array = [1, 2, 3]
expect {array << 4}.to change {array.size}.from(3).to(4)
expect {array << 5}.to change {array.size}.from(4).to(5)

puts array # [1, 2, 3, 4, 5]
```

#### Output
```ruby
expect {print "OK"}.to output("OK").to_stdout
expect {warn "problem"}.to output(/prob/).to_sterr
```
