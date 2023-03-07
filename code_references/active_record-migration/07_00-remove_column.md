# <a name="top"></a> Cap active_record-migration.07 - Rimuovi colonna (Remove column)

Il comando per rimuovere una colonna è:

```ruby
remove_column :table_name, :column_name, :column_type
```



## Esempio1: Remove image column from companies table

```bash
$ rails g migration RemoveImageFieldFromCompanies image:string
```


***Codice 01 - .../db/migration/xxx_remove_image_field_from_companies.rb - linea:01***

```ruby
  def change
    remove_column :companies, :image, :string
  end
```



## Esempio2: Remove lab column from testers table --> Old style (up / down)

Prima di `def change` si usavano due metodi distinti `def up` (per il db:migrate) e `def down` (per il db:rollback).

```bash
$ rails g migration RemoveLabFromTesters
```

***Codice 02 - .../db/migration/xxx_remove_lab_from_testers.rb - linea:01***

```ruby
  def up
    remove_column :testers, :lab
  end

  def down
    add_column :testers, :lab, :string
  end
```
