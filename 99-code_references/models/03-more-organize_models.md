# Organiziamo il Model




## Keep code structure in models consistent

[articolo di rails-bestpractices.com](http://rails-bestpractices.com/posts/2011/05/31/keep-code-struture-in-models-consistent/)

Following Rails conventions, life is happy. It can be happier if we create conventions for codes in models, especially when there's multiple programmers working on the same model.

One example: (From top to bottom)

associations
scopes
class methods
validates
callbacks
instance methods

Code example:

{title=".../app/models/article.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class Article < ActiveRecord::Base
  has_many :comments
  belongs_to :author

  default_scope order("id desc")
  scope :published, where(:published => true)
  scope :created_after, lambda{|time| ["created_at >= ?", time]}

  class << self
    def batch_create(data)
      # ...
    end
  end

  validates :title, :presence => true

  before_create :init_score
  def init_score
    self.score = 10
  end

  def any_instance_method
    # ...
  end

  begin "score related functions" # Group functions by begin .. end
    def add_score(score)
      # ...
    end
  end

end
~~~~~~~~




## Altro Esempio

[sito web](https://gist.github.com/pifleo/2309931)

# Keep code struture in models consistent
# Inspired by http://rails-bestpractices.com/posts/2011/05/31/keep-code-struture-in-models-consistent/
# One example: (From top to bottom)

    associations
    scopes
    class methods
    validates
    callbacks
    instance methods

# And for models annotation
# http://rails-bestpractices.com/posts/68-annotate-your-models

$ gem install annotate
$ annotate --exclude tests,fixtures


{title=".../app/models/example.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
# encoding: utf-8
# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
# ...
# 

class User < ActiveRecord::Base

  ## 0. MODEL EXTENSIONS
  # - includes / extends
  include DeviseByLogin # lib/devise_by_login.rb

  # - Gems
  acts_as_follower # https://github.com/tcocca/acts_as_follower

  # - serialized attributes
  store :preferences, accessors: [ :dont_send_email ]

  ## 1. ASSOCIATIONS / ATTRIBUTES
  belongs_to :...
  has_one :profile, :dependent => :destroy
  has_many :...
  has_and_belongs_to_many :...

  accepts_nested_attributes_for :profile, :allow_destroy => true

  # - attr_accessible
  attr_accessible :username, ...
  attr_protected :...
  attr_accessor :...

  ## 2. SCOPES
  scope :confirmed, where('confirmed_at IS NOT NULL')

  ## 3. CLASS METHODS
  class << self
    
  end

  ## 4. VALIDATES
  validates :terms_of_service, :acceptance => true, :on => :create
  validates :password, :presence => true,
                    :confirmation => true,
                    :length => { :minimum => 6 },
                    :on => :create
  validates :username, :uniqueness => { :case_sensitive => false }, :if => :username?

  ## 5. CALLBACKS
  after_create :set_default_data

  ## 6. INSTANCE METHODS
  # - first attributes formatting
  def to_s
    self.name
  end

  # - others methods

  # - then private
  private
  def set_default_data
    
  end
end
~~~~~~~~



## Altro consiglio

Altri consigli su https://dan.chak.org/enterprise-rails/chapter-3-organizing-with-modules/

Molto interessante come mettere namespaces per le classi...

Libro molto ben fatto da comprare.
Spiega molto bene discorsivamente cosa andrà a fare nel codice così lo puoi leggere come un libro e poi c'è il codice che ti porta più nel pratico.
Inoltre porta avanti dei progetti proprio come stiamo facendo noi. Utile per prendere spunti per il libro.




## Altro consiglio 2

https://github.com/bbatsov/rails-style-guide

MOOLTO BELLO PER FARE VARI REFACTORINGS!!! Da leggere con calma ed attenzione. Ha molte saccadas.

Per quanto ci riguarda ora la parte utile è:

Group macro-style methods (has_many, validates, etc) in the beginning of the class definition. 


{title=".../app/models/user.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class User < ActiveRecord::Base
  # keep the default scope first (if any)
  default_scope { where(active: true) }

  # constants come up next
  COLORS = %w(red green blue)

  # afterwards we put attr related macros
  attr_accessor :formatted_date_of_birth

  attr_accessible :login, :first_name, :last_name, :email, :password

  # Rails4+ enums after attr macros, prefer the hash syntax
  enum gender: { female: 0, male: 1 }

  # followed by association macros
  belongs_to :country

  has_many :authentications, dependent: :destroy

  # and validation macros
  validates :email, presence: true
  validates :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :username, format: { with: /\A[A-Za-z][A-Za-z0-9._-]{2,19}\z/ }
  validates :password, format: { with: /\A\S{8,128}\z/, allow_nil: true }

  # next we have callbacks
  before_save :cook
  before_save :update_username_lower

  # other macros (like devise's) should be placed after the callbacks

  ...
end
~~~~~~~~