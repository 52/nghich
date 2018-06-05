---
title: RSpec one-liner
categories: rspec
tags: rspec
description: 
permalink: 
---

```ruby
RSpec.describe Cookie, '#ingredients' do
  subject {Cookie.new.ingredients}
  it {is_expected.to include(:chocolate)
  it {is_expected.not_to include(:weed)}
end
```
or  
```ruby
RSpec.describe Cookie, "ingredients" do
  subject {Cookie.new.ingredients}
  it {should include(:chocolate)}
  it {should_not include(:weed)}
end
```
Downside:  
- Vì description generated at runtime nên không thể dùng option `rspec -e` để chạy spec filter theo description.  
- Hơi khó hiểu hơn một chút  

Nên dùng khi generated description gần giống với description tự viết. [Tham khảo](https://github.com/sinatra/mustermann/blob/v0.4.0/mustermann/spec/sinatra_spec.rb)
