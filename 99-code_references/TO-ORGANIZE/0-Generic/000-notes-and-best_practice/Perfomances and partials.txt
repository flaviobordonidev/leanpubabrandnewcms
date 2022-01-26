# Prestazioni e gestione dei partials

* https://scoutapm.com/blog/performance-impact-of-using-ruby-on-rails-view-partials




## Prestazioni viste su 100 posts

Esempio fatto su una view di 1000 posts

* Nested Partials   -> response time: 3000 ms
* Partials in loop  -> response time: 2500 ms
* Collection API    -> response time:  100 ms
* Partials inline  -> response time:   75 ms

Take away:
- Partials inline is the most performant option. (but the less DRY)
- Partials inline are ~25% faster than the Collection API.
- Avoid nested partials
- Se facciamo un render di un loop .each è preferibile usare il collection API




## Partials inline

In pratica non usiamo i partials; scriviamo il codice tutto nella view principale.

{caption: ".../views/posts/index.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<% @posts.each do |post| %> 
 <h3><%= post.title %></h3> 
 <p><%= post.content %></p> 
<% end %> 
```

Questo è il più performante ma quando il codice diventa complesso è anche quello che è più difficile da gestire e manutenere.
Tende a diventare una confusione di codice.




## Partials in loop

{caption: ".../views/posts/index.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<% @posts.each do |post| %> 
 <%= render 'post', post: post %> 
<% end %> 
```

{caption: ".../views/posts/_post.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
 <h3><%= post.title %></h3> 
 <p><%= post.content %></p>
```




## Collection API

{caption: ".../views/posts/index.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<%= render partial: 'post', collection: @posts, as: :post %>
```

{caption: ".../views/posts/_post.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
 <h3><%= post.title %></h3> 
 <p><%= post.content %></p>
```



 
## Nested partials

Anche partendo da Collection API se mettiamo un altro partial annidato le performance diventano orribili.

{caption: ".../views/posts/index.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<%= render partial: 'post', collection: @posts, as: :post %>
```

{caption: ".../views/posts/_post.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<h3><%= post.title %></h3> 
<%= render 'post_detail', post: post %> 
```

{caption: ".../views/posts/_post_detail.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<p><%= post.content %></p> 
```

