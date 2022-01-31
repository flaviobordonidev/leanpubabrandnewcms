Compless per users


[[ TODO - DA RIVEDERE AGGIUNGENDO AUTORIZZAZIONE SU PUNDIT
    Aggiungiamo ordinamento discendente in base a quando sono creati ed implementiamo un "livello di sicurezza" ossia se non si è amministratori viene visualizzato il solo utente loggato. Questa implementazione di "sicurezza" non è fatta seguendo la procedura corretta. Andrebbe prima impostata a livello di autorizzazione con pundit. 
    
    {id="02-09-01_03", title=".../app/controllers/users_controller.rb", lang=ruby, line-numbers=on, starting-line-number=1}
    ```
        @pagy, @users = pagy(User.where(id: current_user.id)) unless current_user.admin?
        @pagy, @users = pagy(User.all.order(created_at: "DESC")) if current_user.admin?
    ```

    [Codice 03](#02-09-01_03all)
]]





Compless per eg_posts

```
    @pagy, @posts = pagy(current_user.posts.order(created_at: "DESC")) unless current_user.admin?
    @pagy, @posts = pagy(Post.all.order(created_at: "DESC")) if current_user.admin?
```



[...]

## Scegliamo quanti records per pagina

Di default sono impostati 20 records ogni pagina. Riduciamoli a 2 così avremo attivi i links per la paginazione.


{title=".../app/controllers/authors/posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=1}
```
    @pagy, @posts = pagy(current_user.posts.order(created_at: "DESC"), items: 2) unless current_user.admin?
    @pagy, @posts = pagy(Post.all.order(created_at: "DESC"), items: 2) if current_user.admin?
```






## Inseriamo alcuni articoli da terminale

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails c
-> u = User.where(email: "ann@test.abc").first
-> 7.times do |i|
-> u.posts.create title: "articolo di test #{i}"
-> end


2.4.1 :001 > u = User.where(email: "ann@test.abc")
  User Load (0.3ms)  SELECT  "users".* FROM "users" WHERE "users"."email" = $1 LIMIT $2  [["email", "ann@test.abc"], ["LIMIT", 11]]
 => #<ActiveRecord::Relation [#<User id: 1, name: "Ann", email: "ann@test.abc", created_at: "2019-01-04 11:53:46", updated_at: "2019-01-08 11:43:42", role: "admin">]> 
2.4.1 :002 > u = u.first
  User Load (0.3ms)  SELECT  "users".* FROM "users" WHERE "users"."email" = $1 ORDER BY "users"."id" ASC LIMIT $2  [["email", "ann@test.abc"], ["LIMIT", 1]]
 => #<User id: 1, name: "Ann", email: "ann@test.abc", created_at: "2019-01-04 11:53:46", updated_at: "2019-01-08 11:43:42", role: "admin"> 
2.4.1 :003 > 50.times do
2.4.1 :004 >     u.posts.create title: "articolo di test"
2.4.1 :005?>   end
   (0.1ms)  BEGIN
  Post Exists (0.5ms)  SELECT  1 AS one FROM "posts" WHERE "posts"."id" IS NOT NULL AND "posts"."slug" = $1 LIMIT $2  [["slug", "articolo-di-test"], ["LIMIT", 1]]
  Post Create (9.6ms)  INSERT INTO "posts" ("title", "user_id", "created_at", "updated_at", "slug") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  [["title", "articolo di test"], ["user_id", 1], ["created_at", "2019-01-31 13:41:12.110627"], ["updated_at", "2019-01-31 13:41:12.110627"], ["slug", "articolo-di-test"]]
   (1.1ms)  COMMIT

  ...

   (0.1ms)  BEGIN
  Post Exists (0.2ms)  SELECT  1 AS one FROM "posts" WHERE "posts"."id" IS NOT NULL AND "posts"."slug" = $1 LIMIT $2  [["slug", "articolo-di-test"], ["LIMIT", 1]]
  Post Create (0.3ms)  INSERT INTO "posts" ("title", "user_id", "created_at", "updated_at", "slug") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  [["title", "articolo di test"], ["user_id", 1], ["created_at", "2019-01-31 13:41:12.319967"], ["updated_at", "2019-01-31 13:41:12.319967"], ["slug", "articolo-di-test-8fded178-c7b3-4773-b903-fff189c98eba"]]
   (0.7ms)  COMMIT
 => 50
```

il metodo ".create" è equivalente a ".new" seguito da ".save". E' solo un modo più succinto. Ad esempio le seguenti due linee di codice sono equivalenti:

* Post.create title: "articolo di test"
* Post.new(title: "articolo di test").save


I> Didattica:

```
5.times { puts "i" }

i
i
i
i
i
```

```
5.times do 
  puts "i"
end

i
i
i
i
i
```

```
5.times { |i| puts i }

0
1
2
3
4
```

```
5.times do |i| 
  puts i
end

0
1
2
3
4
```




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

apriamo il browser sull'URL:

* https://mycloud9path.amazonaws.com/authors/posts

E vediamo la paginazione. Questa volta appaiono i links di navigazione tra le pagine


