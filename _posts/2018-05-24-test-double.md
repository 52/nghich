---
title: Test double
categories: rspec
tags: rspec
description: 
permalink: 
---

### Test double
Object that stands for another one during a test (think of stunt double). [Read more](https://martinfowler.com/bliki/TestDouble.html)  

In RSpec, to create test doubles, use `instance_double`, and pass it the name of the class (not necessary exist yet)  
```ruby
let(:ledger){instance_double "Ledger"}
```
Chú ý:  
Khi argument là tên class dưới dạng symbol: `instance_double Ledger` thì cần phải define class `Ledger`.  
Khi argument là tên class dưới dạng String: `instance_double "Ledger"` thì không cần phải define class `Ledger` trước.  
