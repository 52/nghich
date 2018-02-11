---
title: Undo things in Rails
categories: rails
tags: 
description: Dẫu có lỗi lầm
permalink: 
---

## Undo generator
Dùng `rails destroy` để undo lại các câu lệnh generate controller hoặc model, mailer,..
```sh
rails generate controller Home index
rails destroy controller Home index

rails generate model User name email
rails destroy model User
```
Có thể dùng shortcut `rails d`, giống như `rails g` là shortcut của `rails generate`.
## Xem trước generator
Dùng flag `-p` hay `--prepend` để xem trước xem generator sẽ khởi tạo những file gì
```sh
rails g model User name:string email:string -p
```
## Undo migration
Migrate:
```sh
rails db:migrate
```
Undo một bước migration:
```sh
rails db:rollback
```
Quay trở về hoàn toàn trạng thái ban đầu:
```sh
rails db:migrate VERSION=0
```
