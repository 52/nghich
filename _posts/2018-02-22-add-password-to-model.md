---
title: Thêm password cho model User
categories: rails
tags: ActiveRecord
description: 
permalink: 
---
## Thêm `password_digest` vào table Users
```bash
rails generate migration add_password_digest_to_users password_digest
```
```ruby
# db/migrate/[timestamp]_add_password_digest_to_users.rb
class AddPasswordDigestToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :password_digest, :string
  end
end
```
```bash
rails db:migrate
```
## Thêm `bcrypt` vào `Gemfile`
```ruby
# Gemfile
gem bcrypt
```
```bash
bundle install
```
## Thêm `has_secure_password` vào model
```ruby
# app/models/user.rb
class User < ApplicationRecord
.
.
  has_secure_password
end
```
## What do we got?
- Model User có 2 attributes ảo
  - `password` 
  - `password_confirmation`
- `user.authenticate "input_password"`
  - Trả về `user` nếu password đúng
  - Trả về `false` nếu password sai 
