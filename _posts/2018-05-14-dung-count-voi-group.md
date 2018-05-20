---
title: Dùng count với group
categories: rails
tags: ActiveRecord queries group count order
description: 
permalink: 
---
Xét ví dụ:  

- Author has_many books
- Book belongs_to author

Ta muốn liệt kê danh sách author kèm số books của mỗi author.  
Cách hiệu quả nhất để làm việc này là dùng `counter_cache`.  
Ta cũng có thể dùng query [group](https://devdocs.io/rails~5.2/activerecord/querymethods#method-i-group) và [count](https://devdocs.io/rails~5.2/activerecord/calculations#method-i-count) như sau:  
```ruby
Author.joins(:books).group("authors.name").count
```
Query sinh ra là:
```sql
SELECT COUNT(*) AS count_all, authors.name AS authors_name
FROM "authors" INNER JOIN "books" 
ON "books"."author_id" = "authors"."id" 
GROUP BY authors.name
```
Kết quả trả về là một Hash với key là gía trị của column dùng để group, và value là kết quả của hàm count:
```ruby
{
  "Author A" => 2,
  "Author B" => 1
}
```
Nếu như group bằng nhiều column, thì Hash sẽ có key là Array, ví dụ:
```ruby
Author.joins(:books).group("authors.id", "authors.name").count

{
  [1, "Author A"] => 2,
  [2, "Author B"] => 1
}
```

#### Order
Để sắp xếp Hash trả về theo thứ tự số lượng books của từng author, ta để ý column count có tên là `count_all`.  
Cụ thể, khi count theo một column nào đó, thì column count trong kết quả trả về sẽ được đặt tên với định dạng `"count_#{column_name}"`.  
Ví dụ: `Author.joins(:books).group(:name).count(:id)` thì column count sẽ có tên là `count_id`.  
Do đó, để sắp xếp theo số lượng, ta order theo column count trả về:
```ruby
Author.joins(:books).group(:name).order("count_all ASC").count

{
  "Author B" => 1,
  "Author A" => 2
}
```
Query sinh ra là:
```sql
SELECT COUNT(*) AS count_all, "authors"."name" AS authors_name
FROM "authors" INNER JOIN "books"
ON "books"."author_id" = "authors"."id"
GROUP BY "authors"."name"
ORDER BY count_all
```

#### Cách khác
```ruby
@authors = Author.joins(:books).group(:id).select("authors.*, COUNT(*) AS books_count").order("books_count")

@authors.each do |author|
  puts "#{author.name}: #{author.books_count}"
end
```
