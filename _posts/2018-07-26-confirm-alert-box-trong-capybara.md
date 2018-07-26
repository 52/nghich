---
title: Confirm alert box trong Capybara
categories: rspec
tags: rspec capybara
description: 
permalink: 
---
```ruby
before do
  driven_by :selenium_chrome_headless
end

it "___" do
  page.driver.browser.switch_to.alert.accept
end
```
