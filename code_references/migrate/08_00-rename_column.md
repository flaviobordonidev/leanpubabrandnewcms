# <a name="top"></a> Cap migrate.8 - Rinomina colonna (Rename column)



## La sintassi

***code n/a - .../db/migrate/....rb - line:n/a***

```ruby
rename_column :table_name, :old_column_name, :new_column_name
```



## Esempio1: Rename favorite_id column/field in Employments table

***code n/a - "terminal" - line:n/a***

```ruby
$ rails g migration RenameFavoriteIdInEmployments
```

***code 01 - .../db/migrate/xxx_rename_favorite_id_in_employments.rb - line:n/a***

```ruby
rename_column :employments, :favorite_id, :favorite_id_person
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/migrate/08_01-db-migrate-xxx_rename_favorite_id_in_employments.rb)



## Esempio2: rename more columns

***code n/a - "terminal" - line:n/a***

```ruby
$ rails g migration FixColumnNames
```


***code 02 - .../db/migration/xxx_fix_column_names.rb - line:n/a***

```ruby
change_table :table_name do |t|
  t.rename :old_column1, :new_column1
  t.rename :old_column2, :new_column2
  ...
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/migrate/08_01-db-migrate-xxx_rename_favorite_id_in_employments.rb)



## Esempio3: Change foreign key column name

I have a migration class project like this


***code 03 - .../db/migration/xxx_create_projects.rb - line:n/a***

```ruby
class CreateProjects < ActiveRecord::Migration
 def change
  create_table :projects do |t|
   t.string :title
   t.text :description
   t.boolean :public
   t.references :user, index: true, foreign_key: true

   t.timestamps null: false
  end
 end
end
```

It creates a column name `user_id` in projects table but i want to name the column `owner_id` so i can use `project.owner` instead of `project.user`.

You can do it two ways:

***code 04 - .../app/models/project.rb - line:n/a***

```ruby
class Project < ActiveRecord::Base
   belongs_to :owner, class_name: "User", foreign_key: :user_id
end
```

OR

***code n/a - "Terminal" - line:n/a***

```ruby
$ rails g migration ChangeForeignKeyForProjects
```

***code 05 - .../db/migrate/xxx_change_foreign_key_for_projects.rb - line:n/a***

```ruby
class ChangeForeignKeyForProjects < ActiveRecord::Migration
   def change
      rename_column :projects, :user_id, :owner_id
   end
end
```

then:

```
$ rake db:migrate
```

I was happy to find out that rename_column also takes care of renaming indexes.



## Esempio4: Change column "type" in "type_of_content"

***code n/a - "Terminal" - line:n/a***

```ruby
$ rails g migration RenameTypeInPosts
```

implementiamo il migrate creato

***code 06 - .../db/migrate/xxx_rename_type_in_posts.rb - line:n/a***

```ruby
class RenameTypeInPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :type, :type_of_content
  end
end
```

Effettuiamo il migrate 

```
$ sudo service postgresql start
$ rails db:migrate
```
