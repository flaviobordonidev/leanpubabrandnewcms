# <a name="top"></a> Cap *active_record*.10 - include vs join


## Risorse esterne

- [mixandgo - Queries - Joins](https://school.mixandgo.com/targets/233)
- [Railscasts 181-include-vs-joins](http://asciicasts.com/episodes/181-include-vs-joins)



## Queries joins su tabelle *users* e *foods*

Vediamo comer filtrare i dati tra più tabelle.
Su una nuova app prepariamo la tabella *user* con una relazione 1-a-molti con *foods*.

```bash
$ rails generate model User name email
$ rails generate model Food name user:references
$ rails db:migrate
```

Vogliamo filtrare gli utenti con una specifica preferenza di cibo. Questo vuol dire selezionare un tipo di records basandoci su un tipo associato.

```ruby
rails c
> User.where(foods: {name: "Lettuce"})
```

> NON funziona

Ci manca l'associazione sia nel model che nella query. Risolviamo:

***code 01 - .../app/models/user.rb - line:2***

```ruby
  has_many :foods
```

```ruby
rails c
> User.where(foods: {name: "Lettuce"}).joins(:foods)
```



## Aggiungiamo la tabella *colors*


```bash
$ rails generate model Color name user:references
$ rails db:migrate
```

Popoliamo la tabella dei colori con 3 colori a caso per ogni utente.

```ruby
rails c
> User.all.each do |u|
>> 3.times { Color.create(name: Faker::Color.color_name, user: u)}
> end
```

Proviamo a filtrare 
```ruby
rails c
> User.where(foods: {name: "Lettuce"})
```

> NON funziona

Ci manca l'associazione alla tabella colors nella query. Risolviamo:

```ruby
rails c
> User.where(foods: {name: "Lettuce"}, colors: {name: "red"}).joins(:foods, :colors)
```



## Aggiungiamo la tabella annidata *nutrients*


```bash
$ rails generate model Nutrient name food:references
$ rails db:migrate
```

Aggiungiamo l'associazione uno-a-molti nel *food* model

***code 02 - .../app/models/food.rb - line:2***

```ruby
  belongs_to :users
  has_many :nutrients
```

Filtriamo

```ruby
rails c
> User.where(foods: {name: "Lettuce"}, nutrients:{ name: "X"}).joins(foods: :nutrients)
```


> La differenza fra una query tra tabelle multiple *non* nested e quelle nested è che: <br/>
> - le *non* nested hanno un **array** come argument del `join` method. <br/>
> - le nested hanno un **hash** come argument del `join` method.


















## Abnormalis models/company.rb

in postgresql ILIKE is case insensitive. LIKE is case sensitive.

***code n/a - .../app/models/company.rb - line:2***

```ruby
  scope :search, lambda {|query| where(["name ILIKE ?","%#{query}%"])}
  scope :complex_search, lambda {|query| includes(:employments).where(["name ILIKE ? OR summary ILIKE ?","%#{query}%","%#{query}%"])}
  #scope :complex_search, lambda {|query| joins(:employments).where(["name ILIKE ? OR employments.summary ILIKE ?","%#{query}%","%#{query}%"])}
```

per joins ho dovuto specificare la tabella su summary per evitare disanbiguità ma comunque continua a funzionare male. Dà dei record duplicati.
