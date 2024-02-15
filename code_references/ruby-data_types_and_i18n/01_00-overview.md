# The ActiveRecord data types available in Rails 5.


## Risorse esterne

- https://stackoverflow.com/questions/17918117/rails-4-list-of-available-datatypes
- https://michaelsoolee.com/rails-activerecord-data-types/



## Risorse interne

- capitolo 01-base/05-mockups_i18n/01-mockups_i18n
- capitolo 01-base/10-users_i18n/02-users_validations_i18n
- capitolo 01-base/10-users_i18n/03-users_form_i18n
- capitolo 01-base/10-users_i18n/04-browser_tab_title_users_i18n
- capitolo 01-base/12-format_i18n/01-format_date_time_i18n



## I vari "tipi di dato" (data type) di Rails in ordine alfabetico

Come sono mappati con i data types dei vari databases:

              | postgresql  | sqlite        | sqlserver     |sybase
---------------------------------------------------------------------------
:binary       | bytea       | blob          | image         | image
:boolean      | boolean     | boolean       | bit           | bit
:date         | date        | date          | date          | datetime
:datetime     | timestamp   | datetime      | datetime      | datetime
:decimal      | decimal     | decimal       | decimal       | decimal
:float        | float       | float         | float(8)      | float(8)
:integer      | integer     | integer       | int           | int
:bigint       |
:primary_key  |
:references   |
:string       | (note 1)    | varchar(255)  | varchar(255)  | varchar(255)
:text         | text        | text          | text          | text
:time         | time        | datetime      | time          | time
:timestamp    | timestamp   | datetime      | datetime      | timestamp




## per tipologie

:primary_key
:string
:text
:integer
:bigint
:float
:decimal
:numeric
:datetime
:time
:date
:binary
:boolean
:references
:timestamp

These data types are used in instances such as migrations.

def change
  create_table :categories do |t|
    t.string :title
    t.boolean :is_subcategory
    t.string :permalink
    t.timestamps
  end
end




## E' meglio usare date o datetime?

se non si hanno milioni di records nelle nostre tabelle in cui può avere senso ottimizzare, è preferibile usare sempre "datetime" anche se si vuole archiviare semplicemente una data.

