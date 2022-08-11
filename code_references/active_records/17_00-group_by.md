# Il metodo di raggruppamento

Risorse interne:

* 50-elisinfo/06-company_person_maps/02-companies_index-people

Risorse esterne:

* https://www.rubyfleebie.com/2008/10/13/how-to-display-a-collection-grouped-by-an-attribute-value-in-rails/
* https://stackoverflow.com/questions/8046138/how-to-group-collection-by-columns-with-rails/8056312
* https://stackoverflow.com/questions/46435551/in-ruby-whats-the-advantage-of-each-pair-over-each-when-iterating-through-a



## Esempio 1

* https://stackoverflow.com/questions/8046138/how-to-group-collection-by-columns-with-rails/8056312

``` 
    <% Stock.all.group_by(&:storage).each do |storage, products| %>
      Storage: <%= storage %>
      <% products.each do |product| %>
        (<%= product.color_id %>): <%= product.in_stock %>
      <% end %>
    <% end %>
```



## Esempio 

* https://www.rubyfleebie.com/2008/10/13/how-to-display-a-collection-grouped-by-an-attribute-value-in-rails/

```
all_quotes = Quote.find(:all)
@authors = all_quotes.group_by(&:author)
```

Why the “&” sign? It’s because group_by expects a block. I could have done it this way : @authors = all_quotes.group_by{|quote| quote.author}


```
@authors.each_pair do |author_name, quotes|
  <h1><%=author_name%></h1>
  <%quotes.each do |quote| %>
    - <%=quote.body%><br />
  <%end%>
<%end%>
```

```
@authors.keys.sort.each do |author_name|
  <h1><%=author_name%></h1>
  <%@authors[author_name].each do |quote|%>
    - <%=quote.body%><br />
  <%end%>
<%end%>
```



"each" and "each_pair" are aliases for each other: they share the same source code. 
"each_pair" may be a clearer name, since it strongly suggests that two-element arrays containing key-value pairs are passed to the block.
