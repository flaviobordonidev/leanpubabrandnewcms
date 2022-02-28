# <a name="top"></a> Cap x.19 - Self Join

—
2.10 Self Joins	
https://guides.rubyonrails.org/association_basics.html

—
Self-Join in Rails
https://medium.com/@asuthamm/self-join-in-rails-8e3fc99c0634

—
The power of Self -Referential Associations in Rails (and self-joins)
https://medium.com/@ingridf/the-power-of-self-referential-associations-in-rails-and-self-joins-a9d31b181e4

—
Understanding Rails ActiveRecord "single model" self joins
https://stackoverflow.com/questions/9250409/understanding-rails-activerecord-single-model-self-joins

—
rails many to many self join
https://stackoverflow.com/questions/68987762/rails-migrations-many-to-many-relationship-between-the-same-class-interperson

—
Self-referential has_many :through associations
http://blog.hasmanythrough.com/2007/10/30/self-referential-has-many-through

create_table :animals do |t|
  t.string :species
end
create_table :hunts do |t|
  t.integer :predator_id
  t.integer :prey_id
  t.integer :capture_percent
end

class Animal < ActiveRecord::Base
  has_many :pursuits,  :foreign_key => 'predator_id',
                       :class_name => 'Hunt',
                       :dependent => :destroy
  has_many :preys,     :through => :pursuits
  has_many :escapes,   :foreign_key => 'prey_id',
                       :class_name => 'Hunt',
                       :dependent => :destroy
  has_many :predators, :through => :escapes
end
class Hunt < ActiveRecord::Base
  belongs_to :predator, :class_name => "Animal"
  belongs_to :prey,     :class_name => "Animal"
end

—
Problem with self-referential has_many :through associations in Rails
https://stackoverflow.com/questions/364934/problem-with-self-referential-has-many-through-associations-in-rails

create_table :animals do |t|
  t.string :species
end
create_table :hunts do |t|
  t.integer :predator_id
  t.integer :prey_id
  t.integer :capture_percent
end

class Animal < ActiveRecord::Base
  has_many :pursuits,  :foreign_key => 'predator_id',
                       :class_name => 'Hunt',
                       :dependent => :destroy
  has_many :preys,     :through => :pursuits
  has_many :escapes,   :foreign_key => 'prey_id',
                       :class_name => 'Hunt',
                       :dependent => :destroy
  has_many :predators, :through => :escapes
end
class Hunt < ActiveRecord::Base
  belongs_to :predator, :class_name => "Animal"
  belongs_to :prey,     :class_name => "Animal"
end

Solution:
<ul>
<% @animal.pursuits.each do |pursuit| %>
  <li><%= link_to "#{pursuit.capture_percent}%", pursuit.prey %></li>
<% end %>
</ul>
