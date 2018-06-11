---
title: Be careful when mocking 3rd party API
categories: rspec
tags: rspec
description: 
permalink: 
---

Cần cẩn trọng khi mock 3rd party API  

### Lý do
Vì ta không nắm quyền kiểm soát 3rd party API. Khi 3rd party API thay đổi, có thể dẫn đến trường hợp pass test, fail production => false confidence

### Solutions

#### 1. Dùng hifi fake
Ex: FakeFS, FakeRedis, Fake Braintree, Fog::Mock, StringIO

Dùng gem [VCR](https://github.com/vcr/vcr)

#### 2. Wrap 3rd party dependency

Đọc thêm Chap 15, cuốn Effective Testing
