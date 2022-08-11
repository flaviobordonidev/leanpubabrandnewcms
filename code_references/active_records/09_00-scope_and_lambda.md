# <a name="top"></a> Cap *active_record*.9 - Scope and Lambda


## Risorse esterne

- Railcasts 202-active-record-queries-in-rails-3
- Railcasts 215-advanced-queries-in-rails-3
- [Queries - Scopes](https://school.mixandgo.com/targets/232)



## Scope query active user

***code 01 - .../app/models/user.rb - line:2***

```ruby
  scope :active, -> { where(active: true) }
  scope :older_than, ->(age) { where("age > ?", age) }
```

```ruby
$ rails c
> User.active
> User.older_than(25)
> User.older_than(25).active
> User.active.older_than(25)
```


## DEFAULT scope

Possiamo indicare un `default_scope` che viene eseguito sempre, anche se non è esplicitamente chiamato.

***code n/a - .../app/models/user.rb - line:2***

```ruby
  default_scope :active, -> { where(active: true) }
  scope :older_than, ->(age) { where("age > ?", age) }
```

Le seguenti 3 chiamate danno lo stesso risultato

```ruby
$ rails c
> User.older_than(25)
> User.older_than(25).active
> User.active.older_than(25)
```

## Lavorare con le date

> ATTENZIONE!
> il campo data lo dobbiamo passare nel formato *anno-mese-giorno* e come *stringa* quindi tra virgolette.
> Esempio: `'2022-12-31'`

***code 02 - .../app/models/user.rb - line:2***

```ruby
  scope :active, -> { where(active: true) }

  scope :older_than, ->(age) { where("age > ?", age) }

  scope :younger_than_thirty, -> { where("age < 30") } # rails c -> User.younger_than_thirty.first(10)
  scope :younger_than, ->(age) { where("age < ?", age) } # rails c -> User.younger_than(30).first(10)

  scope :age_between_25_30, -> { where(age: 25..30 ) }
  scope :age_between, ->(start, final) { where("age >= ? AND age <= ?", start, final)} # rails c -> User.age_between(25, 30).count
  scope :age_between_v2, ->(start, final) { where("age BETWEEN ? AND ?", start, final)} # rails c -> User.age_between(25, 30).count

  scope :created_at_test1, -> { where("created_at <= ?", Time.current) }
  scope :created_at_test2, -> { where("created_at <= '2022-06-16 05:53:45.789268'") }
  scope :created_at_test3, -> { where("created_at <= '2022-06-16'") }

  scope :created_at_2022, -> { where(created_at: Date.new(2022, 1, 1)...Date.new(2023, 1, 1)) }
  scope :created_at_2022_v2, -> { where("created_at >= '#{Date.new(2022, 1, 1)}' AND created_at < '#{Date.new(2023, 1, 1)}'") }
  scope :created_at_2022_v3, -> { where(created_at: Date.new(2022, 1, 1)..Date.new(2022, 12, 31))}
  scope :created_at_2022_v4, -> { where("created_at >= '#{Date.new(2022, 1, 1)}' AND created_at <= '#{Date.new(2022, 12, 31)}'") }
  scope :created_at_2022_v5, -> { where("created_at >= '2022-01-01' AND created_at <= '2022-12-31'") }
  scope :created_at_2022_v6, ->(year) { where("created_at >= '?-01-01' AND created_at <= '?-12-31'", year, year) } # rails c -> User.created_at_2022_v6(2022)

  scope :younger_than_thirty_created_at_2022, -> { where("age < 30 AND created_at >= '2022-01-01' AND created_at <= '2022-12-31'") } 
  scope :younger_than_created_at, ->(age, year) { where("age < ? AND created_at >= '?-01-01' AND created_at <= '?-12-31'", age, year, year) } # rails c -> User.younger_than_created_at(30, 2022)
```


```ruby
  scope :younger_than_thirty_created_at_2022, -> { where("age < 30 AND created_at >= '2022-01-01' AND created_at <= '2022-12-31'") } 
  scope :younger_than_created_at, ->(age, year) { where("age < ? AND created_at >= '?-01-01' AND created_at <= '?-12-31'", age, year, year) } # rails c -> User.younger_than_created_at(30, 2022)
```

Hey Flavio, this looks good, but there's a gotcha there. Your query doesn't return records with a `created_at` date between `2022-12-31 00:00:01` and `2022-12-31 23:59:59`. Because if you don't specify the time, it assumes `00:00:00`.

You can see that in the screenshot I've attached.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/active_records/09_fig01-error_in_select.png)

CAZZO DOBBIAMO INSERIRE ANCHE L'ORARIO!

2022-12-31 00:00:01
```ruby
  scope :younger_than_thirty_created_at_2022, -> { where("age < 30 AND created_at >= '2022-01-01 00:00:00' AND created_at <= '2022-12-31 23:59:59'") } 
  scope :younger_than_created_at, ->(age, year) { where("age < ? AND created_at >= '?-01-01 00:00:00' AND created_at <= '?-12-31 23:59:59'", age, year, year) } # rails c -> User.younger_than_created_at(30, 2022)
```



## Query search LIKE

Models: Subject
  scope :search, -> { |query| where(["name LIKE ?", "%#{query}%"]) }

Models: AdminUser
  scope :named, -> { |first,last| where(first_name: first, last_name: last) }

Models: People
  scope :search, -> { |query| where(["first_name LIKE ? OR last_name LIKE ?", "%#{query}%", "%#{query}%"]) }

Models: Article

  scope :sorted, -> { order(:name) }

rails c
  Article.none # restituisce un ActiveRecord::Relation vuota. Utile per prepararsi a fare chaining successivi con vari scope.

  Article.where.not(name: "Hello")
  Article.order(name: :desc)

  Article.find_by_name("Hello") # il vecchio modo di fare dynamic binding
  Article.find_by name: "Hello" # il nuovo modo (doesn't require method missing)

  Article.find_or_create_by name: "Hello"
  Article.find_or_initializate_by name: "Hello"

Railcasts 415-upgrading-to-rails-4
Models: Episode
  scope :published, -> { where('published_on <= ?', Time.now.to_date) }



## Simple Search and Scope and Lambda

Railscasts 037-simple-search-form

Fonte: Lynda.com.Ruby.on.Rails.3.Essential.Training.2010-ADDiCT
-> 7. Models, ActiveRecord, and ActiveRelation -> 08 Named scopes.wmv 04:33

class Subject < ActiveRecord::Base

  scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])}

end


Fonte: Lynda.com.Ruby.on.Rails.3.Essential.Training.2010-ADDiCT
-> 7. Models, ActiveRecord, and ActiveRelation -> 08 Named scopes.wmv 05:40

class AdminUser < ActiveRecord::Base

  scope :named, lambda {|first,last| where(:first_name => first, :last_name => last)}

end


Fonte: Flavio - Cerca in qualsiasi punto del Nome o del Cognome della persona

class People < ActiveRecord::Base

  scope :search, lambda {|query| where(["first_name LIKE ? OR last_name LIKE ?", "%#{query}%", "%#{query}%"])}

end



## search scope and will pagination

@relateds = Related.all

  add old will_pagination
  @relateds = Related.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 6

add will_pagination
@relateds = Related.page(params[:page]).order('created_at ASC').per_page(6)

add search scope and will_pagination
@relateds = Related.search(params[:search]).page(params[:page]).per_page(6).order('created_at ASC')


models/users.rb
~~~~~~~~
  scope :search, lambda {|query| where(["email LIKE ?","%#{query}%"])}
~~~~~~~~


## Deprecation warning when using has_many through uniq in Rails 4

http://stackoverflow.com/questions/16569994/deprecation-warning-when-using-has-many-through-uniq-in-rails-4

Deprecation warning when using has_many :through :uniq in Rails 4

Q.---
Rails 4 has introduced a deprecation warning when using :uniq => true with has_many :through. For example:

has_many :donors, :through => :donations, :uniq => true

Yields the following warning:

DEPRECATION WARNING: The following options in your Goal.has_many :donors declaration are deprecated: :uniq. Please use a scope block instead. For example, the following:

    has_many :spam_comments, conditions: { spam: true }, class_name: 'Comment'

should be rewritten as the following:

    has_many :spam_comments, -> { where spam: true }, class_name: 'Comment'

What is the correct way to rewrite the above has_many declaration?

A.---
The uniq option needs to be moved into a scope block. Note that the scope block needs to be the second parameter to has_many (i.e. you can't leave it at the end of the line, it needs to be moved before the :through => :donations part):

has_many :donors, -> { uniq }, :through => :donations

It may look odd, but it makes a little more sense if you consider the case where you have multiple parameters. For example, this:

has_many :donors, :through => :donations, :uniq => true, :order => "name", :conditions => "age < 30"

becomes:

has_many :donors, -> { where("age < 30").order("name").uniq }, :through => :donations




## Filtriamo gli articoli di un blog per i soli pubblicati

aggiungiamo uno scope per gli articoli pubblicati nella sezione "# == Scopes" del model Post.

{id="02-08-01_01", title=".../app/models/post.rb", lang=ruby, line-numbers=on, starting-line-number=28}
~~~~~~~~
  scope :published, -> { where(published: true) }
~~~~~~~~