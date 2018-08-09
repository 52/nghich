---
title: Convert between jQuery object and DOM object
categories: jquery
tags: js dom jquery
description: Chuyển từ jQuery object sang DOM object và ngược lại
permalink: 
---
```html
<h3>title</h3>
<p>first</p>
<p>second</p>
<p>third</p>
```

```javascript
// jQuery to DOM
$('h3')[0].textContent;     // 'title'
$('h3').get(0).textContent; // 'title'
$('p').get(1).textContent;  // 'second'

// DOM to jQuery
const h3 = document.querySelector('h3'); // DOM
h3.textContent; // 'title' | DOM
$(h3).text();   // 'title' | jQuery object

const paras = document.querySelectorAll('p'); // DOM
$(paras).addClass('paragraph');               // jQuery object
```

Phân biệt giữa `.get()` và `.eq()`:  
```javascript
$('p').get(1).textContent; // trả về phần tử thứ 2 là DOM object
$('p').eq(1).text();       // trả về phần tử thứ 2 là jQuery object 
```

