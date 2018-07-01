---
title: Factory bot
categories: rails rspec
tags: factory-bot
description: 
permalink: 
---
## Setup
```ruby
gem "factory_bot_rails"
```
Factory files sẽ được tự động tìm load ở trong file `spec/factories.rb` hoặc trong thư mục `spec/factories/*.rb`  

Đặt config sau trong RSpec để không phải dùng prefix `FactoryBot` trước mỗi methods `create`, `build`, `build_stubbed`,..  
```ruby
# File spec/support/factory_bot.rb
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
```

## Define factories

```ruby
# File spec/factories/projects.rb
FactoryBot.define do
  factory :project do
    name     "Project"
    due_date 1.week.from_now
  end
end
```
Khi tên của factory không trùng với tên của class:  
```ruby
FactoryBot.define do
  factory :big_project, class: Project do
    name "Big project"
  end
end
```
Khi muốn một field nào đó của factory có dữ liệu động, ta pass cho field đó một block:  
```ruby
FactoryBot.define do
  factory :project do
    name "Project"
    dude_date {Date.today - rand(50)}
  end
end
```
Có thể dùng value của field đã defined trước để dùng cho field sau:  
```ruby
FactoryBot.define do
  factory :project do
    name "Project Runnaway"
    slug {name.downcase.gsub(" ", "-")}
end
```

## Create factories
Có 4 methods chính:  
### `build`
`build :project` tạo instance nhưng không save vào db
### `create`
`create :project` tạo instance và save vào db
### `build_stubbed`
`build_stubbed :project`  

- instance được cấp một fake ActiveRecord ID
- KHÔNG save vào db
- stubs out database-interaction methods (like `save`) such that the test raises an exception if they are called
```ruby
project.save
# RuntimeError: stubbed models are not allowed to access the database - Project#save()
```

### `attributes_for`
`attributes_for :project` trả về một hash chứa tất cả các attributes của factory, phù hợp để truyền vào `ActiveRecord#new`, `ActiveRecord#create`.  
Thường được dùng để tạo params sử dụng trong controller test  

```ruby
let(:project){FactoryBot.build_stubbed :project}
```

Tip: Luôn luôn nên dùng `build_stubbed` trừ trường hợp cần object đó có mặt trong db  

## Uniqueness
```ruby
FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "user_#{n}@local.com"}
  end
end

# OR:
FactoryBot.define do
  sequence :email do |n|
    "user_#{n}@local.com"
  end

  factory :user do
    name "Normal User"
    email
    # OR:
    # user_email {generate :email}
  end
end
```

## Association
```ruby
FactoryBot.define do
  factory :task do
    title "Do something"
    size 3
    project
    association :doer, factory: :user, name: "Task Doer"
  end
end
```
Tuy nhiên chỉ nên tạo association bằng tay khi cần dùng đến chứ không nên đặt tự động trong factory. *(Đọc thêm Rails test prescriptions page 128/396)*  
```ruby
let(:project){build_stubbed :project}
let(:task){build_stubbed :task, project: project}
```

## Thừa kế trong factories

```ruby
FactoryBot.define do
  factory :task do
    sequence(:title){|n| "Task #{n}"}
  end

  factory :big_task, parent: :task do
    size 5
  end

  factory :small_task, parent: :task do
    size 1
  end
end
```

Hoặc:  
```ruby
FactoryBot.define do
  factory :task do
    sequence(:title){|n| "Task #{n}"}

    factory :big_task do
      size 5
    end

    factory :small_task do
      size 1
    end
  end
end
```

Hoặc dùng traits.

## Trait
`traits` nhóm các thuộc tính tương đồng thành các nhóm. Ví dụ:  

```ruby
FactoryBot.define do
  factory :task do
    sequence(:title){|n| "Task #{n}"}
    size 3
    completed_at nil

    trait :small do
      size 1
    end

    trait :large do
      size 5
    end

    trait :newly_complete do
      completed_at 1.day.ago
    end

    trait :long_compete do
      completed_at 6.months.ago
    end
  end
end
```
Tạo object dùng trait như sau:  
```ruby
let(:small_newly_done){build_stubbed :task, :small, :newly_complete}
```

## Validate factories
Install gem `database_cleaner`, đặt trong group `:test`  
```ruby
# Gemfile
group :test do
  gem "database_cleaner"
end
```

Chạy `FactoryBot.lint` trong môi trường `test`, và xóa db sau khi lint:  
```ruby
# File /bin/factory_bot.rb
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
begin
  DatabaseCleaner.start
  FactoryBot.lint(traits: true)
ensure
  DatabaseCleaner.clean
end
```
Chạy lệnh sau trong terminal để validate factories:  
```bash
ruby /bin/factory-bot.rb
```

## Về dữ liệu thời gian trong test
Đối với dữ liệu thời gian trong test, nếu sử dụng các mốc thời gian cố định có thể xảy ra trường hợp hiện tại thì test pass, nhưng sau một thời gian sau chạy lại thì test fail.  
Để xử lý trường hợp trên có 2 cách:  

### Sử dụng thời gian tương đối
```ruby
let(:task){build_stubbed :task, completed_at: 3.days.ago}
```

### Du hành thời gian
Bản chất của việc du hành thời gian là stub 2 methods `Date.today`, và `Time.now`.  
Có 3 methods dùng để du hành thời gian:  
```ruby
travel_to Date.parse("2018-07-01")
```
Dùng `travel_to` để nhảy đến một ngày cụ thể nào đó.  
Để quay trở lại thời gian hiện tại, dùng `travel_back`.  
Vì khi dùng `travel_to`, thời gian bị đứng yên. Nên nếu muốn dịch chuyển thời gian, dùng hàm `travel`:  
```ruby
travel 2.weeks
```
Cả `travel_to` và `travel`, nếu có một block truyền vào, thì mốc thời gian mới chỉ có hiệu lực trong phạm vi của block đó:  
```ruby
travel_to(Date.parse("2018-07-01")) do
  expect(project).not_to be_over_due
end
```
### So sánh thời gian
Ruby có 3 class để chỉ thời gian: `Time`, `Date`, `DateTime`. Để so sánh 2 mốc thời gian thì cần phải convert one to another.  
ActiveSupport có 3 hàm hỗ trợ để convert: `to_date`, `to_time`, `to_datetime`  
```ruby
5.days.ago.to_date.to_s(:db)
```
### Rails timestamps
Timestamp `created_at` có thể được set cố định trong factory, fixture. Tuy nhiên, Rails tự động update timestamp `updated_at` mỗi lần `save`. Ta có thể work around như sau:  
```ruby
Project.record_timestamps = false # Turn off timestamps
project.save # Save or update the record
Project.record_timestamps = true # Turn on timestamps
```
