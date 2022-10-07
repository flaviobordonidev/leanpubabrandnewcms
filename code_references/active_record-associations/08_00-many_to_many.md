# many_to_many association

Risorse web:

* [Sitepoing Master many_to_many](https://www.sitepoint.com/master-many-to-many-associations-with-activerecord/)
* Railscasts 181-include-vs-joins
* Railscasts 154-polymorphic-association-revised
* Railscasts 047-two-many-to-many [04:40]




## Le varie many_to_many

* Intransitive Associations
  If you have a direct, many-to-many relationship between two models, where no further semantical clarification is needed to describe the relationship, use a has_and_belongs_to_many association.
  
* Mono-transitive Associations
  If the many-to-many relationship is indirect or needs a single extra entity in order to be described fully and the relationship name can be captured by the extra model name, use a has_many :through association.
  
* Multi-transitive Associations
  If the many-to-many relationship has nuances that require multiple other entities in order to describe it, then use a has_many :through :source association.





### Intransitive Associations

This is the simplest many-to-many association. Two models are associated by simple virtue of their existence. A Book can be written by many authors and an Author may write many books. It is a direct association and there is a direct dependency between the two models. We can’t really have one without the other. In ActiveRecord this can easily be modeled with the has_and_belongs_to_many (HABTM) association. We can create the models and migrations for this relationship in Rails by running the following commands:

```
rails g model Author name:string
rails g model Book title:string
rails g migration CreateJoinTableAuthorsBooks authors books
```

We need to define the HABTM (Has And Below To Many) association in our models like this:

```
class Book < ApplicationRecord
  has_and_belongs_to_many :authors
end
```

```
class Author < ApplicationRecord
  has_and_belongs_to_many :books
end
```

Then, we can create our database tables by running:

```
rails db:migrate
```

Finally, we can populate our database:

```
herman = Author.create name: 'Herman Melville'
moby = Book.create title: 'Moby Dick'
herman.books << moby
```

We can now, among other things, access: a book’s Authors, all Books written by an Author and all Authors that have written a specific book:

```
moby.authors
herman.books
herman.books.where(title: 'Moby Dick')
Book.where(title: 'Moby Dick').authors
```

Nice and simple.




### Mono-transitive Associations

A transitive association that can be best described with the addition of a single extra model. Take the example of a Student. A Student can be taught by many Tutors and a Tutor can teach many Students, but we can’t fully express the relationship unless we include another entity: Class (to avoid Ruby reserved-name conflicts, let’s name it Klass)

```
rails g model Student name:string
rails g model Tutor name:string
rails g model Klass subject:string student:references tutor:references
```

We can say that a Student is taught through attending Klasses and that a Tutor teaches Students through giving Klasses. The word through is important here, as we use the same term in ActiveRecord to define the association:

```
class Student < ApplicationRecord
  has_many :klasses
  has_many :tutors, through: :klasses
end
```

```
class Tutor < ApplicationRecord
  has_many :klasses
  has_many :students, through: :klasses
end
```

```
class Klass < ApplicationRecord
  belongs_to :student
  belongs_to :tutor
end
```

Now we can create our database tables by running:

```
rails db:migrate
```

We can then populate the database:

```
bart = Student.create name: 'Bart Simpson'
edna = Tutor.create name: 'Mrs Krabapple'
Klass.create subject: 'Maths', student: bart, tutor: edna
```

As well as the usual simple finds we can also create some more complex queries:

```
Student.find_by(name: 'Bart Simpson').tutors  # find all Bart's tutors
Student.joins(:klasses).where(klasses: {subject: 'Maths'}).distinct.pluck(:name) # get all students who attend the Maths class
Student.joins(:tutors).joins(:klasses).where(klasses: {subject: 'Maths'}, tutors: {name: 'Mrs Krabapple'}).distinct.map {|x| puts x.name} # get all students who attend Maths taught by Mrs Krabapple
```

As in most cases of mono-transitive associations, the existing model names reflect the association implicitly (i.e. X has_many Z through Y), there is no need for us to do anything more and ActiveRecord will model our association perfectly.





### Multi-transitive Associations
A multi-transitive association is one that can be expressed best through many other models. We as Developers, for example, are associated with many software Communities. Our association, though, takes many forms: we may contribute code, post at forums, attend events, and many others. Each Developer is associated with a Community in their own way through specific actions. Let’s pick three of these actions for our example:

Contributing code
Posting on forums
Attending events
The next step in our modeling process is to define the data entities (models) which help realize these actions (associations). For our example, we can safely come up with:

Association	through Model
contributing code	Repository
posting at forums	Forum
attending events	Event
Now let’s go ahead and create the models we need:

```
rails g model Community name:string
rails g model Developer name:string
rails g model Repo url:string comment:string developer:references community:references
rails g model Forum url:string post:text developer:references community:references
rails g model Event location:string name:string developer:references community:references
rails db:migrate
```

Let’s also create some Developers and Communities:

```
devs = %w(joe sue fred mary).map {|dev| Developer.create name: dev}
comms = %w(rails nosql javascript postgres).map {|comm| Community.create name: comm}
```

We then can define the associations between our models. At this point we may be tempted to use the same technique we used in the mono-transitive example and repeat the has_many..through invocation for each association:

```
class Developer < ApplicationRecord
  has_many :events
  has_many :forums
  has_many :repos
  has_many :appearances, through: :events  #FAIL
  has_many :postings, through: :forums #FAIL
  has_many :contributions, through: :repos #FAIL
end
```

However, this won’t work as ActiveRecord will try to infer the name of the association’s source model from the association name (e.g appearance) and it will fail. For this reason we need to specify the source model name using the :source option:

```
class Developer < ApplicationRecord
  has_many :events
  has_many :forums
  has_many :repos
  has_many :appearances, through: :events, source: :community
  has_many :postings, through: :forums, source: :community
  has_many :contributions, through: :repos, source: :community
end
```

Similarly, we do the same for Communities:

```
class Community < ApplicationRecord
  has_many :events
  has_many :forums
  has_many :repos
  has_many :hostings, through: :events, source: :developer
  has_many :discussions, through: :forums, source: :developer
  has_many :contributions, through: :repos, source: :developer
end
```

As you may have noticed, on the Community model we are changing the names of some associations to reflect their nature from this side of the relationship. For instance, a Developer makes appearances at events, while a Community hosts events. A Developer posts at forums, while a Community fosters discussions at forums. This way, we are ensuring that our method names (that AR will dynamically create based on our associations) are meaningful and clear.

We can now create some events, forums, and repos:

```
Repo.create url: 'www.gitlab.com/342', comment: 'ruby code', developer: devs[0], community: comms[0]
Repo.create url: 'www.gitlab.com/662', comment: 'callbacks sample', developer: devs[0], community: comms[2]
Repo.create url: 'www.jsfiddle.com/abcg3', comment: 'reactive sample', developer: devs[1], community: comms[3]
Repo.create url: 'www.jsfiddle.com/563', comment: 'promises sample', developer: devs[2], community: comms[3]
Forum.create url: 'www.stackoverflow.com/mongodb', post: 'this is what I think...', developer: devs[2], community: comms[1]
Forum.create url: 'www.redis.com/563', post: 'my opinion is...', developer: devs[3], community: comms[1]
Event.create location: 'Bath, UK', name: 'Bath Ruby', developer: devs[2], community: comms[0]
Event.create location: 'Tech Institute', name: 'London NoSQL Meetup', developer: devs[2], community: comms[1]
```

We can then start extracting useful information from our models:

```
devs.find_by(name: 'fred').appearances # events a developer has appeared at
Event.find_by(community: comms[0]) # all events for the Rails community
Forum.where(developer: Developer.find_by(name: 'fred') # all forums where a specific developer has posted
Community.find_by(name: 'rails').hostings + Community.find_by(name: 'rails').discussions + Community.find_by(name: 'rails').contributions # get all events, forums and repositories for a specific community
Developer.select('distinct developers.name').joins(:repos).joins(:events).joins(:forums) # find developers who have appeared in Events, contributed to Repos and chatted on Forums, for any Community
```

We can use the associations directly and/or join the through models in an endless variety of permutations to retrieve the data we need.










## Altri esempi

has_many :through

  rails g model categorization product_id:integer category_id:integer position:integer

Models: Categorization
  belongs_to :product #has the foreign key (product_id)
  belongs_to :category #has the foreign key (category_id)

Models: Product
  has_many :categorizations
  has_many :categories, :through => :categorizations

Models: Category
  has_many :categorizations
  has_many :products, :through => :categorizations





## productField belongs_to product_type

Railscasts 403-dynamic-forms
rails g model ProductField name field_type required:boolean product_type:belongs_to

Models: ProductType
  has_many :productFields # o :product_fields ? (da verificare)
  --->
  has_many :fields, class_name: "ProductField"
  accept_nested_attributes_for :fields, allow_destroy: true # vedi Railcasts 196


rails g migration add_type_to_products product_type_id:integer properties:text # properties:text serializza i valori.
    in alternativa si può usare un campo hstore che permette di archiviare un Hash vedi Railcasts 345 hstore
    in alternativa si può usare una tabella properties con associazione many_to_one

Models: Product
  belongs_to :product_type
  serialize :properties, Hash
