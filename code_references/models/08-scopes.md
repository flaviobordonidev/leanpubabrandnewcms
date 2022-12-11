# <a name="top"></a> Cap models.8 - Scopes

## Risorse interne

- [ubuntudream/16-steps-answers/03_00-user_answers_tidy_up-it]()
- [code_references/active_record-associations/10_00-include_vs_join.md]()
- [code_references/active_records-find/02_00-set_attributes.md]()



## Esempi vari

- `scope :published, -> { where(published: true) }`
- `scope :search, -> (query) {where("full_address ILIKE ? OR address_tag ILIKE ?", "%#{query.strip}%", "%#{query.strip}%")}`
- `scope :tagged, -> (tag){ tagged_with(tag) }`





base_line/22-eg_posts_published/05_00-publish-index-buttons-it.md:
  292  ```
  293:   scope :order_by_id, -> { order(id: :desc) }
  294  ```

  313  ```
  314:   scope :most_recent, -> { order(published_at: :desc) }
  315  ```



code_references/active_record-associations/10_00-include_vs_join.md:
  132  ```ruby
  133:   scope :search, lambda {|query| where(["name ILIKE ?","%#{query}%"])}
  134:   scope :complex_search, lambda {|query| includes(:employments).where(["name ILIKE ? OR summary ILIKE ?","%#{query}%","%#{query}%"])}
  135:   #scope :complex_search, lambda {|query| joins(:employments).where(["name ILIKE ? OR employments.summary ILIKE ?","%#{query}%","%#{query}%"])}
  136  ```

code_references/active_records-find/02_00-set_attributes.md:
  189  
  190: This method runs an SQL UPDATE query that updates the attributes of all objects without running any validations or callbacks. You can also call this method on a scoped relation. For exampe to update the name of all people called “Robbie”:
  191  

code_references/active_records-find/06_00-find-records-it.md:
  192  
  193: And you can combine where with a scope.
  194  
  195  ```ruby
  196: # scope definition
  197  class Book
  198:   scope :long_title, -> { where("LENGTH(title) > 20") }
  199  end

code_references/active_records-find/06a_00-find-data_time-it.md:
  33  
  34: Please clone and set up the [db_queries repository](https://github.com/mixandgo/prorb_db_queries), if you haven't done so already, and write a custom scope that retrieves all the users younger than 30 years old, and was created in 2022. Then paste your scope code in here.
  35  

  38  ```ruby
  39:   scope :younger_than_thirty_created_at_2022, -> { where("age < 30 AND created_at >= '2022-01-01' AND created_at <= '2022-12-31'") } 
  40:   scope :younger_than_created_at, ->(age, year) { where("age < ? AND created_at >= '?-01-01' AND created_at <= '?-12-31'", age, year, year) } # rails c -> User.younger_than_created_at(30, 2022)
  41  ```
  42  
  43: In the same project, write another scope that retrieves all the users that have an age between 20 and 45, and are happy. Then paste your scope code in here.
  44  

  46    # rails c -> User.age_between_20_45.happy
  47:   scope :age_between_20_45, -> { where(age: 20..45 ) }
  48:   scope :happy, -> { where(happy: true) }
  49  
  50:   scope :happy_age_20_45, -> {where("happy = true AND age BETWEEN 20 AND 45")}
  51:   scope :happy_age, ->(start, final) {where("happy = true AND age BETWEEN ? AND ?", start, final)} # rails c -> User.happy_age(20, 45)
  52  ```

  62  ```ruby
  63:   scope :this_year, ->(now) { where("created_at >= BEGINNING_OF_YEAR(now) AND created_at <= END_OF_YEAR(now)", now) } # rails c -> User.(Time.now)
  64  ```

code_references/active_records-find/09_00-scope_and_lambda.md:
    1: # <a name="top"></a> Cap *active_record*.9 - Scope and Lambda
    2  

    7  - Railcasts 215-advanced-queries-in-rails-3
    8: - [Queries - Scopes](https://school.mixandgo.com/targets/232)
    9  

   11  
   12: ## Scope query active user
   13  

   16  ```ruby
   17:   scope :active, -> { where(active: true) }
   18:   scope :older_than, ->(age) { where("age > ?", age) }
   19  ```

   29  
   30: ## DEFAULT scope
   31  
   32: Possiamo indicare un `default_scope` che viene eseguito sempre, anche se non è esplicitamente chiamato.
   33  

   36  ```ruby
   37:   default_scope :active, -> { where(active: true) }
   38:   scope :older_than, ->(age) { where("age > ?", age) }
   39  ```

   58  ```ruby
   59:   scope :active, -> { where(active: true) }
   60  
   61:   scope :older_than, ->(age) { where("age > ?", age) }
   62  
   63:   scope :younger_than_thirty, -> { where("age < 30") } # rails c -> User.younger_than_thirty.first(10)
   64:   scope :younger_than, ->(age) { where("age < ?", age) } # rails c -> User.younger_than(30).first(10)
   65  
   66:   scope :age_between_25_30, -> { where(age: 25..30 ) }
   67:   scope :age_between, ->(start, final) { where("age >= ? AND age <= ?", start, final)} # rails c -> User.age_between(25, 30).count
   68:   scope :age_between_v2, ->(start, final) { where("age BETWEEN ? AND ?", start, final)} # rails c -> User.age_between(25, 30).count
   69  
   70:   scope :created_at_test1, -> { where("created_at <= ?", Time.current) }
   71:   scope :created_at_test2, -> { where("created_at <= '2022-06-16 05:53:45.789268'") }
   72:   scope :created_at_test3, -> { where("created_at <= '2022-06-16'") }
   73  
   74:   scope :created_at_2022, -> { where(created_at: Date.new(2022, 1, 1)...Date.new(2023, 1, 1)) }
   75:   scope :created_at_2022_v2, -> { where("created_at >= '#{Date.new(2022, 1, 1)}' AND created_at < '#{Date.new(2023, 1, 1)}'") }
   76:   scope :created_at_2022_v3, -> { where(created_at: Date.new(2022, 1, 1)..Date.new(2022, 12, 31))}
   77:   scope :created_at_2022_v4, -> { where("created_at >= '#{Date.new(2022, 1, 1)}' AND created_at <= '#{Date.new(2022, 12, 31)}'") }
   78:   scope :created_at_2022_v5, -> { where("created_at >= '2022-01-01' AND created_at <= '2022-12-31'") }
   79:   scope :created_at_2022_v6, ->(year) { where("created_at >= '?-01-01' AND created_at <= '?-12-31'", year, year) } # rails c -> User.created_at_2022_v6(2022)
   80  
   81:   scope :younger_than_thirty_created_at_2022, -> { where("age < 30 AND created_at >= '2022-01-01' AND created_at <= '2022-12-31'") } 
   82:   scope :younger_than_created_at, ->(age, year) { where("age < ? AND created_at >= '?-01-01' AND created_at <= '?-12-31'", age, year, year) } # rails c -> User.younger_than_created_at(30, 2022)
   83  ```

   86  ```ruby
   87:   scope :younger_than_thirty_created_at_2022, -> { where("age < 30 AND created_at >= '2022-01-01' AND created_at <= '2022-12-31'") } 
   88:   scope :younger_than_created_at, ->(age, year) { where("age < ? AND created_at >= '?-01-01' AND created_at <= '?-12-31'", age, year, year) } # rails c -> User.younger_than_created_at(30, 2022)
   89  ```

  100  ```ruby
  101:   scope :younger_than_thirty_created_at_2022, -> { where("age < 30 AND created_at >= '2022-01-01 00:00:00' AND created_at <= '2022-12-31 23:59:59'") } 
  102:   scope :younger_than_created_at, ->(age, year) { where("age < ? AND created_at >= '?-01-01 00:00:00' AND created_at <= '?-12-31 23:59:59'", age, year, year) } # rails c -> User.younger_than_created_at(30, 2022)
  103  ```

  109  Models: Subject
  110:   scope :search, -> { |query| where(["name LIKE ?", "%#{query}%"]) }
  111  
  112  Models: AdminUser
  113:   scope :named, -> { |first,last| where(first_name: first, last_name: last) }
  114  
  115  Models: People
  116:   scope :search, -> { |query| where(["first_name LIKE ? OR last_name LIKE ?", "%#{query}%", "%#{query}%"]) }
  117  

  119  
  120:   scope :sorted, -> { order(:name) }
  121  
  122  rails c
  123:   Article.none # restituisce un ActiveRecord::Relation vuota. Utile per prepararsi a fare chaining successivi con vari scope.
  124  

  135  Models: Episode
  136:   scope :published, -> { where('published_on <= ?', Time.now.to_date) }
  137  

  139  
  140: ## Simple Search and Scope and Lambda
  141  

  144  Fonte: Lynda.com.Ruby.on.Rails.3.Essential.Training.2010-ADDiCT
  145: -> 7. Models, ActiveRecord, and ActiveRelation -> 08 Named scopes.wmv 04:33
  146  

  148  
  149:   scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])}
  150  

  154  Fonte: Lynda.com.Ruby.on.Rails.3.Essential.Training.2010-ADDiCT
  155: -> 7. Models, ActiveRecord, and ActiveRelation -> 08 Named scopes.wmv 05:40
  156  

  158  
  159:   scope :named, lambda {|first,last| where(:first_name => first, :last_name => last)}
  160  

  167  
  168:   scope :search, lambda {|query| where(["first_name LIKE ? OR last_name LIKE ?", "%#{query}%", "%#{query}%"])}
  169  

  173  
  174: ## search scope and will pagination
  175  

  183  
  184: add search scope and will_pagination
  185  @relateds = Related.search(params[:search]).page(params[:page]).per_page(6).order('created_at ASC')

  189  ~~~~~~~~
  190:   scope :search, lambda {|query| where(["email LIKE ?","%#{query}%"])}
  191  ~~~~~~~~

  206  
  207: DEPRECATION WARNING: The following options in your Goal.has_many :donors declaration are deprecated: :uniq. Please use a scope block instead. For example, the following:
  208  

  217  A.---
  218: The uniq option needs to be moved into a scope block. Note that the scope block needs to be the second parameter to has_many (i.e. you can't leave it at the end of the line, it needs to be moved before the :through => :donations part):
  219  

  234  
  235: aggiungiamo uno scope per gli articoli pubblicati nella sezione "# == Scopes" del model Post.
  236  

  238  ~~~~~~~~
  239:   scope :published, -> { where(published: true) }
  240  ~~~~~~~~

code_references/active_records-find/09_01-models-user.rb:
  1  class USer < ApplicationRecord
  2:   scope :active, -> { where(active: true) }
  3  end

code_references/active_records-find/09_02-models-user.rb:
   1  class User < ApplicationRecord
   2:   scope :active, -> { where(active: true) }
   3  
   4:   scope :older_than, ->(age) { where("age > ?", age) }
   5  
   6:   scope :younger_than_thirty, -> { where("age < 30") } # rails c -> User.younger_than_thirty.first
   7:   scope :younger_than, ->(age) { where("age < ?", age) } # rails c -> User.younger_than(30).first
   8  
   9:   scope :age_between_25_30, -> { where(age: 25..30 ) }
  10:   scope :age_between, ->(start, final) { where("age >= ? AND age <= ?", start, final)} # rails c -> User.age_between(25, 30)
  11:   scope :age_between_v2, ->(start, final) { where("age BETWEEN ? AND ?", start, final)} # rails c -> User.age_between(25, 30)
  12  
  13:   scope :created_at_test1, -> { where("created_at <= ?", Time.current) }
  14:   scope :created_at_test2, -> { where("created_at <= '2022-06-16 05:53:45.789268'") }
  15:   scope :created_at_test3, -> { where("created_at <= '2022-06-16'") }
  16  
  17:   scope :created_at_2022, -> { where(created_at: Date.new(2022, 1, 1)...Date.new(2023, 1, 1)) }
  18:   scope :created_at_2022_v2, -> { where("created_at >= '#{Date.new(2022, 1, 1)}' AND created_at < '#{Date.new(2023, 1, 1)}'") }
  19:   scope :created_at_2022_v3, -> { where(created_at: Date.new(2022, 1, 1)..Date.new(2022, 12, 31)) }
  20:   scope :created_at_2022_v4, -> { where("created_at >= '#{Date.new(2022, 1, 1)}' AND created_at <= '#{Date.new(2022, 12, 31)}'") }
  21:   scope :created_at_2022_v5, -> { where("created_at >= '2022-01-01' AND created_at <= '2022-12-31'") }
  22:   scope :created_at_2022_v6, ->(year) { where("created_at >= '?-01-01' AND created_at <= '?-12-31'", year, year) } # rails c -> User.created_at_2022_v6(2022)
  23  
  24:   scope :younger_than_thirty_created_at_2022, -> { where("age < 30 AND created_at >= '2022-01-01' AND created_at <= '2022-12-31'") } 
  25:   scope :younger_than_created_at, ->(age, year) { where("age < ? AND created_at >= '?-01-01' AND created_at <= '?-12-31'", age, year, year) } # rails c -> User.younger_than_created_at(30, 2022)
  26  
  27    # rails c -> User.age_between_20_45.happy
  28:   scope :age_between_20_45, -> { where(age: 20..45 ) }
  29:   scope :happy, -> { where(happy: true) }
  30  
  31:   scope :happy_age_20_45, -> {where("happy = true AND age BETWEEN 20 AND 45")}
  32:   scope :happy_age, ->(start, final) {where("happy = true AND age BETWEEN ? AND ?", start, final)} # rails c -> User.happy_age(20, 45)
  33  end

code_references/active_records-find/16_00-preload_scopes.md:
    1: # Preloas scopes
    2  

    7  
    8: * [How to Preload Rails Scopes](https://www.justinweiss.com/articles/how-to-preload-rails-scopes//?source=post_page-----5a0444d8b759----------------------)
    9  

   13  
   14: Rails’ scopes make it easy to find the records you want:
   15  

   19  
   20:   scope :positive, -> { where("rating > 3.0") }
   21  end

   27  
   28: Why? You can’t really preload a scope. So if you tried to show a few restaurants with their positive reviews:
   29  

   43  
   44: Convert scopes to associations
   45  When you use the Rails association methods, like belongs_to and has_many, your model usually looks like this:

   52  
   53: scope is one of the most useful. It works just like the scope from earlier:
   54  

   79  
   80: It gets worse: If you also wanted to grab all the positive reviews a person has ever left, you’d have to duplicate that scope over on the User class, too:
   81  

   88  
   89: There’s an easy way around this, though. Inside of where, you can use the positive scope you added to the Review class:
   90  

   97  
   98: Scopes are great. In the right place, they can make querying your data easy and fun. But if you want to avoid N+1 queries, you have to be careful with them.
   99  
  100: So, if a scope starts to cause you trouble, wrap it in an association and preload it. It’s not much more work, and it’ll save you a bunch of SQL calls.

code_references/active_storage/06-activestorage-filesupload_aws/03_00-image_resize.md:
  49  - Provides another backend `libvips` that has significantly better performance than `ImageMagick`.
  50: - Has a clear goal and scope and is well maintained. (It was originally written to be used with Shrine.)
  51  

code_references/authentication_authorization_roles/00-theory.md:
  56  
  57: Very simple Roles library without any authorization enforcement supporting scope on resource object.
  58  

code_references/authentication_authorization_roles/02_02-application_controller.rb:
  11  
  12:   def after_sign_in_path_for(resource_or_scope)
  13      #current_user # goes to users/1 (if current_user = 1)

  15      #eg_posts_path
  16:     stored_location_for(resource_or_scope) || super
  17    end

  53    def store_user_location!
  54:     # :user is the scope we are authenticating
  55      store_location_for(:user, request.fullpath)

code_references/authentication_authorization_roles/02_03-controllers-application_controller.rb:
  14  
  15:   def after_sign_in_path_for(resource_or_scope)
  16      #current_user # goes to users/1 (if current_user = 1)

  18      #eg_posts_path
  19:     stored_location_for(resource_or_scope) || super
  20    end

  56      def store_user_location!
  57:       # :user is the scope we are authenticating
  58        store_location_for(:user, request.fullpath)

code_references/authentication_authorization_roles/05-pundit.md:
   70  
   71: In addition to this you can define a `Scope` class. The intention of this class is to encapsulate the logic that defines which instances the user should be allowed to list. This is typically defined as an inner class of the policy class. The `Scope` class should be initialized with the user instance and an initial scope which you will chain to, based on the particular user passed. The `Scope` class should then define a `resolve` method that will define the list of model instances that the defined user has access to.
   72  

   94  
   95:   class Scope
   96:     attr_reader :user, :scope
   97  
   98:     def initialize(user, scope)
   99        @user  = user
  100:       @scope = scope
  101      end

  104        if user.is_admin
  105:         scope.all
  106        else
  107:         scope.where(published: true).or(scope.where(author: user.name))
  108        end

  123  
  124: By contrast the `Scope` does not concern itself with instances of the `Post` class, instead it uses the `ActiveRecord` query API to define which set of posts an individual user should be able to list. In our case the admin can list *all* posts, while other users should only see posts which are published, or which they have authored themselves.
  125  

  129        if user.is_admin
  130:         scope.all
  131        else
  132:         scope.where(published: true).or(scope.where(author: user.name))
  133        end

  138  
  139: In addition to the `authorize` method we can see the `policy_scope` helper method is being used in the index. This will be used to retrieve only the `Post` instances to which the `current_user` has access.
  140  

  146    def index
  147:     @posts = policy_scope(Post)
  148    end

  179  - You will need to define a policy class for each domain class that you wish to authorize actions against. This can lead to a lot of new policy classes being required, but it encourages simple well-defined policies, which are easily tested.
  180: - Within your controller you will use `authorize` and `policy_scope` helper methods to authorize your actions and scope your queries, respectively.
  181  - Pundit also adds a method to your controllers called `verify_authorized`. This method will raise an exception if `authorize` has not yet been called, which might be a useful safety check in some cases.

code_references/best-practise/02_00-security-it.md:
  173  
  174: ### Use Scopes to Avoid Data Leaking
  175  

  189  
  190: We can avoid it by using scopes within the given context. In the mentioned example, the current user is the scope:
  191  

code_references/bootstrap/02-bootstrap/01-install/02_00-install-bootstrap-it.md:
  257   * files in this directory. Styles in this file should be added after the last require_* statement.
  258:  * It is generally better to create a new file per style scope.
  259   *

  289   * files in this directory. Styles in this file should be added after the last require_* statement.
  290:  * It is generally better to create a new file per style scope.
  291   *

code_references/bootstrap/02-bootstrap/01-install/02_02-assets-stylesheets-application.css:
  10   * files in this directory. Styles in this file should be added after the last require_* statement.
  11:  * It is generally better to create a new file per style scope.
  12   *

code_references/bootstrap/02-bootstrap/01-install/02_03-assets-stylesheets-application.scss:
  10   * files in this directory. Styles in this file should be added after the last require_* statement.
  11:  * It is generally better to create a new file per style scope.
  12   *

code_references/bootstrap/02-bootstrap/02-components/02_02-assets-stylesheets-application.scss:
  10   * files in this directory. Styles in this file should be added after the last require_* statement.
  11:  * It is generally better to create a new file per style scope.
  12   *

code_references/bootstrap/02-bootstrap/02-components/02_04-assets-stylesheets-application.scss:
  10   * files in this directory. Styles in this file should be added after the last require_* statement.
  11:  * It is generally better to create a new file per style scope.
  12   *

code_references/bootstrap/02-bootstrap/02-components/02_05-assets-stylesheets-application.scss:
  10   * files in this directory. Styles in this file should be added after the last require_* statement.
  11:  * It is generally better to create a new file per style scope.
  12   *

code_references/bootstrap/02-bootstrap/03-users_layout/03_02-models-user.rb:
  38  
  39:   # == Scopes ===============================================================
  40  

code_references/bootstrap/02-bootstrap/25-pagination-style/01_00-style_pagination-it.md:
  235  
  236:   def after_sign_in_path_for(resource_or_scope)
  237      users_path

code_references/csv/zz-csv/02-transactions_seeds.txt:
  162  
  163: La parte di importazione la mettiamo nel model perché è lui che ha la competenza di interfacciarsi con il database. Creiamo un metodo (def nome_metodo  ...  end) che ha la particolarità del "self." questo gli serve perché va a scrivere nel database. E' un "setter method" ed ha bisogno quindi di richiamare il model su cui è definito con .self per un discorso di visibilità delle variabili (scope). Vedi setter e getter methods per maggiori dettagli.  
  164  

code_references/fonts_icons/04_01-assets-stylesheets-application.scss:
  10   * files in this directory. Styles in this file should be added after the last require_* statement.
  11:  * It is generally better to create a new file per style scope.
  12   *

code_references/gems/98_02-models-post-resurcify-friendly_id.rb:
  35  
  36:   # == Scopes ===============================================================
  37  
  38:   scope :published, -> { where(published: true) }
  39:   scope :most_recent, -> { order(published_at: :desc) }
  40:   scope :order_by_id, -> { order(id: :desc) }
  41  

code_references/git_github/06_00-github_login-it.md:
  49  
  50: Select the scopes, or permissions, you'd like to grant this token. To use your token to access repositories from the command line, select repo.
  51  
  52: Selecting token scopes
  53  

code_references/hotwire/04_00-turbo_streams-it.md:
  76  
  77: <%= form_with url: site_third_path, scope: "person" do |f| %>
  78    <%= f.text_field :name, placeholder: "Name" %>

  87  
  88: > Nel form inseriamo l'attributo `scope: "person"` per avere una struttura simile a quella che si ha quando il form è legato ad un Model (in questo caso sarebbe il model Person).
  89: > Nello specifico tutti i campi che dichiariamo nel form saranno annidati dentro la variabile dello `scope`, quindi nel nostro caso nella variabile `person`.<br/>
  90  > Esempio di annidamento:<br/>

code_references/hotwire/04_01-views-site-first.html.erb:
  29  
  30: <%= form_with url: site_third_path, scope: "person" do |f| %>
  31    <%= f.text_field :name, placeholder: "Name" %>

code_references/hotwire/04_04-views-site-first.html.erb:
  29  
  30: <%= form_with url: site_third_path, scope: "person" do |f| %>
  31    <%= hidden_field_tag :count, nil, id: "hidden-counter", value: @count %>

code_references/hotwire/04_07-views-site-first.html.erb:
  31  
  32: <%= form_with url: site_third_path, scope: "person" do |f| %>
  33    <%= hidden_field_tag :count, nil, id: "hidden-counter", value: @count %>

code_references/hotwire/05_01-views-site-first.html.erb:
  38  
  39: <%= form_with url: site_third_path, scope: "person" do |f| %>
  40    <%= hidden_field_tag :count, nil, id: "hidden-counter", value: @count %>

code_references/i18n_dynamic_database/OLD-gem_globalize/02_01-models-eg_post.rb:
  23  
  24:   # == Scopes ===============================================================
  25  
  26:   scope :published, -> { where(published: true) }
  27  

code_references/i18n_dynamic_database/OLD-gem_globalize/02_03-models-eg_post.rb:
  23  
  24:   # == Scopes ===============================================================
  25  
  26:   scope :published, -> { where(published: true) }
  27  

code_references/i18n_static_config_locale_yaml/03-format_cheat_sheet.md:
  13  # same as 'my.messages.hello'
  14: t(:hello, scope: 'my.messages')
  15: t(:hello, scope: [:my, :messages])
  16  

  84              blank: "Please enter a name."
  85: Possible scopes (in order):
  86  

code_references/images/03_00-image_resize.md:
  55  - Provides another backend `libvips` that has significantly better performance than `ImageMagick`.
  56: - Has a clear goal and scope and is well maintained. (It was originally written to be used with Shrine.)
  57  

code_references/models/02-organize_models.md:
   27  
   28:   # == Scopes ===============================================================
   29  

   75  
   76:   # == Scopes ===============================================================
   77  

  204  
  205:   # == Scopes ===============================================================
  206  

code_references/models/03-more-organize_models.md:
   14  associations
   15: scopes
   16  class methods

   28  
   29:   default_scope order("id desc")
   30:   scope :published, where(:published => true)
   31:   scope :created_after, lambda{|time| ["created_at >= ?", time]}
   32  

   70      associations
   71:     scopes
   72      class methods

  119  
  120:   ## 2. SCOPES
  121:   scope :confirmed, where('confirmed_at IS NOT NULL')
  122  

  183  class User < ActiveRecord::Base
  184:   # keep the default scope first (if any)
  185:   default_scope { where(active: true) }
  186  

code_references/ruby-data_types_and_i18n/102-format_date_time_i18n.md:
   95  ```
   96:   # == Scopes ===============================================================
   97  
   98:   scope :published, -> { where(published: true) }
   99:   scope :most_recent, -> { order(published_at: :desc) }
  100:   scope :order_by_id, -> { order(id: :desc) }
  101  ```

code_references/ruby_methods/Scopes.md:
   1  
   2: ## Scopes
   3  
   4: As these chains of method calls grow longer, making the chains themselves available for reuse becomes a concern. Once again, Rails delivers. An Active Record scope can be associated with a Proc and therefore may have arguments:
   5  
   6   	class Order < ActiveRecord::Base
   7:  	scope :last_n_days, lambda { |days| where('updated < ?' , days) }
   8   	end
   9: Such a named scope would make finding the last week’s worth of orders a snap:
  10  
  11   	orders = Order.last_n_days(7)
  12: Simpler scopes can simply be a set of method calls:
  13  
  14   	class Order < ActiveRecord::Base
  15:  	scope :checks, where(pay_type: :check)
  16   	end
  17: Scopes can also be combined. Finding the last week’s worth of orders that were paid by check is just as easy:
  18  
  19   	orders = Order.checks.last_n_days(7)
  20: In addition to making your application code easier to write and easier to read, scopes can make your code more efficient. The previous statement, for example, is implemented as a single SQL query.
  21  
  22: ActiveRecord::Relation objects are equivalent to an anonymous scope:
  23  

  27   	in_house.checks.last_n_days(7)
  28: Scopes aren’t limited to where conditions; we can do pretty much anything we can do in a method call: limit, order, join, and so on. Just be aware that Rails doesn’t know how to handle multiple order or limit clauses, so be sure to use these only once per call chain.

code_references/start_page/01-startpage.md:
  128  ~~~~~~~~
  129:   def after_sign_out_path_for(resource_or_scope)
  130      homepage_show_path

code_references/update_app/OLD-overview.txt:
  36  ~~~~~~~~
  37:   scope :most_recent, -> { order(id: :desc) }
  38  ~~~~~~~~

code_references/webpack/03_00-articolo.md:
  61  Webpack is different than Sprockets in the sense that it compiles modules.
  62: ES6 modules to be precise (in the case of Rails 6 with a default configuration). What does that imply? Well, it implies that everything you declare in a module is kind of namespaced because it is not meant to be accessible from the global scope but rather imported then used. Let me give you an example.
  63  You can do the following with Sprockets:

code_references/zzz-TO-ORGANIZE/06-from-elis6/02-controllers-application_controllers.rb:
  8    # https://github.com/plataformatec/devise/wiki/How-To:-Redirect-to-a-specific-page-on-successful-sign-in-out
  9:   def after_sign_out_path_for(resource_or_scope)
  10      homepage_path

code_references/zzz-TO-ORGANIZE/06-from-elis6/06_01-address.rb:
  30  
  31:   # == Scopes ===============================================================
  32  
  33:   scope :search, -> (query) {where("full_address ILIKE ? OR address_tag ILIKE ?", "%#{query.strip}%", "%#{query.strip}%")}
  34  

code_references/zzz-TO-ORGANIZE/06-from-elis6/06_03-company_person_map.rb:
  45  
  46:   # == Scopes ===============================================================
  47    
  48:   # sfrutto lo scope: search del model person 
  49:   scope :search_people, -> (query) {joins(:person).merge(Person.search(query))}
  50:   # sfrutto lo scope: search del model Company 
  51:   scope :search_companies, -> (query) {joins(:company).merge(Company.search(query))}
  52  

code_references/zzz-TO-ORGANIZE/06-from-elis6/06_04-company.rb:
  55  
  56:   # == Scopes ===============================================================
  57  
  58:   scope :search, -> (query) {with_translations.where("name ILIKE ?", "%#{query.strip}%")}
  59    

code_references/zzz-TO-ORGANIZE/06-from-elis6/06_05-component.rb:
  29  
  30:   # == Scopes ===============================================================
  31  
  32:   scope :search, -> (query) {with_translations.where("part_number ILIKE ? OR name ILIKE ?", "%#{query.strip}%", "%#{query.strip}%")}
  33  

code_references/zzz-TO-ORGANIZE/06-from-elis6/06_06-contact.rb:
  33  
  34:   # == Scopes ===============================================================
  35  
  36:   scope :search, -> (query) {with_translations.where("medium ILIKE ? OR identifier ILIKE ?", "%#{query.strip}%", "%#{query.strip}%")}
  37  

code_references/zzz-TO-ORGANIZE/06-from-elis6/06_07-dossier.rb:
  12  
  13:   # == Scopes ===============================================================
  14  
  15:   scope :search, -> (query) {where("dossier_number ILIKE ? OR name ILIKE ?", "%#{query.strip}%", "%#{query.strip}%")}
  16  

code_references/zzz-TO-ORGANIZE/06-from-elis6/06_08-favorite.rb:
  18  
  19:   # == Scopes ===============================================================
  20  

code_references/zzz-TO-ORGANIZE/06-from-elis6/06_09-history.rb:
  25                          
  26:   # == Scopes ===============================================================
  27  
  28:   scope :search, -> (query) {where("title ILIKE ?", "%#{query.strip}%")}
  29  

code_references/zzz-TO-ORGANIZE/06-from-elis6/06_10-person.rb:
  46  
  47:   # == Scopes ===============================================================
  48  
  49:   #scope :search, -> (query) {with_translations(I18n.locale).where("title ILIKE ? OR last_name ILIKE ? OR first_name ILIKE ?", "%#{query.strip}%", "%#{query.strip}%", "%#{query.strip}%")}
  50:   #scope :search, -> (query) {with_translations.where("title ILIKE ? OR last_name ILIKE ? OR first_name ILIKE ?", "%#{query.strip}%", "%#{query.strip}%", "%#{query.strip}%")}
  51:   #scope :search, -> (query) {with_translations.where("CONCAT_WS(' ', first_name, last_name) ILIKE ?", "%#{query.strip}%")}
  52:   scope :search, -> (query) {with_translations.where("first_name || ' ' || last_name ILIKE ?", "%#{query.strip}%")}
  53  

code_references/zzz-TO-ORGANIZE/06-from-elis6/06_11-select_related.rb:
  31  
  32:   # == Scopes ===============================================================
  33  
  34:   # ==== scope filters
  35:   scope :for_companies, -> {where(bln_companies: true)}
  36:   scope :for_components, -> {where(bln_components: true)}
  37:   scope :for_dossiers, -> {where(bln_dossiers: true)}
  38:   scope :for_homepage, -> {where(bln_homepage: true)}
  39:   scope :for_people, -> {where(bln_people: true)}
  40:   scope :search, -> (query) {with_translations(I18n.locale).where("name ILIKE ?", "%#{query.strip}%")}
  41  

code_references/zzz-TO-ORGANIZE/06-from-elis6/06_12-user.rb:
  20  
  21:   # == Scopes ===============================================================
  22  

donamatrails/01-frontend_assets/code-angle.txt:
  420   * files in this directory. Styles in this file should be added after the last require_* statement.
  421:  * It is generally better to create a new file per style scope.
  422   *

  444   * files in this directory. Styles in this file should be added after the last require_* statement.
  445:  * It is generally better to create a new file per style scope.
  446   *

donamatrails/02-st_homepage/05a-font-icons.scss:
  1760  }
  1761: .icon-stethoscope:before {
  1762  	content: "\e792";

donamatrails/02-st_homepage/05b-et-line.scss:
   36  */
   37: ⟪ 564 characters skipped ⟫-et-hourglass, .icon-et-lock, .icon-et-megaphone, .icon-et-shield, .icon-et-trophy, .icon-et-flag, .icon-et-map, .icon-et-puzzle, .icon-et-basket, .icon-et-envelope, .icon-et-streetsign, .icon-et-telescope, .icon-et-gears, .icon-et-key, .icon-et-paperclip, .icon-et-attachment, .icon-et-pricetags, .icon-et-lightbulb, .icon-et-layers, .icon-et-pencil, .icon-et-tools, .icon-et-tools-2, .icon-et-scissors, .icon-et-paintbrush, .icon-et-magnifying-glass, .icon-et-circle-compass, .icon-et-linegraph, .icon-et-mic, .icon-et-strategy, .icon-et-beaker, .icon-et-caution, .icon-et-recycle, .icon-et-anchor, .icon-et-profile-male, .icon-et-profile-female, .icon-et-bike, .icon-et-wine, .icon-et-hotairballoon, .icon-et-globe, .icon-et-genius, .icon-et-map-pin, .icon-et-dial, .icon-et-chat, .icon-et-heart, .icon-et-cloud, .icon-et-upload, .icon-et-download, .icon-et-target, .icon-et-hazardous, .icon-et-piechart, .icon-et-speedometer, .icon-et-global, .icon-et-compass, .icon-et-lifesaver, .icon-et-clock, .icon-et-aperture, .icon-et-quote, .icon-et-scope, .icon-et-alarmclock, .icon-et-refresh, .icon-et-happy, .icon-et-sad, .icon-et-facebook, .icon-et-twitter, .icon-et-googleplus, .icon-et-rss, .icon-et-tumblr, .icon-et-linkedin, .icon-et-dribbble {
   38  	font-family: 'et-line';

  174  }
  175: .icon-et-telescope:before {
  176  	content: "\e02a";

  312  }
  313: .icon-et-scope:before {
  314  	content: "\e058";

donamatrails/03-authorization/01-pundit_install.txt:
  169  
  170:   class Scope < Scope
  171      def resolve
  172:       scope
  173      end

  177  
  178: Lasciamo stare per il momento così com'è la **class Scope** che analizzeremo più avanti.
  179  Chiediamoci invece come mai non abbiamo incluso anche **def new?** visto che vogliamo che solo gli amministratori possano accedere alla pagina/view **kiosks/new**. La risposta è nella classe principale **ApplicationPolicy**.

donamatrails/04-csv/02-transactions_seeds.txt:
  162  
  163: La parte di importazione la mettiamo nel model perché è lui che ha la competenza di interfacciarsi con il database. Creiamo un metodo (def nome_metodo  ...  end) che ha la particolarità del "self." questo gli serve perché va a scrivere nel database. E' un "setter method" ed ha bisogno quindi di richiamare il model su cui è definito con .self per un discorso di visibilità delle variabili (scope). Vedi setter e getter methods su qualsiasi guida RoR per maggiori dettagli.  
  164  

donamatrails/kiosks/01-kiosks_show.txt:
  250  ~~~~~~~~
  251:   # scope filters --------------------------------------------------------------
  252:     #scope :search, lambda {|query| with_translations(I18n.locale).where(["name ILIKE ? ", "%#{query}%"])}
  253:     #scope :search_in_date_range, -> (query) {with_translations(I18n.locale).where(["name ILIKE ?", "%#{query}%"])}
  254:     scope :search_in_date_range, ->(start_date, end_date) {where(timestamp: start_date.to_date.beginning_of_day..end_date.to_date.end_of_day)}
  255    #-----------------------------------------------------------------------------

elisinfo/02-mockups/zz-01_01-basic_template.txt:
  626   * files in this directory. Styles in this file should be added after the last require_* statement.
  627:  * It is generally better to create a new file per style scope.
  628   *

elisinfo/02-mockups/zz-01-basic_template.txt:
  130   * files in this directory. Styles in this file should be added after the last require_* statement.
  131:  * It is generally better to create a new file per style scope.
  132   *

elisinfo/02-mockups/zz-03-bootstrap_switch.txt:
  56   * files in this directory. Styles in this file should be added after the last require_* statement.
  57:  * It is generally better to create a new file per style scope.
  58   *

elisinfo/04-Companies/01_02-models-company.rb:
  15  
  16:   # == Scopes ===============================================================
  17  

elisinfo/04-Companies/02_01-app-models-company.rb:
  19  
  20:   # == Scopes ===============================================================
  21  

elisinfo/04-Companies/05_05-models-telephone.rb:
  14  
  15:   # == Scopes ===============================================================
  16  

elisinfo/04-Companies/05_06-models-company.rb:
  22  
  23:   # == Scopes ===============================================================
  24  

elisinfo/04-Companies/06_03-models-telephone.rb:
  15  
  16:   # == Scopes ===============================================================
  17  

elisinfo/04-Companies/06_04-models-company.rb:
  26  
  27:   # == Scopes ===============================================================
  28  

elisinfo/04-Companies/08_02-models-email.rb:
  15  
  16:   # == Scopes ===============================================================
  17  

elisinfo/04-Companies/08_03-models-company.rb:
  26  
  27:   # == Scopes ===============================================================
  28  

elisinfo/04-Companies/09_02-models-social.rb:
  15  
  16:   # == Scopes ===============================================================
  17  

elisinfo/04-Companies/09_03-models-company.rb:
  37  
  38:   # == Scopes ===============================================================
  39  
  40:   #scope :search, -> (query) {with_translations(I18n.locale).where("name ILIKE ?", "%#{query.strip}%")}
  41:   #scope :search, -> (query) {with_translations.where("name ILIKE ?", "%#{query.strip}%")}
  42:   scope :search, -> (query) {with_translations(I18n.locale).distinct.where("name ILIKE ?", "%#{query.strip}%")}
  43  

elisinfo/04-Companies/10_00-index_search-it.md:
   72  * params[:search] = "" if params[:search].blank?  : se non è presente nell'url nessuna variabile "search" ne inizializziamo una con valore vuoto "". Altrimenti avremo errore nella query di ricerca.
   73: * @companies = Company.search(params[:search])    : popoliamo la variabile di istanza @companies con tutte le aziende filtrate con il nostro scope "search()" a cui passiamo il valore di "params[:search]". Attenzione "search()" non è un metodo di Rails. La definiamo noi nel model.
   74  

   81  
   82: Nella sezione "# == Scopes"
   83  

   85  ```
   86:   scope :search, -> (query) {with_translations.where("name ILIKE ?", "%#{query.strip}%")}
   87  ```

   97  ```
   98:   scope :search, lambda {|query| with_translations.where("name ILIKE ?", "%#{query.strip}%")}
   99  ```

  215  
  216:   scope :search, -> (query) {with_translations(I18n.locale).where("name ILIKE ?", "%#{query.strip}%").distinct}
  217  

  219  
  220:   scope :search, -> (query) {with_translations(I18n.locale).distinct.where("name ILIKE ?", "%#{query.strip}%")}
  221  

elisinfo/04-Companies/10_03-models-company.rb:
  31  
  32:   # == Scopes ===============================================================
  33  
  34:   #scope :search, -> (query) {with_translations(I18n.locale).where("name ILIKE ?", "%#{query.strip}%")}
  35:   scope :search, -> (query) {with_translations.where("name ILIKE ?", "%#{query.strip}%")}
  36  

elisinfo/04-Companies/13_01-models-company.rb:
  34  
  35:   # == Scopes ===============================================================
  36  
  37:   #scope :search, -> (query) {with_translations(I18n.locale).where("name ILIKE ?", "%#{query.strip}%")}
  38:   #scope :search, -> (query) {with_translations.where("name ILIKE ?", "%#{query.strip}%")}
  39:   scope :search, -> (query) {with_translations(I18n.locale).distinct.where("name ILIKE ?", "%#{query.strip}%")}
  40  

elisinfo/05-people/01_02-models-person.rb:
  15  
  16:   # == Scopes ===============================================================
  17  

elisinfo/05-people/03_04-models-telephone.rb:
  15  
  16:   # == Scopes ===============================================================
  17  

elisinfo/05-people/03_05-models-person.rb:
  19  
  20:   # == Scopes ===============================================================
  21  

elisinfo/05-people/05_01-models-email.rb:
  15  
  16:   # == Scopes ===============================================================
  17  

elisinfo/05-people/05_02-models-person.rb:
  23  
  24:   # == Scopes ===============================================================
  25  

elisinfo/05-people/06_03-models-person.rb:
  28  
  29:   # == Scopes ===============================================================
  30  
  31:   #scope :search, -> (query) {with_translations(I18n.locale).where("title ILIKE ? OR last_name ILIKE ? OR first_name ILIKE ?", "%#{query.strip}%", "%#{query.strip}%", "%#{query.strip}%")}
  32:   #scope :search, -> (query) {with_translations.where("title ILIKE ? OR last_name ILIKE ? OR first_name ILIKE ?", "%#{query.strip}%", "%#{query.strip}%", "%#{query.strip}%")}
  33:   #scope :search, -> (query) {with_translations.where("CONCAT_WS(' ', first_name, last_name) ILIKE ?", "%#{query.strip}%")}
  34:   scope :search, -> (query) {with_translations.where("title || ' ' || first_name || ' ' || last_name ILIKE ?", "%#{query.strip}%")}
  35  

elisinfo/05-people/06-people_index_search.txt:
  61  
  62: Nella sezione "# == Scopes"
  63  

  65  ```
  66:   #scope :search, -> (query) {with_translations(I18n.locale).where("title ILIKE ? OR last_name ILIKE ? OR first_name ILIKE ?", "%#{query.strip}%", "%#{query.strip}%", "%#{query.strip}%")}
  67:   #scope :search, -> (query) {with_translations.where("title ILIKE ? OR last_name ILIKE ? OR first_name ILIKE ?", "%#{query.strip}%", "%#{query.strip}%", "%#{query.strip}%")}
  68:   #scope :search, -> (query) {with_translations.where("CONCAT_WS(' ', first_name, last_name) ILIKE ?", "%#{query.strip}%")}
  69:   scope :search, -> (query) {with_translations.where("first_name || ' ' || last_name ILIKE ?", "%#{query.strip}%")}
  70  ```

elisinfo/05-people/08_01-models-person.rb:
  31  
  32:   # == Scopes ===============================================================
  33  
  34:   #scope :search, -> (query) {with_translations(I18n.locale).where("title ILIKE ? OR last_name ILIKE ? OR first_name ILIKE ?", "%#{query.strip}%", "%#{query.strip}%", "%#{query.strip}%")}
  35:   #scope :search, -> (query) {with_translations.where("title ILIKE ? OR last_name ILIKE ? OR first_name ILIKE ?", "%#{query.strip}%", "%#{query.strip}%", "%#{query.strip}%")}
  36:   #scope :search, -> (query) {with_translations.where("CONCAT_WS(' ', first_name, last_name) ILIKE ?", "%#{query.strip}%")}
  37:   #scope :search, -> (query) {with_translations.where("title || ' ' || first_name || ' ' || last_name ILIKE ?", "%#{query.strip}%")}
  38:   scope :search, -> (query) {with_translations(I18n.locale).distinct.where("title || ' ' || first_name || ' ' || last_name ILIKE ?", "%#{query.strip}%")}
  39  

elisinfo/06-company_person_maps/01_02-models-company_person_map.rb:
  17  
  18:   # == Scopes ===============================================================
  19  

elisinfo/06-company_person_maps/01_04-models-company_person_map.rb:
  18  
  19:   # == Scopes ===============================================================
  20  

elisinfo/06-company_person_maps/01_05-models-company.rb:
  31  
  32:   # == Scopes ===============================================================
  33  

elisinfo/06-company_person_maps/01_06-models-person.rb:
  28  
  29:   # == Scopes ===============================================================
  30  

elisinfo/06-company_person_maps/03_master_nested_search.txt:
   29  
   30: oltre a sfruttare le relazioni molti-a-molti tra i model Company, Person e CompanyPersonMap, sfruttiamo gli scopes per le ricerche.
   31  
   32: Abbiamo già lo scope :search sul model Company
   33: nella sezione "# == Scopes" 
   34  

   36  ```
   37:   scope :search, -> (query) {with_translations(I18n.locale).where("name ILIKE ?", "%#{query.strip}%")}
   38  ```

   40  
   41: E abbiamo già lo scope :search sul model Person
   42: nella sezione "# == Scopes" 
   43  

   46  ```
   47:   scope :search, -> (query) {with_translations.where("title || ' ' || first_name || ' ' || last_name ILIKE ?", "%#{query.strip}%")}
   48  ```

   56  ```
   57:   scope :search_nested_people, -> (query_master, query_nested) {Company.search(query_master).people.search(query_nested)}
   58  ```

   63  ```
   64:   scope :search_nested_companies, -> (query_master, query_nested) {Person.search(query_master).companies.search(query_nested)}
   65  ```

   85  > Company.where(name: "ABC srl")   # Dobbiamo mettere TUTTO il nome. altrimenti dobbiamo usare ILIKE.
   86: > Company.search("ABC")   # sfruttiamo lo scope :search del model Company
   87  

   90  > Person.where(first_name: "Flavio")
   91: > Person.search("Fla")   # sfruttiamo lo scope :search del model Person
   92  

  175  
  176: A questo punto gli scopes aggiuntivi li mettiamo su Company e Person e niente su CompanyPersonMap.
  177  

  180  
  181: Nella sorpassata versione di Elisinfo 6 avevamo creato il seguente scope sul Model CompanyPersonMap:
  182  

  185  ```
  186:   # == Scopes ===============================================================
  187    
  188:   # sfrutto lo scope: search del model person 
  189:   scope :search_people, -> (query) {joins(:person).merge(Person.search(query))}
  190  
  191:   # sfrutto lo scope: search del model Company 
  192:   scope :search_companies, -> (query) {joins(:company).merge(Company.search(query))}
  193  ```

  202  ```
  203:   scope :search_companies_people, -> (query_master, query_nested) {joins(:company, :person).merge(Company.search(query_master)).merge(Person.search(query_nested))}
  204:   scope :search_people_companies, -> (query_master, query_nested) {joins(:person, :company).merge(Person.search(query_master)).merge(Company.search(query_nested))}
  205  ```
  206  
  207: Ci sarebbero da fare più test ma ho la sensazione che i due scope in realtà diano lo stesso risultato. Quindi bastava farne uno e chiamarlo "scope :search".
  208  Comunque non abbiamo scelto questa strada e quindi questo resta a scopo didattico.
  209: Abbiamo scelto di non mettere nessuno "scope" sul model CompanyPersonMap.
  210  Continuiamo invece con la strada che abbiamo scelto.

  216  
  217: Alla luce delle ultime considerazioni usiamo gli "scope :search" già implementati nei models Company e Person.
  218  

elisinfo/06-company_person_maps/07_05-models-company_person_map.rb:
  20  
  21:   # == Scopes ===============================================================
  22  

elisinfo/06-company_person_maps/yyycompany_person_mapOLD3NESTED.rb:
  19  
  20:   # == Scopes ===============================================================
  21  

elisinfo/8-dinamic_selections/zz-03-homepage_i18n.txt:
  31    # https://github.com/plataformatec/devise/wiki/How-To:-Redirect-to-a-specific-page-on-successful-sign-in-out
  32:   def after_sign_out_path_for(resource_or_scope)
  33      homepage_show_path

elisinfo/8-dinamic_selections/zz-05_01select_relateds_virtual_attributes.txt:
  32    
  33:   # scope filters --------------------------------------------------------------
  34:   scope :for_homepage, -> {where(bln_homepage: true)}
  35    #-----------------------------------------------------------------------------

elisinfo/8-dinamic_selections/zz-05-select_relateds_virtual_attributes.txt:
  166  ~~~~~~~~
  167:   # scope filters --------------------------------------------------------------
  168:   scope :for_homepage, -> {where(bln_homepage: true)}
  169    #-----------------------------------------------------------------------------

  171  
  172: Per approfondimenti vedi la [guida di rails](http://guides.rubyonrails.org/active_record_querying.html#scopes) nella sezione scopes.
  173  
  174  ~~~~~~~~
  175:  scope :published,               -> { where(published: true) }
  176:  scope :published_and_commented, -> { published.where("comments_count > 0") }
  177  ~~~~~~~~

elisinfo/8-dinamic_selections/zz-06-select_relateds_search.txt:
  19  
  20: Creiamo lo ** scope :search ** nel model per la query di ricerca
  21  

  23  ~~~~~~~~
  24:   scope :search, -> (query) {with_translations(I18n.locale).where("name ILIKE ?", "%#{query.strip}%")}
  25  ~~~~~~~~
  26  
  27: scope   : permette di usare la query nel controller concatenando 
  28  :search : nome della query da usare nel controller in catena (es: SelectRelated.search)

  34  
  35: I> http://guides.rubyonrails.org/active_record_querying.html#scopes
  36  I>
  37: I>  scope :search, lambda {|query| with_translations(I18n.locale).where(["name ILIKE ? ", "%#{query}%"])}
  38  I>

  40  I>
  41: I>  scope :search, -> (query) {with_translations(I18n.locale).where(["name ILIKE ?", "%#{query}%"])}
  42  I>

  44  I>
  45: I> esempio old style ** scope :find_lazy, lambda {|id| where(:id => id)} **
  46  I>
  47: I> esempio new style: ** scope :find_lazy, -> (id) { where(id: id)} **
  48  I> 
  49: I> To support associations: ** scope :find_lazy, -> (object) { where(object_id: object.id) } **
  50  I>
  51: I> scope :in_daterange, ->(start_date, end_date) { where(created_at: start_date.to_date.beginning_of_day..end_date.to_date.end_of_day) }
  52  
  53  
  54: informiamo il controller di usare lo "scope search:" [01:](#code-companies_people-select_relateds_search-01)
  55  

elisinfo/8-dinamic_selections/zz-99-homepage_i18n.txt:
   85  invece di localhost:3000/mypath?:locale=it possiamu usare localhost:3000/it/mypath
   86: Per far questo mettiamo tutti i nostri percorsi "routes" dentro un blocco "scope".
   87  

   91  
   92:   scope "(:locale)", locale: /en|it/ do
   93    

  113  
  114: potevo lasciare uno scope più ampio ** scope "(:locale)" do ** ma questo mi creava un problema di sicurezza. Molto meglio verificare che sia passato un "locale" valido. Nel nostro caso o "it" o "en" che ho gestito nei miei files yml con la traduzione.
  115  

  136  
  137: Se provo a settare il parametro :locale sia attraverso lo scope (ad inizio URL) che a fine URL, vince lo scope:
  138  

  153  
  154: Su Rails 4 se provavo a navigare con lo "scope" su routes mi creava un problema sul comportamento di default di Rails di tutti i links.
  155  Su Rails 5 non ho un errore ma non rimane la scelta della lingua attraverso la navigazione.

elisinfo/z10-histories/01-histories_seeds.txt:
  105  
  106:   # == Scopes ===============================================================
  107  

elisinfo/z10-histories/02-histories_index_side_person.txt:
  181  ~~~~~~~~
  182:   # == Scopes ===============================================================
  183  
  184:   scope :search, -> (query) {with_translations(I18n.locale).where("medium ILIKE ? OR identifier ILIKE ?", "%#{query.strip}%", "%#{query.strip}%")}
  185  ~~~~~~~~

elisinfo/z11-components/01-components_seeds.txt:
  153  
  154:   # == Scopes ===============================================================
  155  

elisinfo/z11-components/02-homepage_components.txt:
  48  
  49: Implementiamo il search nel model di component dentro la sezione **# == Scopes ====**
  50  

  52  ~~~~~~~~
  53:   # == Scopes ===============================================================
  54  
  55:   scope :search, -> (query) {with_translations.where("part_number ILIKE ? OR name ILIKE ?", "%#{query.strip}%", "%#{query.strip}%")}
  56  ~~~~~~~~

elisinfo/z11-components/03-components_show.txt:
  245  
  246: ### Aggiungiamo lo scope nel model
  247  
  248: Aggiungiamo lo scope nella sezione **# == Scopes ====** sottosezione **# ==== scope filters**
  249  

  251  ~~~~~~~~
  252:   scope :for_components, -> {where(bln_components: true)}
  253  ~~~~~~~~

elisinfo/z12-products/01-products_seeds.txt:
  133  
  134:   # == Scopes ===============================================================
  135  

elisinfo/z13-dossiers/02_homepage_dossiers.txt:
  48  
  49: Implementiamo il search nel model di dossier dentro la sezione **# == Scopes ====**
  50  

  64  
  65:   # == Scopes ===============================================================
  66  
  67:   scope :search, -> (query) {where("dossier_number ILIKE ? OR name ILIKE ?", "%#{query.strip}%", "%#{query.strip}%")}
  68  

elisinfo/z13-dossiers/03_dossiers_show.txt:
  237  
  238: ### Aggiungiamo lo scope nel model
  239  
  240: Aggiungiamo lo scope nella sezione **# == Scopes ====** sottosezione **# ==== scope filters**
  241  

  243  ~~~~~~~~
  244:   scope :for_dossiers, -> {where(bln_dossiers: true)}
  245  ~~~~~~~~

elisinfo/z4-companies_people/03_homepage_companies_people.txt:
  225  ~~~~~~~~
  226:   # == Scopes ===============================================================
  227  
  228:   scope :search, -> (query) {with_translations(I18n.locale).where("name ILIKE ?", "%#{query.strip}%")}
  229  ~~~~~~~~
  230  
  231: I>il ** -> (query){... ** è un altro modo di scrivere ** scope :search_people, lambda {|query| joins(:person).merge(Person.search(query))} **
  232  

  259  ~~~~~~~~
  260:   # == Scopes ===============================================================
  261  
  262:   scope :search, -> (query) {with_translations(I18n.locale).where("title ILIKE ? OR last_name ILIKE ? OR first_name ILIKE ?", "%#{query.strip}%", "%#{query.strip}%", "%#{query.strip}%")}
  263  ~~~~~~~~
  264  
  265: I>il ** -> (query){... ** è un altro modo di scrivere ** scope :search_people, lambda {|query| joins(:person).merge(Person.search(query))} **
  266  

elisinfo/z4-companies_people/04-companies_people_show.txt:
  240  ~~~~~~~~
  241:   scope :for_people, -> {where(bln_people: true)}
  242  ~~~~~~~~

  457  ~~~~~~~~
  458:   scope :for_companies, -> {where(bln_companies: true)}
  459  ~~~~~~~~

elisinfo/z5-addresses_contacts-old/02-contacts_seeds.txt:
  108  
  109:   # == Scopes ===============================================================
  110  

elisinfo/z5-addresses_contacts-old/03-contacts_index_side_person.txt:
  166  ~~~~~~~~
  167:   # == Scopes ===============================================================
  168  
  169:   scope :search, -> (query) {with_translations(I18n.locale).where("medium ILIKE ? OR identifier ILIKE ?", "%#{query.strip}%", "%#{query.strip}%")}
  170  ~~~~~~~~

elisinfo/z5-addresses_contacts-old/04-addresses_index_side_person.txt:
  119  ~~~~~~~~
  120:   # == Scopes ===============================================================
  121  
  122:   scope :search, -> (query) {with_translations(I18n.locale).where("full_address ILIKE ? OR address_tag ILIKE ?", "%#{query.strip}%", "%#{query.strip}%")}
  123  ~~~~~~~~

elisinfo/z5-addresses_contacts-old/05-contacts_index_side_company.txt:
  149  
  150: Abbiamo già implementato lo **scope :search** sul model contact.
  151  Abbiamo anche già implementato il **.search(params[:search])** sull'azione **show** del controller companies_controller

elisinfo/z5-addresses_contacts-old/06-addresses_index_side_company.txt:
  102  
  103: Abbiamo già implementato lo **scope :search** sul model address.
  104  Abbiamo anche già implementato il **.search(params[:search])** sull'azione **show** del controller companies_controller

elisinfo/z5c-company_contact_maps/01-ccmaps_seeds.txt:
  165    
  166:   # scope filters --------------------------------------------------------------
  167:   scope :search, -> (query) {with_translations(I18n.locale).where("name ILIKE ?", "%#{query}%")}
  168    #-----------------------------------------------------------------------------

  198  
  199:   # scope filters --------------------------------------------------------------
  200:   scope :search, -> (query) {with_translations(I18n.locale).where("medium ILIKE ? OR identifier ILIKE ?", "%#{query}%", "%#{query}%")}
  201    #-----------------------------------------------------------------------------

elisinfo/z5c-company_contact_maps/03-ccmaps_index.txt:
  26  
  27:   #scope "(:locale)", locale: /en|it/ do
  28    

elisinfo/z5c-company_contact_maps/04-companies_show_ccmaps.txt:
  92  
  93:   #scope filters ---------------------------------------------------------------
  94:   # sfrutto lo scope: search del model contact 
  95:   scope :search_contacts, -> (query) {joins(:contact).merge(Contact.search(query))}
  96:   # sfrutto lo scope: search del model Company 
  97:   scope :search_companies, -> (query) {joins(:company).merge(Company.search(query))}
  98    #-----------------------------------------------------------------------------

elisinfo/z5c-company_contact_maps/05-contacts_show_ccmaps.txt:
  205  
  206:   #scope filters ---------------------------------------------------------------
  207:   # sfrutto lo scope: search del model contact 
  208:   scope :search_contacts, -> (query) {joins(:contact).merge(Contact.search(query))}
  209:   # sfrutto lo scope: search del model Company 
  210:   scope :search_companies, -> (query) {joins(:company).merge(Company.search(query))}
  211    #-----------------------------------------------------------------------------

elisinfo/z5c-company_contact_maps/06-mockup_ccmaps_edit.txt:
  49  
  50:   #scope "(:locale)", locale: /en|it/ do
  51    

elisinfo/z5c-company_contact_maps/09-ccmaps_new_contact.txt:
  154  ~~~~~~~~
  155:   # scope filters --------------------------------------------------------------
  156:   scope :search, -> (query) {with_translations(I18n.locale).where("medium ILIKE ? OR identifier ILIKE ?", "%#{query.strip}%", "%#{query.strip}%")}
  157    #-----------------------------------------------------------------------------

elisinfo/z5d-contact_person_maps/11-cpmaps_index_side_person.txt:
  127  
  128:   #scope filters ---------------------------------------------------------------
  129:   # sfrutto lo scope: search del model Contact 
  130:   scope :search_contacts, -> (query) {joins(:contact).merge(Contact.search(query))}
  131    #-----------------------------------------------------------------------------

elisinfo/z5d-contact_person_maps/13-cpmaps_new_side_person.txt:
  182  ~~~~~~~~
  183:   # scope filters --------------------------------------------------------------
  184:   scope :search, -> (query) {with_translations(I18n.locale).where("medium ILIKE ? OR identifier ILIKE ?", "%#{query.strip}%", "%#{query.strip}%")}
  185    #-----------------------------------------------------------------------------

elisinfo/z5d-contact_person_maps/99-apmaps_index_side_person.txt:
  161  
  162:   #scope filters ---------------------------------------------------------------
  163:   # sfrutto lo scope: search del model Contact 
  164:   scope :search_contacts, -> (query) {joins(:contact).merge(Contact.search(query))}
  165    #-----------------------------------------------------------------------------

elisinfo/z5d-contact_person_maps/zz-code-contact_person_maps/cpmaps_index_side_person.txt:
  11  
  12:   #scope "(:locale)", locale: /en|it/ do
  13    

elisinfo/z5d-contact_person_maps/zz-code-contact_person_maps/cpmaps_new_side_person.txt:
  209  
  210:   #scope filters ---------------------------------------------------------------
  211:   # sfrutto lo scope: search del model Contact 
  212:   scope :search_contacts, -> (query) {joins(:contact).merge(Contact.search(query))}
  213:   # sfrutto lo scope: search del model Person 
  214:   scope :search_people, -> (query) {joins(:person).merge(Person.search(query))}
  215    #-----------------------------------------------------------------------------

elisinfo/z5d-contact_person_maps/zz-code-contact_person_maps/cpmaps_seeds.txt:
  29  
  30:   # scope filters --------------------------------------------------------------
  31:   scope :search, -> (query) {with_translations(I18n.locale).where("medium ILIKE ? OR identifier ILIKE ?", "%#{query.strip}%", "%#{query.strip}%")}
  32    #-----------------------------------------------------------------------------

  85    
  86:   # scope filters --------------------------------------------------------------
  87:   scope :search, -> (query) {with_translations(I18n.locale).where("title ILIKE ? OR last_name ILIKE ? OR first_name ILIKE ?", "%#{query.strip}%", "%#{query.strip}%", "%#{query.strip}%")}
  88    #-----------------------------------------------------------------------------

elisinfo/z5d-contact_person_maps/zz-code-contact_person_maps/mockup_cpmaps_edit_contact_side.txt:
  11  
  12:   #scope "(:locale)", locale: /en|it/ do
  13    

elisinfo/z5e-contacts/01-mockup_contact_index.txt:
  35  
  36:   #scope "(:locale)", locale: /en|it/ do
  37    

elisinfo/z5e-contacts/05-mockup_contacts_show.txt:
  42    resources :contacts
  43:   #scope "(:locale)", locale: /en|it/ do
  44    

elisinfo/z5e-contacts/06-contacts_show.txt:
  112  
  113:   # scope filters --------------------------------------------------------------
  114:   scope :search, -> (query) {with_translations(I18n.locale).where("medium ILIKE ? OR identifier ILIKE ?", "%#{query}%", "%#{query}%")}
  115    #-----------------------------------------------------------------------------

elisinfo/z5e-contacts/07-mockup_contacts_edit.txt:
  45    resources :contacts
  46:   #scope "(:locale)", locale: /en|it/ do
  47    

elisinfo/z5e-contacts/09-mockup_contacts_new.txt:
  48    resources :contacts
  49:   #scope "(:locale)", locale: /en|it/ do
  50    

elisinfo/z6-company_person_maps/01-cpmaps_seeds.txt:
  117  
  118:   # == Scopes ===============================================================
  119  

elisinfo/z6-company_person_maps/02-cpmaps_index.txt:
  169  ~~~~~~~~
  170:   # == Scopes ===============================================================
  171    
  172:   # sfrutto lo scope: search del model person 
  173:   scope :search_people, -> (query) {joins(:person).merge(Person.search(query))}
  174  ~~~~~~~~
  175  
  176: I>il ** -> (query){... ** è un altro modo di scrivere ** scope :search_people, lambda {|query| joins(:person).merge(Person.search(query))} **
  177  I>
  178: I>in questo model l'elegante uso di merge che mi permette di usare lo "scope: search" del model person mi evita anche un problemaccio che avrei avuto cercando di scrivere di nuovo tutta la query:
  179  I>
  180: I>  #scope :search_people, lambda {|query| joins(:person).with_translations(I18n.locale).where(["person.first_name ILIKE ? OR person.last_name ILIKE ? OR employments.summary ILIKE ?","%#{query}%","%#{query}%","%#{query}%"])}
  181  I>

  223  ~~~~~~~~
  224:   # sfrutto lo scope: search del model Company 
  225:   scope :search_companies, -> (query) {joins(:company).merge(Company.search(query))}
  226  ~~~~~~~~

elisinfo/z6-company_person_maps/04-cpmaps_edit_select.txt:
  294  
  295: attiviamo il search. Abbiamo già lo **scope :search** nel company model
  296  

  298  ~~~~~~~~
  299:   scope :search, -> (query) {with_translations(I18n.locale).where("name ILIKE ?", "%#{query.strip}%")}
  300  ~~~~~~~~

  357  
  358: attiviamo il search. Abbiamo già lo **scope :search** nel person model
  359  

  361  ~~~~~~~~
  362:   scope :search, -> (query) {with_translations(I18n.locale).where("title ILIKE ? OR last_name ILIKE ? OR first_name ILIKE ?", "%#{query.strip}%", "%#{query.strip}%", "%#{query.strip}%")}
  363  ~~~~~~~~

elisinfo/z6-company_person_maps/code-company_contact_maps/ccmaps_new_contact.txt:
  377  
  378:   #scope filters ---------------------------------------------------------------
  379:   # sfrutto lo scope: search del model contact 
  380:   scope :search_contacts, -> (query) {joins(:contact).merge(Contact.search(query))}
  381:   # sfrutto lo scope: search del model Company 
  382:   scope :search_companies, -> (query) {joins(:company).merge(Company.search(query))}
  383    #-----------------------------------------------------------------------------

elisinfo/z7-favorites_company_person_maps/01-favorites_cpmaps_seeds.txt:
  111  
  112:   # == Scopes ===============================================================
  113  

elisinfo/z9-favorites_homepage/04-homepage_favorites_list.txt:
  82  ~~~~~~~~
  83:   # scope filters --------------------------------------------------------------
  84:   scope :search, -> (query) {where("copy_normal ILIKE ? OR copy_bold ILIKE ?", "%#{query}%", "%#{query}%")}
  85:   #scope :search, -> (query) {with_translations(I18n.locale).where("copy_normal ILIKE ? OR copy_bold ILIKE ?", "%#{query}%", "%#{query}%")}
  86    #-----------------------------------------------------------------------------

elisinfo/zzz2-mockupOLD/04_01-mockup_global_settings_logout.txt:
  10  Rails.application.routes.draw do
  11:   scope "(:locale)", locale: /en|it/ do
  12    

elisinfo/zzz2-mockupOLD/06-mockup_people_index.txt:
  32  Rails.application.routes.draw do
  33:   #scope "(:locale)", locale: /en|it/ do
  34    

elisinfo/zzz2-mockupOLD/07-mockup_companies_index.txt:
  34  
  35:   #scope "(:locale)", locale: /en|it/ do
  36    

elisinfo/zzz2-mockupOLD/08-mockup_select_relateds_index.txt:
  33  
  34:   #scope "(:locale)", locale: /en|it/ do
  35    

elisinfo/zzz2-mockupOLD/09-mockup_people_show.txt:
  44  
  45:   #scope "(:locale)", locale: /en|it/ do
  46    

elisinfo/zzz2-mockupOLD/10-mockup_companies_show.txt:
  44  
  45:   #scope "(:locale)", locale: /en|it/ do
  46    

elisinfo/zzz2-mockupOLD/11-mockup_people_edit.txt:
  47  
  48:   #scope "(:locale)", locale: /en|it/ do
  49    

elisinfo/zzz2-mockupOLD/12-mockup_companies_edit.txt:
  47  
  48:   #scope "(:locale)", locale: /en|it/ do
  49    

elisinfo/zzz2-mockupOLD/13-mockup_people_new.txt:
  50  
  51:   #scope "(:locale)", locale: /en|it/ do
  52    

elisinfo/zzz2-mockupOLD/14-mockup_companies_new.txt:
  50  
  51:   #scope "(:locale)", locale: /en|it/ do
  52    

instaclone/01-new_app/01_06-config-initializer-deivse.rb:
  242  
  243:   # ==> Scopes configuration
  244:   # Turn scoped views on. Before rendering "sessions/new", it will first check for
  245    # "users/sessions/new". It's turned off by default because it's slower if you
  246    # are using only default views.
  247:   # config.scoped_views = false
  248  
  249:   # Configure the default scope given to Warden. By default it's the first
  250    # devise role declared in your routes (usually :user).
  251:   # config.default_scope = :user
  252  
  253    # Set this configuration to false if you want /users/sign_out to sign out
  254:   # only the current scope. By default, Devise signs out all scopes.
  255:   # config.sign_out_all_scopes = true
  256  

  274    # up on your models and hooks.
  275:   # config.omniauth :github, 'APP_ID', 'APP_SECRET', scope: 'user,public_repo'
  276  

  282    #   manager.intercept_401 = false
  283:   #   manager.default_strategies(scope: :user).unshift :some_external_strategy
  284    # end

  296    # When using OmniAuth, Devise cannot automatically set OmniAuth path,
  297:   # so you need to do it manually. For the users scope, it would be:
  298    # config.omniauth_path_prefix = '/my_engine/users/auth'

instaclone/01-new_app/02_04-assets-stylesheets-application.css:
  10   * files in this directory. Styles in this file should be added after the last require_* statement.
  11:  * It is generally better to create a new file per style scope.
  12   *

instaclone/03-posts/02_02-assets-stylesheets-application.css:
  10   * files in this directory. Styles in this file should be added after the last require_* statement.
  11:  * It is generally better to create a new file per style scope.
  12   *

instaclone/05-commenting/01_10-assets-stylesheets-application.css:
  10   * files in this directory. Styles in this file should be added after the last require_* statement.
  11:  * It is generally better to create a new file per style scope.
  12   *

integram-agency-blog/01_02-models-post con friendly_id.rb:
  25  
  26:   # == Scopes ===============================================================
  27  
  28:   scope :published, -> { where(published: true) }
  29  

integram-agency-blog/c03-eg_posts_seeds/01_03-models-post.rb:
  14  
  15:   # == Scopes ===============================================================
  16  

integram-agency-blog/c03-eg_posts_seeds/01_04-models-user.rb:
  26  
  27:   # == Scopes ===============================================================
  28  

integram-agency-blog/c03-eg_posts_seeds/02_02-db-migrate-xxx_create_friendly_id_slugs.1.rb:
  13        t.string   :sluggable_type, :limit => 50
  14:       t.string   :scope
  15        t.datetime :created_at

  18      add_index :friendly_id_slugs, [:slug, :sluggable_type], length: { slug: 140, sluggable_type: 50 }
  19:     add_index :friendly_id_slugs, [:slug, :sluggable_type, :scope], length: { slug: 70, sluggable_type: 50, scope: 70 }, unique: true
  20    end

integram-agency-blog/c03-eg_posts_seeds/02_04-models-post.rb:
  20  
  21:   # == Scopes ===============================================================
  22  

integram-agency-blog/c03-eg_posts_seeds/02-gem-friendly_id.txt:
  401        t.string   :sluggable_type, :limit => 50
  402:       t.string   :scope
  403        t.datetime :created_at

  406      add_index :friendly_id_slugs, [:slug, :sluggable_type], length: { slug: 140, sluggable_type: 50 }
  407:     add_index :friendly_id_slugs, [:slug, :sluggable_type, :scope], length: { slug: 70, sluggable_type: 50, scope: 70 }, unique: true
  408    end

  450  
  451:   # == Scopes ===============================================================
  452  

integram-agency-blog/c03-eg_posts_seeds/03_01-policies-post_policy.rb:
   97      
   98:   class Scope < Scope
   99      def resolve
  100:       scope.all
  101      end

integram-agency-blog/c03-eg_posts_seeds/03-authorization.txt:
  393      
  394:   class Scope < Scope
  395      def resolve
  396:       scope.all
  397      end

integram-agency-blog/c04-authors-eg_posts/02-didattic-readers-posts.txt:
  17  Adesso abbiamo ovviamente errore nella nostra app. Risolviamo la cosa:
  18: Correggiamo il file di routes. Spostiamo il " resources :posts " dentro lo " scope module: 'readers' " 
  19  

  21  ~~~~~~~~
  22:   scope module: 'readers' do
  23      resources :posts

  26  
  27: la differenza tra scope e l'altro usato per authors è che nell'url non devo mettere readers/ in pratica è come se non fosse incapsulato.
  28  

  48  Adesso abbiamo ovviamente errore nella nostra app. Risolviamo la cosa:
  49: Correggiamo il file di routes. Spostiamo il **resources :posts** dentro lo **scope module: 'blog'** 
  50  

  52  ~~~~~~~~
  53:   scope module: 'blog' do
  54      resources :posts

  57  
  58: lasciamo dentro lo scope blog solo le chiamate di visualizzazione (index e show)
  59  

  66  
  67:   scope module: 'blog' do
  68      get 'posts' => 'posts#index'

  85  
  86: Vediamo la differenza tra **scope module:** e **namespace**
  87  
  88  il namespace si aspetta tutto il percorso nell'url
  89: lo scope nasconde il percorso reale e lascia solo la parte finale nell'url
  90  

integram-agency-blog/c05-enum_with_i18n/01_01-models-post.rb:
  22  
  23:   # == Scopes ===============================================================
  24  

integram-agency-blog/c07-active_storage-upload-eg_post_image/01_01-models-post.rb:
  25  
  26:   # == Scopes ===============================================================
  27  

integram-agency-blog/c07-active_storage-upload-eg_post_image/01-upload-image-aws.txt:
  235  
  236:   # == Scopes ===============================================================
  237  

integram-agency-blog/c11-acts-as-taggable/01-gem-acts-as-taggable-on_seeds.txt:
  753  
  754:   # == Scopes ===============================================================
  755  
  756:   scope :published, -> { where(published: true) }
  757  

integram-agency-blog/c11-acts-as-taggable/02-tag_links.txt:
  184  
  185: La soluzione è passare per uno scope
  186  

  188  ~~~~~~~~
  189:   scope :tagged, -> { tagged_with("gomme da masticare") }
  190  ~~~~~~~~

  207  ~~~~~~~~
  208:   scope :tagged, -> { tagged_with("gomme da masticare") }
  209  ~~~~~~~~

integram-agency-blog/c12-recent-highlighted-posts/01-highlighted_seeds.txt:
  56  
  57: aggiungiamo uno scope per gli articoli pubblicati
  58  

  60  ~~~~~~~~
  61:   scope :popular, -> { where(popular: true) }
  62  ~~~~~~~~

  68  
  69: usiamo lo scope appena creato nel posts_controller (e non in author/posts_controller) sull'azione index
  70  

integram-agency-blog/c14-social_sharing-facebook-twitter/01-facebook_twitter_seeds.txt:
  262  I>
  263: I> Ho la sensazione che funziona anche con le immagini private ma non ricevi un errore chiaro nel caso ci siano problemi. Devo fare qualche altro test, la cosa sembrava funzionare ma avevo un errore che ho scoperto essere immagine troppo piccola (almeno 200x200) quando l'ho resa pubblica.
  264  

integram-agency-blog/c14-social_sharing-facebook-twitter/01code-models-post.rb:
  38  
  39:   # == Scopes ===============================================================
  40  
  41:   scope :most_recent, -> { order(published_at: :desc) }
  42:   scope :published, -> { where(published: true) }
  43  

rebisworld/04-post_paragraphs-nested_forms/01_02-models-post_paragraph.rb:
  14  
  15:   # == Scopes ===============================================================
  16  

rebisworld/04-post_paragraphs-nested_forms/01_03-models-post.rb:
  35  
  36:   # == Scopes ===============================================================
  37  
  38:   scope :published, -> { where(published: true) }
  39  

rebisworld/04-post_paragraphs-nested_forms/04_02-models-post_paragraph.rb:
  16  
  17:   # == Scopes ===============================================================
  18  

rebisworld/04-post_paragraphs-nested_forms/07_01-models-post_paragraph.rb:
  16    belongs_to :post, inverse_of: :post_paragraphs
  17:   default_scope { order(list_position: "ASC") }
  18    

  20  
  21:   # == Scopes ===============================================================
  22  

rebisworld/04-post_paragraphs-nested_forms/08_04-models-post_paragraph.rb:
  13    belongs_to :post, inverse_of: :post_paragraphs
  14:   default_scope { order(list_position: "ASC") }
  15    

  17  
  18:   # == Scopes ===============================================================
  19  

rebisworld/04-post_paragraphs-nested_forms/08-add_field-list_position.txt:
   85  Cercare di mettere in ordine le form annidate è un po' rognoso.
   86: La soluzione più semplice è quella di dichiararlo come scope di default nel model post_paragraph
   87  

   94    belongs_to :post, inverse_of: :post_paragraphs
   95:   default_scope { order(list_position: "ASC") }
   96  ~~~~~~~~

  125  
  126: Non serve perché è automaticamente gestito con il "default_scope" nel model PostParagraph.
  127  Altrimenti avremmo dovuto inserirlo su:

theme-angle/02-import-angle-rails_seed/03_01-controllers-application_controller.rb:
  14  
  15:   def after_sign_in_path_for(resource_or_scope)
  16      #current_user # goes to users/1 (if current_user = 1)

  18      #eg_posts_path
  19:     stored_location_for(resource_or_scope) || super
  20    end

  59      def store_user_location!
  60:       # :user is the scope we are authenticating
  61        store_location_for(:user, request.fullpath)

theme-angle/02-import-angle-rails_seed/code-angle.txt:
  420   * files in this directory. Styles in this file should be added after the last require_* statement.
  421:  * It is generally better to create a new file per style scope.
  422   *

  444   * files in this directory. Styles in this file should be added after the last require_* statement.
  445:  * It is generally better to create a new file per style scope.
  446   *

theme-eduport/03-bootstrap/01_04-assets-stylesheets-application.scss:
  10   * files in this directory. Styles in this file should be added after the last require_* statement.
  11:  * It is generally better to create a new file per style scope.
  12   *

theme-eduport/04-eduport_index/02_02-assets-stylesheets-application.scss:
  10   * files in this directory. Styles in this file should be added after the last require_* statement.
  11:  * It is generally better to create a new file per style scope.
  12   *

theme-eduport/21-eduport_course_detail-min/01_03-theme_eduport-course-detail-min.html:
  453  								<p class="mb-3">In this practical hands-on training, you’re going to learn to become a digital marketing expert with this <strong> ultimate course bundle that includes 12 digital marketing courses in 1!</strong></p>
  454: 								<p class="mb-3">If you wish to find out the skills that should be covered in a basic digital marketing course syllabus in India or anywhere around the world, then reading this blog will help. Before we delve into the advanced <strong><a href="#" class="text-reset text-decoration-underline">digital marketing course</a></strong> syllabus, let’s look at the scope of digital marketing and what the future holds.</p>
  455  								<p class="mb-0">We focus a great deal on the understanding of behavioral psychology and influence triggers which are crucial for becoming a well rounded Digital Marketer. We understand that theory is important to build a solid foundation, we understand that theory alone isn’t going to get the job done so that’s why this course is packed with practical hands-on examples that you can follow step by step.</p>

theme-pofo/02-mockups-blog-clean-full-width/06_01-et-line-icons.scss:
   31  */
   32: ⟪ 435 characters skipped ⟫con-adjustments, .icon-ribbon, .icon-hourglass, .icon-lock, .icon-megaphone, .icon-shield, .icon-trophy, .icon-flag, .icon-map, .icon-puzzle, .icon-basket, .icon-envelope, .icon-streetsign, .icon-telescope, .icon-gears, .icon-key, .icon-paperclip, .icon-attachment, .icon-pricetags, .icon-lightbulb, .icon-layers, .icon-pencil, .icon-tools, .icon-tools-2, .icon-scissors, .icon-paintbrush, .icon-magnifying-glass, .icon-circle-compass, .icon-linegraph, .icon-mic, .icon-strategy, .icon-beaker, .icon-caution, .icon-recycle, .icon-anchor, .icon-profile-male, .icon-profile-female, .icon-bike, .icon-wine, .icon-hotairballoon, .icon-globe, .icon-genius, .icon-map-pin, .icon-dial, .icon-chat, .icon-heart, .icon-cloud, .icon-upload, .icon-download, .icon-target, .icon-hazardous, .icon-piechart, .icon-speedometer, .icon-global, .icon-compass, .icon-lifesaver, .icon-clock, .icon-aperture, .icon-quote, .icon-scope, .icon-alarmclock, .icon-refresh, .icon-happy, .icon-sad, .icon-facebook, .icon-twitter, .icon-googleplus, .icon-rss, .icon-tumblr, .icon-linkedin, .icon-dribbble {
   33  	font-family: 'et-line';

  169  }
  170: .icon-telescope:before {
  171  	content: "\e02a";

  307  }
  308: .icon-scope:before {
  309  	content: "\e058";

theme-pofo/02-mockups-blog-clean-full-width/12_00-webpack-adjustes_for_megamenu.txt:
  27  
  28: Ho scoperto che il problema era in tutti e tre i files di "revolution" lato assets/stylesheets
  29  

theme-pofo/02-OLDmockups-blog-clean-full-width/03_02-assets-stylesheets-application_mockup_pofo.scss:
  10   * files in this directory. Styles in this file should be added after the last require_* statement.
  11:  * It is generally better to create a new file per style scope.
  12   *

theme-pofo/02-OLDmockups-blog-clean-full-width/06_01-et-line-icons.css:
   31  */
   32: ⟪ 435 characters skipped ⟫con-adjustments, .icon-ribbon, .icon-hourglass, .icon-lock, .icon-megaphone, .icon-shield, .icon-trophy, .icon-flag, .icon-map, .icon-puzzle, .icon-basket, .icon-envelope, .icon-streetsign, .icon-telescope, .icon-gears, .icon-key, .icon-paperclip, .icon-attachment, .icon-pricetags, .icon-lightbulb, .icon-layers, .icon-pencil, .icon-tools, .icon-tools-2, .icon-scissors, .icon-paintbrush, .icon-magnifying-glass, .icon-circle-compass, .icon-linegraph, .icon-mic, .icon-strategy, .icon-beaker, .icon-caution, .icon-recycle, .icon-anchor, .icon-profile-male, .icon-profile-female, .icon-bike, .icon-wine, .icon-hotairballoon, .icon-globe, .icon-genius, .icon-map-pin, .icon-dial, .icon-chat, .icon-heart, .icon-cloud, .icon-upload, .icon-download, .icon-target, .icon-hazardous, .icon-piechart, .icon-speedometer, .icon-global, .icon-compass, .icon-lifesaver, .icon-clock, .icon-aperture, .icon-quote, .icon-scope, .icon-alarmclock, .icon-refresh, .icon-happy, .icon-sad, .icon-facebook, .icon-twitter, .icon-googleplus, .icon-rss, .icon-tumblr, .icon-linkedin, .icon-dribbble {
   33  	font-family: 'et-line';

  169  }
  170: .icon-telescope:before {
  171  	content: "\e02a";

  307  }
  308: .icon-scope:before {
  309  	content: "\e058";

theme-pofo/02-OLDmockups-blog-clean-full-width/06_02-font-awesome.min.css:
  4   */
  5: ⟪ 23083 characters skipped ⟫\f1b0"}.fa-paypal:before{content:"\f1ed"}.fa-pen-square:before{content:"\f14b"}.fa-pencil-alt:before{content:"\f303"}.fa-people-carry:before{content:"\f4ce"}.fa-percent:before{content:"\f295"}.fa-periscope:before{content:"\f3da"}.fa-phabricator:before{content:"\f3db"}.fa-phoenix-framework:before{content:"\f3dc"}.fa-phone:before{content:"\f095"}.fa-phone-slash:before{content:"\f3dd"}.fa-phone-square:before{content:"\f098"}.fa-phone-volume:before{content:"\f2a0"}.fa-php:before{content:"\f457"}.fa-pied-piper:before{content:"\f2ae"}.fa-pied-piper-alt:before{content:"\f1a8"}.fa-pied-piper-hat:before{content:"\f4e5"}.fa-pied-piper-pp:before{content:"\f1a7"}.fa-piggy-bank:before{content:"\f4d3"}.fa-pills:before{content:"\f484"}.fa-pinterest:before{content:"\f0d2"}.fa-pinterest-p:before{content:"\f231"}.fa-pinterest-square:before{content:"\f0d3"}.fa-plane:before{content:"\f072"}.fa-play:before{content:"\f04b"}.fa-play-circle:before{content:"\f144"}.fa-playstation:before{content:"\f3df"}.fa-plug:before{content:"\f1e6"}.fa-plus:before{content:"\f067"}.fa-plus-circle:before{content:"\f055"}.fa-plus-square:before{content:"\f0fe"}.fa-podcast:before{content:"\f2ce"}.fa-poo:before{content:"\f2fe"⟪ 4295 characters skipped ⟫steam:before{content:"\f1b6"}.fa-steam-square:before{content:"\f1b7"}.fa-steam-symbol:before{content:"\f3f6"}.fa-step-backward:before{content:"\f048"}.fa-step-forward:before{content:"\f051"}.fa-stethoscope:before{content:"\f0f1"}.fa-sticker-mule:before{content:"\f3f7"}.fa-sticky-note:before{content:"\f249"}.fa-stop:before{content:"\f04d"}.fa-stop-circle:before{content:"\f28d"}.fa-stopwatch:before{content:"\f2f2"}.fa-strava:before{content:"\f428"}.fa-street-view:before{content:"\f21d"}.fa-strikethrough:before{content:"\f0cc"}.fa-stripe:before{content:"\f429"}.fa-stripe-s:before{content:"\f42a"}.fa-studiovinari:before{content:"\f3f8"}.fa-stumbleupon:before{content:"\f1a4"}.fa-stumbleupon-circle:before{content:"\f1a3"}.fa-subscript:before{content:"\f12c"}.fa-subway:before{content:"\f239"}.fa-suitcase:before{content:"\f0f2"}.fa-sun:before{content:"\f185"}.fa-superpowers:before{content:"\f2dd"}.fa-superscript:before{content:"\f12b"}.fa-supple:before{content:"\f3f9"}.fa-sync:before{content:"\f021"}.fa-sync-alt:before{content:"\f2f1"}.fa-syringe:before{content:"\f48e"}.fa-table:before{content:"\f0ce"}.fa-table-tennis:before{content:"\f45d"}.fa-tablet:before{content:"\f10a"}.fa-tablet-alt:

theme-pofo/06-eg_posts/01_02-models-post.rb:
  32  
  33:   # == Scopes ===============================================================
  34  
  35:   scope :published, -> { where(published: true) }
  36  

ubuntudream/03-mockups/10_01-admin-student-list.html:
  905  									<tr>
  906: 										<th scope="col" class="border-0 rounded-start">Instructor name</th>
  907: 										<th scope="col" class="border-0">Join date</th>
  908: 										<th scope="col" class="border-0">Progress</th>
  909: 										<th scope="col" class="border-0">Courses</th>
  910: 										<th scope="col" class="border-0">Payments</th>
  911: 										<th scope="col" class="border-0 rounded-end">Action</th>
  912  									</tr>

ubuntudream/04-user-authentication/03_02-models-user.rb:
  16  
  17:   # == Scopes ===============================================================
  18  

ubuntudream/04-user-authentication/03_04-models-user.rb:
  16  
  17:   # == Scopes ===============================================================
  18  

ubuntudream/04-user-authentication/03_05-models-user.rb:
  16  
  17:   # == Scopes ===============================================================
  18  

ubuntudream/04-user-authentication/04_00-debug_devise_hotwire-it.md:
  79    #   manager.intercept_401 = false
  80:   #   manager.default_strategies(scope: :user).unshift :some_external_strategy
  81    # end

ubuntudream/04-user-authentication/04_01-config-initializers-devise.rb:
  263  
  264:   # ==> Scopes configuration
  265:   # Turn scoped views on. Before rendering "sessions/new", it will first check for
  266    # "users/sessions/new". It's turned off by default because it's slower if you
  267    # are using only default views.
  268:   # config.scoped_views = false
  269  
  270:   # Configure the default scope given to Warden. By default it's the first
  271    # devise role declared in your routes (usually :user).
  272:   # config.default_scope = :user
  273  
  274    # Set this configuration to false if you want /users/sign_out to sign out
  275:   # only the current scope. By default, Devise signs out all scopes.
  276:   # config.sign_out_all_scopes = true
  277  

  295    # up on your models and hooks.
  296:   # config.omniauth :github, 'APP_ID', 'APP_SECRET', scope: 'user,public_repo'
  297  

  303    #   manager.intercept_401 = false
  304:   #   manager.default_strategies(scope: :user).unshift :some_external_strategy
  305    # end

  320    # When using OmniAuth, Devise cannot automatically set OmniAuth path,
  321:   # so you need to do it manually. For the users scope, it would be:
  322    # config.omniauth_path_prefix = '/my_engine/users/auth'

ubuntudream/06-manage_users/02_00-users_protected-it.md:
  168    #   manager.intercept_401 = false
  169:   #   manager.default_strategies(scope: :user).unshift :some_external_strategy
  170    # end

  173    #   manager.intercept_401 = false
  174:   #   manager.default_strategies(scope: :user).unshift :some_external_strategy
  175    end

ubuntudream/06-manage_users/02_02-controllers-application_controller.rb:
  3  
  4:   def after_sign_in_path_for(resource_or_scope)
  5      current_user # goes to users/1 (if current_user = 1)

ubuntudream/06-manage_users/02_05-config-initializers-devise.rb:
  242  
  243:   # ==> Scopes configuration
  244:   # Turn scoped views on. Before rendering "sessions/new", it will first check for
  245    # "users/sessions/new". It's turned off by default because it's slower if you
  246    # are using only default views.
  247:   # config.scoped_views = false
  248  
  249:   # Configure the default scope given to Warden. By default it's the first
  250    # devise role declared in your routes (usually :user).
  251:   # config.default_scope = :user
  252  
  253    # Set this configuration to false if you want /users/sign_out to sign out
  254:   # only the current scope. By default, Devise signs out all scopes.
  255:   # config.sign_out_all_scopes = true
  256  

  273    # up on your models and hooks.
  274:   # config.omniauth :github, 'APP_ID', 'APP_SECRET', scope: 'user,public_repo'
  275  

  281    #   manager.intercept_401 = false
  282:   #   manager.default_strategies(scope: :user).unshift :some_external_strategy
  283    # end

  295    # When using OmniAuth, Devise cannot automatically set OmniAuth path,
  296:   # so you need to do it manually. For the users scope, it would be:
  297    # config.omniauth_path_prefix = '/my_engine/users/auth'

ubuntudream/06-manage_users/02_06-config-initializers-devise.rb:
  263  
  264:   # ==> Scopes configuration
  265:   # Turn scoped views on. Before rendering "sessions/new", it will first check for
  266    # "users/sessions/new". It's turned off by default because it's slower if you
  267    # are using only default views.
  268:   # config.scoped_views = false
  269  
  270:   # Configure the default scope given to Warden. By default it's the first
  271    # devise role declared in your routes (usually :user).
  272:   # config.default_scope = :user
  273  
  274    # Set this configuration to false if you want /users/sign_out to sign out
  275:   # only the current scope. By default, Devise signs out all scopes.
  276:   # config.sign_out_all_scopes = true
  277  

  295    # up on your models and hooks.
  296:   # config.omniauth :github, 'APP_ID', 'APP_SECRET', scope: 'user,public_repo'
  297  

  303    #   manager.intercept_401 = false
  304:   #   manager.default_strategies(scope: :user).unshift :some_external_strategy
  305    # end

  308    #   manager.intercept_401 = false
  309:   #   manager.default_strategies(scope: :user).unshift :some_external_strategy
  310    end

  322    # When using OmniAuth, Devise cannot automatically set OmniAuth path,
  323:   # so you need to do it manually. For the users scope, it would be:
  324    # config.omniauth_path_prefix = '/my_engine/users/auth'

ubuntudream/07_language_enum/04_03-models-user.rb:
  19  
  20:   # == Scopes ===============================================================
  21  

ubuntudream/07_language_enum/05_01-controllers-appllication_controller.rb:
  3  
  4:   #def after_sign_in_path_for(resource_or_scope)
  5    #  current_user # goes to users/1 (if current_user = 1)

ubuntudream/07_language_enum/05_05-controllers-appllication_controller.rb:
  4  
  5:   #def after_sign_in_path_for(resource_or_scope)
  6    #  current_user # goes to users/1 (if current_user = 1)

ubuntudream/09_cartoon_avatar_enum/01_03-models-user.rb:
  19  
  20:   # == Scopes ===============================================================
  21  

ubuntudream/13-pagination/01_02-controllers-application_controllerOLD.rb:
  8    
  9:   #def after_sign_in_path_for(resource_or_scope)
  10    #  current_user # goes to users/1 (if current_user = 1)

ubuntudream/14-authorization/02_00-authorization-pundit-it.md:
   96  > Nota: <br/>
   97: > Su pundit 2.1 il `generator` creava un file con dentro `class Scope` -> `def resolve` -> `scope.all`.
   98  

  100      def resolve
  101:       scope.all
  102      end

  104  
  105: > invece su pundit 2.2 abbiamo `class Scope` -> `def resolve` -> `raise NotImplementedError, "You must define #resolve in #{self.class}"`
  106  

ubuntudream/14-authorization/02_03-policies-application_policy.rb:
  38  
  39:   class Scope
  40:     def initialize(user, scope)
  41        @user = user
  42:       @scope = scope
  43      end

  50  
  51:     attr_reader :user, :scope
  52    end

ubuntudream/14-authorization/03_00-authorization-users-it.md:
  47  class UserPolicy < ApplicationPolicy
  48:   class Scope < Scope
  49      # NOTE: Be explicit about which records you allow access to!
  50      # def resolve
  51:     #   scope.all
  52      # end

  70    
  71:   class Scope < Scope
  72      # NOTE: Be explicit about which records you allow access to!
  73      # def resolve
  74:     #   scope.all
  75      # end

ubuntudream/14-authorization/03_01-policies-user_policy.rb:
  21  
  22:   class Scope < Scope
  23      # NOTE: Be explicit about which records you allow access to!
  24      # def resolve
  25:     #   scope.all
  26      # end

ubuntudream/15-lessons-steps/01_00-lessons_steps_seeds-it.md:
  216  
  217:   # == Scopes ===============================================================
  218  

  247  
  248:   # == Scopes ===============================================================
  249  

ubuntudream/15-lessons-steps/01_03-models-step.rb:
  14  
  15:   # == Scopes ===============================================================
  16  

ubuntudream/15-lessons-steps/01_04-models-lesson.rb:
  14  
  15:   # == Scopes ===============================================================
  16  

ubuntudream/15-lessons-steps/04_01-models-step.rb:
  14  
  15:   # == Scopes ===============================================================
  16  

ubuntudream/16-steps-answers/01_00-answers_seeds-it.md:
  148  
  149:   # == Scopes ===============================================================
  150  

ubuntudream/16-steps-answers/01_02-models-answer.rb:
  14  
  15:   # == Scopes ===============================================================
  16  

ubuntudream/16-steps-answers/01_03-models-step.rb:
  18  
  19:   # == Scopes ===============================================================
  20  

ubuntudream/16-steps-answers/02_00-users_answers-it.md:
  203  
  204:   scope :recent, -> { order(created_at: :desc).limit(25) }
  205  

ubuntudream/16-steps-answers/02_02-models-answer.rb:
  15  
  16:   # == Scopes ===============================================================
  17  

ubuntudream/16-steps-answers/02_03-models-user.rb:
  31  
  32:   # == Scopes ===============================================================
  33  

ubuntudream/18-style-lessons_steps/01_01-views-lessons-show.html.erb:
  98  								<p class="mb-3">In this practical hands-on training, you’re going to learn to become a digital marketing expert with this <strong> ultimate course bundle that includes 12 digital marketing courses in 1!</strong></p>
  99: 								<p class="mb-3">If you wish to find out the skills that should be covered in a basic digital marketing course syllabus in India or anywhere around the world, then reading this blog will help. Before we delve into the advanced <strong><a href="#" class="text-reset text-decoration-underline">digital marketing course</a></strong> syllabus, let’s look at the scope of digital marketing and what the future holds.</p>
  100  								<p class="mb-0">We focus a great deal on the understanding of behavioral psychology and influence triggers which are crucial for becoming a well rounded Digital Marketer. We understand that theory is important to build a solid foundation, we understand that theory alone isn’t going to get the job done so that’s why this course is packed with practical hands-on examples that you can follow step by step.</p>

ubuntudream/18-style-lessons_steps/51_01-models-lesson.rb:
  17  
  18:   # == Scopes ===============================================================
  19  

ubuntudream/18-style-lessons_steps/51_05-views-lessons-show.html.erb:
  103  								<p class="mb-3">In this practical hands-on training, you’re going to learn to become a digital marketing expert with this <strong> ultimate course bundle that includes 12 digital marketing courses in 1!</strong></p>
  104: 								<p class="mb-3">If you wish to find out the skills that should be covered in a basic digital marketing course syllabus in India or anywhere around the world, then reading this blog will help. Before we delve into the advanced <strong><a href="#" class="text-reset text-decoration-underline">digital marketing course</a></strong> syllabus, let’s look at the scope of digital marketing and what the future holds.</p>
  105  								<p class="mb-0">We focus a great deal on the understanding of behavioral psychology and influence triggers which are crucial for becoming a well rounded Digital Marketer. We understand that theory is important to build a solid foundation, we understand that theory alone isn’t going to get the job done so that’s why this course is packed with practical hands-on examples that you can follow step by step.</p>

ubuntudream/93-vote_for_best_story/01-act_as_votable-gem.txt:
  19  Allow any model to be voted on, like/dislike, upvote/downvote, etc.
  20: Allow any model to be voted under arbitrary scopes.
  21  Allow any model to vote. In other words, votes do not have to come from a user, they can come from any model (such as a Group or Team).
