# Ransack

Ransack is a gem used to search data, allowing to create both simple search and advanced search according to the application models in the program.

1. Ransack search functions

The basic search method in Ransack is known as the suffix (predicates) Suffixes are used in Ransack search queries to specify collation information.

Here are a few commonly used Ransack suffixes:

## eq (equals)

The eq suffix returns all records that have a field equal to the search value:

```ruby
 User.ransack(first_name_eq: "Ryan").result.to_sql
=> SELECT "users".* FROM "users" WHERE "users"."first_name" = "Ryan"
```

> not_eq : the opposite eq



## matches

Returns records with the same field as a search value:

```ruby
User.ransack(first_name_matches: "Ryan").result.to_sql
=> SELECT "users".* FROM "users" WHERE ("users"."first_name" LIKE "Ryan")
```

> does_not_match opposite matches



## lt(less than)

Returns all records whose field is less than the search value

```ruby
User.ransack(age_lt: 25).result.to_sql
SELECT "users".* FROM "users" WHERE ("users"."age" < 25)
```

> gt (greater than) vice versa lt



## lteq (less than equal to)

Returns all records less than or equal to the search value

```ruby
User.ransack(age_lteq: 25).result.to_sql
=> SELECT "users".* FROM "users" WHERE ("users"."age" <= 25)
```

> gteq (greater than or equal to) is the opposite of lteq



## in

The suffix inreturns records whose fields are in an available list:

```ruby
User.ransack(age_in: 20..25).result.to_sql
=> SELECT "users".* FROM "users" WHERE "users"."age" IN (20, 21, 22, 23, 24, 25)
```

> The opposite of in is not_in



## cont

The suffix contreturns all records whose field contains the search value

```ruby
User.ransack(first_name_cont: 'Rya').result.to_sql
=> SELECT "users".* FROM "users"  WHERE ("users"."first_name" LIKE '%Rya%')
```

> The opposite is not_cont



## start (start with)

Returns records whose fields start with the search value

```ruby
User.ransack(first_name_start: 'Rya').result.to_sql
=> SELECT "users".* FROM "users"  WHERE ("users"."first_name" LIKE 'Rya%')
```

> The opposite is not_start



## end (ends with) Returns records whose fields end with the search value

```ruby
User.ransack(first_name_end: 'yan').result.to_sql
=> SELECT "users".* FROM "users"  WHERE ("users"."first_name" LIKE '%yan')
```

> The opposite is not_end



## Sort with Ransack

In Ransack use helper sort_linkto create table with headers attached to link sort

```ruby
<%= sort_link(@q, :name) %>
```

You can add column names or default sort order:

```ruby
<%= sort_link(@q, :name, 'Last Name', default_order: :desc) %>
```

For polymorphic relations, it is necessary to specify the model name:

```ruby
<%= sort_link(@q, :xxxable_of_Ymodel_type_some_attribute, 'Attribute Name') %>
```

It is possible to sort multiple fields through a specific ordinal array:

```ruby
<%= sort_link(@q, :last_name, [:last_name, 'first_name asc'], 'Last Name') %>
```

Alternatively, it is possible to define a default sort order in the controller:

```ruby
@search = Post.ransack(params[:q])
@search.sorts = 'name asc' if @search.sorts.empty?
@posts = @search.result.paginate(page: params[:page], per_page: 20)
```



## Mix Search

To find records that match multiple searches, all search conditions can be merged into the ActiveRecord relation to perform a single query. To avoid conflict between table names, it is necessary to create a common context to store the table identifier names used for all conditions before initiating the search process.

```ruby
shared_context = Ransack::Context.for(Person)

search_parents = Person.ransack(
  { parent_name_eq: "A" }, context: shared_context
)

search_children = Person.ransack(
  { children_name_eq: "B" }, context: shared_context
)

shared_conditions = [search_parents, search_children].map { |search|
  Ransack::Visitor.new.accept(search.base)
}

Person.joins(shared_context.join_sources)
  .where(shared_conditions.reduce(&:or))
  .to_sql
```

from that will generate the query

```sql
SELECT "people".*
FROM "people"
LEFT OUTER JOIN "people" "parents_people"
  ON "parents_people"."id" = "people"."parent_id"
LEFT OUTER JOIN "people" "children_people"
  ON "children_people"."parent_id" = "people"."id"
WHERE (
  ("parents_people"."name" = 'A' OR "children_people"."name" = 'B')
  )
ORDER BY "people"."id" DESC
```



## Polymorphic searches

When generating searches from polymorphic models, you must specify the type of model you are looking for

Ex: with 2 models:

```ruby
class House < ActiveRecord::Base
  has_one :location, as: :locatable
end

class Location < ActiveRecord::Base
  belongs_to :locatable, polymorphic: true
end
```

Normally, if we don't use polymorphic relations, we will search by:

```ruby
Location.ransack(locatable_number_eq: 100).result
```

However, the above command will give an error:

```ruby
ActiveRecord::EagerLoadPolymorphicError: Can not eagerly load the polymorphic association :locatable
```

To be able to search the location by house number when the relationship is polymorphic, you must use:

```ruby
Location.ransack(locatable_of_House_type_number_eq: 100).result
```

with `_of_House_type_` added search key. That allows Ransack to specify the `table name` in the join querries.
