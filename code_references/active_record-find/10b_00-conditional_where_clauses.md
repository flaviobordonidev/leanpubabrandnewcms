# <a name="top"></a> Cap active_record-find.10b - Conditional Where Clauses

Creiamo una serie di condizioni "where" concatenate.


## Risorse esterne

- [How to Add Conditional Where Clauses to a Rails Query](https://dpericich.medium.com/how-to-add-conditional-where-clauses-to-a-rails-query-aa716141c335)



## Risorse interne

- []()



## Articolo

Data is only as useful as the way it is communicated. This is what makes dashboard and reporting features popular in admin portals. To give users control of their data, you may add optional filters to sort, filter, and display data. Customizable queries do not guarantee you will receive a filter parameter for each filter option. To handle these situations in Ruby on Rails, you must add conditional where clauses to your SQL queries.


### Using If Else Checks for Each Parameter

Ruby on Rails offers developers a powerful Object Relational Mapping (ORM) tool to make writing SQL queries easier. Instead of writing a single raw SQL query string, Rails allows developers to combine multiple select, where, and join wrapper methods to create a chained SQL call.

This is great if we are guaranteed to receive arguments for each clause we want in our chain. If we are trying to query all work entries made by one of our team’s developers for a month or a year we could write something like this:


[Codice 01 - .../app/controllers/companies_controller.rb - linea: 1](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-set_rails_environment/01_01-home-.ssh-cloud-init.yaml)

```ruby
# Query all WorkEntry for a specific user for a month of a year
WorkEntry.where(month: month).where(year: year).where(user_id: user_id)
```

Code 1. Basic WorkEntry query without optional filter parameters.


This query searches for all WorkEntry records for a specific month, date, and user. While useful, this query is not flexible if we want to filter our queries differently. Say we wanted to query for all users during a specific year. Not selecting a month and user value would return a nil value. This query would look like this:

```ruby
# Query for all users for all months of the year 2023
WorkEntry.where(month: nil).where(year:2023).where(user_id: nil)
```

Code 2. WorkEntry query without optional month or user_id parameter values.

Using this query will **not** return what we want. Instead, we will return nothing or records with no month or user. If our models have validators to check for month, year, and user_id, we will get nothing back.

A very naive way to handle this problem is to use different queries based on the existence of each parameter:

```ruby
# month and year exist, but no user_id
if month && year
	WorkEntry.where(month: month).where(year: year)
elsif month && user_id
	WorkEntry.where(month: month).where(user_id: user_id)
elsif ...
  ...
else
	WorkEntry.all
end
```

Code 3. Naive approach to handling optinal query params in where clauses.


This works but is not flexible. We create a situation where we write 2^n else clauses for each additional optional parameter.


### Creating Separate Methods for Each Parameter

The first approach is not efficient for handling optional parameters in Rails where clauses. It requires maintenance every time a user requests a new optional parameter or changes a parameter to be required. We need to create a way for each parameter to be atomic.

We can create our own Rails scopes or custom chain methods. Ruby on Rails supports the concept of scopes, or class-level hard-coded where clauses that can be reused across queries. If we want to scope our orders to small orders with 5 or fewer items, medium orders with 6–10 items, or large orders with 11-plus items, we could create scopes for each order size.

Usually, scopes are for frequently used model-level queries, and our reporting filters may not hit the criteria. Instead, we choose to create class-level parameter clauses. For each optional parameter, we will create a separate class method to build our query:

```ruby
# Code for hacker approach
def self.for_month(month)
  if month
    where(month: month)
  else
    where(“1 = 1”)
  end
end

def self.for_user(user_id)
  if user_id
    where(user_id: user_id)
  else
    where(“1 = 1”)
  end
end

# Query our WorkEntry Records
WorkEntry.for_month(nil).for_year(2022).for_user(17)
```

Code 4. Using custom wrapped where clauses for optional filter parameters.

This query should work. We wrap our wrappers in conditional logic instead of directly calling the where clauses and risking malformed queries. If we pass a parameter over from the reporting UI, we will query the record for that. If there is no parameter passed, we will return all the records up to that point of the SQL chain.

What is the hacky “1 = 1” expression we use for nil parameters? This is an SQL injection-inspired way to return all the records for our parameter filter. Ruby on Rails takes all the where clauses attached to an ActiveModel object and combines them into a single WHERE clause. To return all records, even when we have no parameter given, I added a “1 = 1” expression that evaluates to true and returns all the records from the current ActiveRecord::Relation.

As I said earlier, this is hacky. I wanted to find a more professional way to maintain and pass on the current ActiveRecord::Relation object. Rails offers a method to do this with the all method. The last code block turns to this with the all method:

```ruby
# Code for hacker approach
def self.for_month(month)
  if month
    where(month: month)
  else
    all
  end
end

def self.for_user(user_id)
  if user_id
    where(user_id: user_id)
  else
    all
  end
end

# Query our WorkEntry Records
WorkEntry.for_month(nil).for_year(2022).for_user(17)
```

Figure 5. Using Rails built in `all` method to pass through ActiveRecord::Relation object without modifying.

We have a clean, maintainable, and professional way to handle optional parameters for filtering records in Ruby on Rails.











```bash
$ git checkout -b uis
```

Analizziamo il codice:

codice               | descrizione
|:-                  |:-
`params[:search] = "" if params[:search].blank?`  | se non è presente nell'url nessuna variabile "search" ne inizializziamo una con valore vuoto "". Altrimenti avremo errore nella query di ricerca.
`@companies = Company.search(params[:search])` | popoliamo la variabile di istanza @companies con tutte le aziende filtrate con il nostro scope "search()" a cui passiamo il valore di "params[:search]".

> Attenzione:</br> 
> "search()" non è un metodo di Rails. La definiamo **noi** nel model.




## Verifichiamo preview

```bash
$ rails s
```

e vediamo sul nostro browser:

* https://mycloud9path.amazonaws.com/companies

Andiamo sul campo "cerca..." digitiamo "AB" e clicchiamo il bottone "search" per fare la ricerca.
vediamo che le aziende sono filtrate e l'url diventa:

* https://mycloud9path.amazonaws.com/companies?search=AB

Funziona tutto.



## Salviamo su Git

```bash
$ git add -A
$ git commit -m "Implement search form on companies"
```
