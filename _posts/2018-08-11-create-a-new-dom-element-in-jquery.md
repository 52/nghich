---
title: Create a new DOM element in jQuery
categories: jquery
tags: dom js jquery
description: 
permalink: 
---
The elegant way:  
```javascript
$('<p>', {
  text:  'My paragraph',
  class: 'paragraph',
  id:    'para-1'
}).appendTo('article');
```
The ugly way:  
```javascript
$('<p class="paragraph" id="para-1">My paragraph</p>')
  .appendTo('article');
```

The vanilla way:
```javascript
const paragraph = document.createElement('p');
paragraph.textContent = 'My paragraph';
paragraph.classList.add('paragraph');
paragraph.id = 'para-1';

const article = document.querySelector('article');
article.appendChild(paragraph);
```
