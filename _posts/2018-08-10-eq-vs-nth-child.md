---
title: Phân biệt :eq() và :nth-child() trong jQuery Selectors
categories: jquery
tags: jquery dom selector
description: 
permalink: 
---
-
  - `:eq` là psuedo selector của jQuery
  - `:nth-child` là CSS selector
-   
  - `:eq` có 0 index-based
  - `:nth-child` có 1 index-based
-  
  - `:eq` lấy thứ tự trong context của selector
  - `:nth-child` lấy thứ tự trong context của toàn bộ document

```html
<article>
  <h3>title</h3>

  <p>first</p>
  <p>second</p>
  <p>third</p>
</article>
```

```javascript
$('p:eq(1)').text(); // 'second'

$('p:nth-child(2)').text // 'first'
// the first paragraph is the SECOND child of `article`
```
