# <a name="top"></a> Cap *active_record*.6 - Trovare i records usando campi data e ora


***code 01 - .../db/migrate/xxx_create_lessons.rb - line:1***

```html+erb

```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/01_01-db-migrate-xxx_create_lessons.rb)



## Risorse esterne

- [API Rails - find](https://api.rubyonrails.org/classes/ActiveRecord/FinderMethods.html#method-i-find)



## Selezione tutti i records dell'anno corrente

Apriamo la rails console.

```ruby
$ rails c
> User.where("created_at >= ?", {Date.today.beginning_of_month}).order(created_at: :desc)

> User.where("created_at >= :this_month", {this_month: Date.today.beginning_of_month}).order(created_at: :desc)
```


##   

Please clone and set up the [db_queries repository](https://github.com/mixandgo/prorb_db_queries), if you haven't done so already, and write a custom scope that retrieves all the users younger than 30 years old, and was created in 2022. Then paste your scope code in here.

Incorrect

```ruby
  scope :younger_than_thirty_created_at_2022, -> { where("age < 30 AND created_at >= '2022-01-01' AND created_at <= '2022-12-31'") } 
  scope :younger_than_created_at, ->(age, year) { where("age < ? AND created_at >= '?-01-01' AND created_at <= '?-12-31'", age, year, year) } # rails c -> User.younger_than_created_at(30, 2022)
```

In the same project, write another scope that retrieves all the users that have an age between 20 and 45, and are happy. Then paste your scope code in here.

```ruby
  # rails c -> User.age_between_20_45.happy
  scope :age_between_20_45, -> { where(age: 20..45 ) }
  scope :happy, -> { where(happy: true) }

  scope :happy_age_20_45, -> {where("happy = true AND age BETWEEN 20 AND 45")}
  scope :happy_age, ->(start, final) {where("happy = true AND age BETWEEN ? AND ?", start, final)} # rails c -> User.happy_age(20, 45)
```

> Hey Flavio, this looks good, but there's a gotcha there. Your query doesn't return records with a created_at date between 2022-12-31 00:00:01 and 2022-12-31 23:59:59. Because if you don't specify the time, it assumes 00:00:00.



## Usiamo methods Begin_of_year e End_of_year

DA SISTEMARE

```ruby
  scope :this_year, ->(now) { where("created_at >= BEGINNING_OF_YEAR(now) AND created_at <= END_OF_YEAR(now)", now) } # rails c -> User.(Time.now)
```

L'idea è riempire in automatico i selettori per una ricerca dei dati facendo in modo che si riferiscano all'anno corrente. Si può anche raffinare mettendo al mese corrente.
