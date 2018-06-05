---
title: RSpec custom matcher
categories: rspec
tags: rspec matcher
description: Tạo matcher mới theo ý muốn
permalink: 
---

## Dựa trên matchers có sẵn

#### Delegate
```ruby
module ExpenseMatcher
  def an_expense_with_id :id
    a_hash_including(id: id).include :payee, :amount, :date
  end
end

RSpec.configure do |config|  
  config.include ExpenseMatcher
end

expect(ledger.expense_on date).to contain_exactly(
  an_expense_with_id(expense_1.expense_id),
  an_expense_with_id(expense_2.expense_id)
)
```

#### Alias
```ruby
RSpec::Matchers.alias_matcher :new_alias, :old_name
```

#### Negated matcher
```ruby
RSpec::Matchers.define_negated_matcher :not_an_admin, :an_admin
```

## Tạo matcher mới

#### Dùng matcher DSL
```ruby
expect(account).to have_a_balance_of(30)

RSpec::Matchers.define :have_a_balance_of do |amount|
  match {|account| values_match? amount, account.current_balance}

  failure_message {|account| super() + failure_reason(account)}

  failure_message_when_negated { |account|
    super() + failure_reason(account)
  }

  private

  def failure_reason account
    ", but had a balance of #{account.current_balance}"
  end
end

```

References:  

- [relishapp.com](https://relishapp.com/rspec/rspec-expectations/v/3-7/docs/custom-matchers)
- [Module: RSpec::Matchers::DSL::Macros](http://rspec.info/documentation/3.7/rspec-expectations/RSpec/Matchers/DSL/Macros.html#description-instance_method)
- Đọc thêm: *Effective Testing with RSpec 3 > Part 4: RSpec Expectations > Chap 12: Creating Custom Matchers > Using the Matcher DSL*  

#### Tạo mới Ruby class

Any Ruby class can define a matcher if it implements the [*matcher protocol*](http://rspec.info/documentation/3.7/rspec-expectations/RSpec/Matchers/MatcherProtocol.html):  
define 2 required methods:  

- `matches?`
- `failure_message`

[Example from *Effective testing with RSpec 3*](http://media.pragprog.com/titles/rspec3/code/12-creating-custom-matchers/10/custom_matcher/spec/support/matchers.rb)
