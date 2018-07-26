---
title: Create factory with attached file
categories: rspec
tags: factory-bot
description: 
permalink: 
---
```ruby
FactoryBot.define do
  factory :post do
    link_to_default_image = "#{Rails.root}/spec/files/images/default.jpg"
    caption "default image"
    image Rack::Test::UploadedFile.new link_to_default_image, "image/jpg"
  end
end
```
