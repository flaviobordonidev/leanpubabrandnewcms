# Organizzare i models


Risorse interne:

* 01-base/20-organize_models/01-the_method


Risorse web:

*[Organizing Ruby on Rails Models](https://www.zmwolski.com/Organizing-Ruby-on-Rails-Models)


---
Organizzare i models
https://www.zmwolski.com/Organizing-Ruby-on-Rails-Models

  # == Constants ============================================================

  # == Attributes ===========================================================
  
  # == Extensions ===========================================================

  # == Relationships ========================================================

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

Esempio:

  # == Constants ============================================================
  
  GENDERS = [[‘Male’, ‘m’], [‘Female’, ’f’]].freeze

  # == Attributes ===========================================================
  
  # ATTRIBUTES NOT MAPPED IN DATABASE (getter and setter methods)

  # paperclip ------------------------------------------------------------------
  attr_accessor :remove_logo
  #-----------------------------------------------------------------------------

  # globalize required ---------------------------------------------------------
  translates :sector, :memo, :fallbacks_for_empty_translations => true
  #-----------------------------------------------------------------------------

  # == Extensions ===========================================================

  # paperclip required ---------------------------------------------------------
  has_attached_file :logo, styles: { thumb: ["64x64!", :png] }
  #-----------------------------------------------------------------------------

  has_attached_file :avatar, styles: {
    square_100: ‘100x100#’,
    square_300: ‘300x300#’
  }

  # == Relationships ========================================================
    # associations
    
  has_many :documents

  # == Validations ==========================================================
  
  validates: email, presence:     true,
                    uniqueness:   true,
                    email_format: true

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================
  
  def self.for_select
    all.collect{|u| [“#{u.name} (#{u.email})”, u.id]}
  end

  # == Instance Methods =====================================================





## Ho fatto una domanda nel post e la risposta è un po' diversa da quanto ho riportato in 01-base/20-organize_models/01-the_method

### Question

A really great way to organize the model that I'would like to implement but I'm strugling with the following:
How do you use this way to organize with the methods that are "protected" and "private" ?

For example how can I organize the below model?

---
before_validation :normalize_name, on: :create
after_validation :set_location, on: [ :create, :update ]

GENDERS = [[‘Male’, ‘m’], [‘Female’, ’f’]].freeze

# paperclip
attr_accessor :remove_logo

# globalize required
translates :sector, :memo, :fallbacks_for_empty_translations => true

# paperclip required
has_attached_file :logo, styles: { thumb: ["64x64!", :png] }

has_attached_file :avatar, styles: {
square_100: ‘100x100#’,
square_300: ‘300x300#’
}

def main_method
method1
end

# association one-to-many
has_many :documents

def self.for_select
all.collect{|u| [“#{u.name} (#{u.email})”, u.id]}
end

def from_an_instance
"Hello, from an instance method"
end

def self.from_the_class
"Hello, from a class method"
end

validates: email, presence: true,
uniqueness: true,
email_format: true

protected 
def method1
puts "Hi this is #{self.class}"
end

private
def normalize_name
self.name = name.downcase.titleize
end

def set_location
self.location = LocationService.query(self)
end
---

Thanks




### Reply

Thanks for your question.

A little late, but I suppose better late than never.
Typically, I leave private and protected methods to the end. Since the class forces the indentation of all the methods, I typically don't indent the "types" so they stick out.

Here is your model organized based the suggestions in the model:

{title=".../app/models/user.rb", lang=ruby, line-numbers=on, starting-line-number=14}
```
class User < ActiveRecord::Base
  # == Constants ============================================================

  GENDERS = [[‘Male’, ‘m’], [‘Female’, ’f’]].freeze

  # == Attributes ===========================================================

  # paperclip
  attr_accessor :remove_logo

  # == Extensions ===========================================================

  # globalize required
  translates :sector, :memo, :fallbacks_for_empty_translations => true
  # paperclip required
  has_attached_file :logo, styles: { thumb: ["64x64!", :png] }

  # == Relationships ========================================================

  has_attached_file :avatar, styles: {
    square_100: ‘100x100#’,
    square_300: ‘300x300#’
  }
  # association one-to-many
  has_many :documents

  # == Validations ==========================================================
  validates: email, presence: true, uniqueness: true,
                    email_format: true

  # == Scopes ===============================================================

  # == Callbacks ============================================================
  before_validation :normalize_name, on: :create
  after_validation :set_location, on: [ :create, :update ]

  # == Class Methods ========================================================
  def self.from_the_class
    "Hello, from a class method"
  end

  def self.for_select
    all.collect{|u| [“#{u.name} (#{u.email})”, u.id]}
  end

  # == Instance Methods =====================================================
  def main_method
    method1
  end

  def from_an_instance
    "Hello, from an instance method"
  end

protected 
  def method1
    puts "Hi this is #{self.class}"
  end

private
  def normalize_name
    self.name = name.downcase.titleize
  end

  def set_location
    self.location = LocationService.query(self)
  end
end
```