# <a name="top"></a> Cap migrate.13 - Aggiungiamo una chiave esterna (references)

Aggiungi colonna di riferimento (Add reference column)

`add_column :table_name, :reference_column_id, :integer`
`add_index :table_name, :reference_column_id`



## Esempio: Adding reference column

```bash
$ rails g migration AddUserReferenceToTesters user_id:integer
```

rails g migration AddUserReferenceToPosts user_id:integer

***code n/a - .../db/migration/xxx_add_user_reference_to_testers.rb - line:1***

```ruby
  add_column :testers, :user_id, :integer
  add_index :testers, :user_id
```

Then add a `belongs_to` to the tester model.

***code n/a - .../app/models/tester.rb - line:1***

```ruby
  belongs_to :user
```

> Nota:</br>
> Se creo una **nuova migrazione** `rails g migration testers title:tester user:references`
> tutto funziona bene. </br>
> Ma se aggiungo una colonna di riferimento successivamente
> `rails g migration add_user_to_testers user:references`
> La colonna di riferimento non è riconosciuta. 
>
> Questo perché quando stai modificando una tabella esistente, il reference non funziona. E in realtà, non è veramente necessario perché integer funziona. Il vantaggio di usare reference invece di integer è che il model viene predefinito con `belongs_to` e poiché il model è già stato creato e non sarà modificato dalla migrazione il vantaggio non c'è più. Quindi dovresti usare:
> `rails g migration add_user_id_to_testers user_id:integer`

And then manually add `belongs_to :user` in the Tester model. Please note that you will most likely need an index on that column too.

***code: n/a - .../db/migration/xxx_add_user_id_to_testers.rb - line:1***

```ruby
  add_column :testers, :user_id, :integer
  add_index :testers, :user_id
```

> Rispetto a `references` manca il parametro `null: false` nel db/schema.rb.</br>
> `t.integer "user_id", null: false`



## Then add a belongs_to to the tester model


***code n/a - .../app/models/tester.rb - line:3***

```ruby
  belongs_to :user
```
