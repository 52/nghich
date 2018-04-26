---
title: validates vs validate
categories: rails
tags: ActiveRecord validation
description: Sự khác biệt giữa validates và validate
permalink: 
---
### `validates`
`validates` dùng để chạy validators có sẵn của ActiveRecord hoặc custom validator có class name kết thúc bởi `Validator`  
Ví dụ:
```ruby
validates :terms, acceptance: true
validates :password, confirmation: true
```

[Đọc thêm ở document](https://devdocs.io/rails~5.1/activemodel/validations/classmethods#method-i-validates)

### `validate`
`validate` dùng để chạy custom validator dưới dạng method hoặc block  
Ví dụ:
```ruby
validate :must_be_friends

def must_be_friends
  errors.add(:base, 'Must be friends to leave a comment') unless commenter.friend_of?(commentee)
end
```

[Đọc thêm ở document](https://devdocs.io/rails~5.1/activemodel/validations/classmethods#method-i-validate)
