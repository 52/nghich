---
title: Run RSpec in irb
categories: rspec
tags: rspec irb
description: Setup để chạy rspec trong irb
permalink: 
---
```ruby
require "rspec/core"
require "rspec/expectations"

singleton_class.prepend RSpec::Matchers
```
```ruby
require "rspec/mocks/standalone"

RSpec::Mocks.verify

RSpec::Mocks.teardown
RSpec::Mocks.setup
```
