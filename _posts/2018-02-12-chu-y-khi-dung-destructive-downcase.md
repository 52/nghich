---
title: Chú ý khi dùng downcase!
categories: ruby
tags: string downcase! method-chaining
description: Không nên method chaining khi dùng downcase!
permalink: 
---

**`downcase!`** sẽ trả về `nil` nếu như xâu ký tự không có thay đổi.  
Ví dụ:
```ruby
"FiShiNg".downcase! # return: fishing
"fishing".downcase! # return: nil
```
Vì vậy, cần cẩn thận **không** dùng ghép `downcase!` với các câu lệnh khác, đề phòng trường hợp kết quả không như mong muốn, như trường hợp sau:
```ruby
class Person
  attr_reader :hobbies
  def initialize
    @hobbies = []
  end
  def has_hobby hobby
    @hobbies << hobby.downcase! unless @hobbies.includes? hobby
  end
end

person = Person.new
person.has_hobby "Fishing"
p person.hobbies
# Expect: ["fishing"]
# Got: [nil]
```
Tương tự, cần cẩn trọng khi dùng các hàm xử lý xâu ký tự khác như `upcase!`, `swapcase!`, `capitalize!`
