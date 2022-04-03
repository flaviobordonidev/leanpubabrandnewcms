# <a name="top"></a> Cap 20.1 - Organizziamo i models

Un modo semplice ed efficace per mantenere organizzato il codice all'interno dei models è quello di raggrupparlo all'interno di *divisori* prestabiliti.

Il *divisorio* non è altro che una linea di commento che seziona il codice in più parti.

```ruby
  # == Nome-Divisorio ============================================================
```



## Risorse interne

- [99-rails_references/models/01-organize_models]()




## Apriamo il branch "Organize Models"

```bash
$ git checkout -b om
```



## Divisori da mettere dentro i models

All'interno dei models della nostra applicazione usiamo i seguenti divisori.

***codice 01 - .../app/models/my_model.rb - line: 3***

```ruby
  # == Constants ============================================================
  
  # == Extensions ===========================================================

  # == Attributes ===========================================================

  # == Relationships ========================================================

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/20-organize_models/01_01-models-my_model.rb)


Vediamoli nel dettaglio.



### == Constants

Sono variabili fisse in genere tutte scritte in maiuscolo.

- `MY_CONSTANT = ...`



### == Extensions

Sono delle linee di codice precedute dalla chiamata "extend" 

- `extend MyModule`
- `extend FriendlyId`

> Se ci fossero degli `include ...` nel model li metteremmo qui. Ma normalmente gli `include ...` **non** sono nei models.



### == Attributes

Sono delle *nuove colonne* che vengono fornite alla tabella del model. 
In altre parole sono attributi della tabella non definiti a livello di database.

> ATTRIBUTES NOT MAPPED IN DATABASE => ***getter*** and ***setter*** methods.

- `attr_accessor :my_column_x`
- `translates :my_article_description`
- `has_attached_file :my_logo_image`
- `friendly_id :title, use: :slugged`



### == Relationships

Sono le relazioni uno-a-uno, uno-a-molti, molti-a-molti, polimoprfiche, ...

- `has_many :documents`
- `belongs_to :user`



### == Validations

Sono le funzioni di validazione implementate su alcune colonne della tabella.

```
validates: email, presence:     true,
                  uniqueness:   true,
                  email_format: true
```


### == Scopes

Sono chiamate di tipo lambda a delle queries che possiamo anche concatenare.

- `scope :published, -> { where(published: true) }`
- `scope :search, -> (query) {where("full_address ILIKE ? OR address_tag ILIKE ?", "%#{query.strip}%", "%#{query.strip}%")}`
- `scope :tagged, -> (tag){ tagged_with(tag) }`



### == Callbacks

Sono le chiamate che "solitamente" vediamo tra le prime ad esempio nei controllers. Nel caso del model sono finite un po' più in basso.
Sono le chiamate alle funzioni che vengono fatte "scattare" da un determinato evento (trigger).

- `before_validation :my_method_that_is_activated`
- `after_validation :my_other_method_that_is_activated`



### == Class Methods

sono i metodi scritti dentro il model che fanno riferimento a se stesso.

```ruby
def self.my_class_method
  ...
end
```



### == Instance Methods

sono i metodi scritti dentro il model.

```ruby
def my_class_method
  ...
end
```



## Esempio 1


***codice 02 - .../app/models/example1.rb - line:3***

```ruby
  # == Constants ============================================================
  
  GENDERS = [[‘Male’, ‘m’], [‘Female’, ’f’]].freeze

  # == Extensions ===========================================================

  ## friendly_id
  extend FriendlyId

  # == Attributes ===========================================================
  
  ## friendly_id
  friendly_id :title, use: :slugged

  ## globalize
  translates :sector, :memo, :fallbacks_for_empty_translations => true

  ## paperclip
  attr_accessor :remove_logo
  has_attached_file :logo, styles: { thumb: ["64x64!", :png] }
  has_attached_file :avatar, styles: {
    square_100: ‘100x100#’,
    square_300: ‘300x300#’
  }
  
  # == Relationships ========================================================
  
  ## association one-to-many
  has_many :documents

  # == Validations ==========================================================
  
  validates: email, presence:     true,
                    uniqueness:   true,
                    email_format: true

  # == Scopes ===============================================================

  scope :published, -> { where(published: true) }
  scope :search, -> (query) {where("full_address ILIKE ? OR address_tag ILIKE ?", "%#{query.strip}%", "%#{query.strip}%")}
  scope :tagged, -> (tag){ tagged_with(tag) }

  # == Callbacks ============================================================
  
  before_validation :normalize_name, on: :create
  after_validation :set_location, on: [ :create, :update ]
    
  # == Class Methods ========================================================
  
  def self.for_select
    all.collect{|u| [“#{u.name} (#{u.email})”, u.id]}
  end

  def self.from_the_class
    "Hello, from a class method"
  end

  # == Instance Methods =====================================================

  def from_an_instance
    "Hello, from an instance method"
  end
 
  private -------------------------------------------------------------------
  
    def normalize_name
      self.name = name.downcase.titleize
    end
 
    def set_location
      self.location = LocationService.query(self)
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/20-organize_models/01_02-models-example1.rb)



## Esempio 2


***codice 03 - .../app/models/example2.rb - line:3***

```ruby
class Post < ApplicationRecord
  # == Constants ============================================================
  
  # == Extensions ===========================================================

  ## friendly_id
  extend FriendlyId
  
  # == Attributes ===========================================================

  enum content_type: {image: 0, video_youtube: 1, video_vimeo: 2, audio: 3}

  ## ActiveStorage
  has_one_attached :main_image
  has_one_attached :paragraph_image1
  has_one_attached :paragraph_image4
  has_one_attached :paragraph_image5
  has_one_attached :paragraph_image6

  ## friendly_id
  friendly_id :title, use: :slugged

  ## acts_as_taggable_on
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  
  # == Relationships ========================================================

  ## one-to-many
  belongs_to :user

  # == Validations ==========================================================

  # == Scopes ===============================================================

  scope :published, -> { where(published: true) }

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

  ## friendly_id
  def should_generate_new_friendly_id?
    title_changed?
  end

  ## getter method
  def published_at_formatted 
    if published_at.present?
      published_at.strftime('%-d %-b %Y')
      #"Published #{published_at.strftime('%-d %-b %Y')}"
    else
      "not published yet"
    end
  end
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/20-organize_models/01_03-models-example2.rb)



## Organiziamo *EgPost*

Nel model EgPost abbiamo del codice nella:

- sezione *# == Attributes*, sottosezione *## Active Storage*
- sezione *# == Attributes*, sottosezione *## Action Text*
- sezione *# == Relationships*, sottosezione *## association one-to-many*

***codice 04 - .../app/models/eg_post.rb - line:3***

```ruby
class EgPost < ApplicationRecord
  # == Constants ============================================================
  
  # == Extensions ===========================================================

  # == Attributes ===========================================================

  ## Active Storage
  has_one_attached :header_image
  
  ## Action Text
  has_rich_text :content

  # == Relationships ========================================================

  ## association one-to-many
  belongs_to :user

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/20-organize_models/01_04-models-eg_post.rb)



## Organiziamo *User*

Nel model User abbiamo del codice nella:

- sezione *"*# == Extensions*, sottosezione *## devise*
- sezione *"*# == Attributes*, sottosezione *## enum*
- sezione *"*# == Relationships*, sottosezione *## association one-to-many*

***codice 05 - .../app/models/user.rb - line:3***

```ruby
class User < ApplicationRecord
  # == Constants ============================================================
  
  # == Extensions ===========================================================

  ## devise
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  # == Attributes ===========================================================

  ## enum
  #enum language: [:it, :en]
  enum language: {it: 0, en: 1}
  #enum role: [:user, :admin, :moderator, :author]
  enum role: {user: 0, admin: 1, moderator:2, author:3}

  # == Relationships ========================================================

  ## association one-to-many
  has_many :eg_posts

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/20-organize_models/01_05-models-user.rb)

> La parte di devise è nella sezione *Extensions* e non *Attributes* perché ogni voce non è una singola colonna nella tabella ma è un modulo che attiva più funzionalità e a volte più colonne nella tabella (che vanno abilitate con un migrate).



## Verifichiamo preview

nel preview non cambia nulla.



## archiviamo su git

```bash
$ git add -A
$ git commit -m "organize models"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku om:main
```

> Non serve `db:migrate` perché non abbiamo modificato la struttura del database.



## Chiudiamo il branch

Se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge om
$ git branch -d om
```



## Facciamo un backup su Github

Dal nostro branch main di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/19-rich_text_editor/03_00-style-action_text-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-eg_posts_published/01_00-published_seeds-it.md)
