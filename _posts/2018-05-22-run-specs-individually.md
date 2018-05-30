---
title: Run specs individually
categories: rspec
tags: rspec command-line
description: Chạy từng specs riêng rẽ trong terminal
permalink: 
---
Tip để chạy từng spec một riêng rẽ trong terminal  

```bash
(for f in `find spec -iname '*_spec.rb'`; do
  echo "$f:"
  bundle exec rspec $f -fp || exit 1
done)  
```

Việc chạy riêng rẽ từng spec giúp phát hiện những spec cho kết quả pass hay fail phụ thuộc vào spec chạy trước đó.  
Ví dụ như spec trước đó có `require` một library mà spec hiện tại cũng cần,  
nếu spec đó load trước => pass, nếu spec đó load sau => fail  
