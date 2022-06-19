# <a name="top"></a> Cap *active_record*.6 - Trovare i records (Dynamic Finders Methods)



## Risorse esterne

- [API Rails - find](https://api.rubyonrails.org/classes/ActiveRecord/FinderMethods.html#method-i-find)
- [API Rails - order](https://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-order)
- [14 Dynamic Finders](http://guides.rubyonrails.org/active_record_querying.html)


***code 01 - .../db/migrate/xxx_create_lessons.rb - line:1***

```html+erb

```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/01_01-db-migrate-xxx_create_lessons.rb)


## Selezione base dei records

Apriamo la *sqlite* console.

```ruby
$ sqlite
> select * frome users limit 10;
> select "users".* FROM "users" WHERE "users"."id" = ? LIMIT ? [["id", 1], ["LIMIT", 1]]
> select "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ? [["LIMIT", 1]]
> select "users".* FROM "users" ORDER BY "users"."id" DESC LIMIT ? [["LIMIT", 1]]
> select "users".* FROM "users" WHERE "users"."name" = ? DESC LIMIT ? [["name", "John"], ["LIMIT", 1]]
```

> `ASC` fa un ordinamento crescente sulla colonna di default che è "id".

Apriamo la rails console.

```ruby
$ rails c
> User.find(1) # OK: record with id = 1
> User.find("x") # ERROR: ActiveRecord::RecordNotFound
> User.find([1, 2]) # OK: record with id = 1 AND record with id = 2
> User.first # OK: the record with the lower "id" (usually id = 1)
> User.first(2) # OK: the two records with the lower "id"
> User.last # OK: the record with the higher "id"
> User.last(3) # OK: the three records with the higher "id"
> USer.find_by(name: "John")
```

Se non ci sono records:

- `User.first` returns `nil`
- `User.first!` returns `exception`

> Atttenzione! 
> I "bang methos", ossia quelli che finiscono con il punto esclamativo "!", sono ***dangerous***
> perché possono o ritornare un `exception` oppure eseguire un'azione di modifica.
> Vanno usati con cautela ed attenzione. (Se si può, è meglio evitarli)


Esempio:

```ruby
$ rails c
> 

```




## Selezione con `where`

Apriamo la rails console.

```ruby
$ rails c
> User.where("name = 'John'") # funziona ma è meglio approccio differente
> params = { search_term: "John" }
> User.where("name = '#{params[:search_term]}'") # funziona ma rischi attacchi di sql-injection

> User.where("name = ? AND email = ?", params[:search_term], "email")
> User.where("name = :name AND email = :email", {name: "John", email: "email"})

> User.where(name: "John")
> User.where.not(name: "John")

> User.where(name: "John").or(User.where(name: "Ann"))

> User.where(name: "John").where(name: "Emma")
```



## Selezione con *filtri*

Apriamo la rails console.

```ruby
$ rails c
> User.where("created_at >= :this_month", { this_month: Date.today.beginning_of_month}).order(created_at: :desc)
```




## Deprecated

[Railcasts 415-upgrading-to-rails-4]()

***code n/a - .../app/models/episode.rb - line:1***

```ruby
  @episodes = Episode.published.find_all_by_pro(false) # DEPRECATED!
  @episodes = Episode.published.where(pro: false) # OK!
```




## Domanda su Stackoverflow

I have a database that has stored information of some users. I know for example: User.find(1) will return the user with id:1
What should I call to find a user by email? I searched a lot but could not find anything. I also tried User.find(:email => "xyz@abc.com") but it doesn't work.

Use

```ruby
User.find_by_email("abc@xyz.com")
```

Oppure si può usare

```ruby
User.where(email: "abc@xyz.com").first
```



## Esempio 1 - Donamat. Fare le somme dei pagamenti corretti divisi per contanti e pos

```ruby
     kiosk.tot_cash_cents = kiosk.transactions.where(payment_check: "PAYMENT_OK", cash_pos: "CASH").sum(:cents)
      kiosk.tot_pos_cents = kiosk.transactions.where(payment_check: "PAYMENT_OK", cash_pos: "POS").sum(:cents)
      #kiosk.tot_donations = kiosk.transactions.where(payment_check: "PAYMENT_OK").count
      kiosk.tot_donations = kiosk.transactions.where(payment_check: "PAYMENT_OK").size
```

Per contare tutti i records è preferibile usare `.size`.
