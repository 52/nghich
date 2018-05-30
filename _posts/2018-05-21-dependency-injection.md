---
title: Dependency injection
categories: 
tags: 
description: 
permalink: 
---
#### Dependency injection
The technique of passing in collaborating objects instead of hard-coding them.  

```ruby
# Hard-code
class ExpenseTracker
  def initialize
    @ledger = Ledger.new
  end
end

# Dependency injection
class ExpenseTracker
  def initialize ledger: Ledger.new
    @ledger = ledger
  end
end
```
