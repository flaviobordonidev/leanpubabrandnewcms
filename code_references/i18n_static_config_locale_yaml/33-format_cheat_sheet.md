# <a name="top"></a> Cap i18n_static_config_locale_yaml.3 - Format cheat sheet



## Risorse esterne

- [articolo](https://devhints.io/rails-i18n)
- [](http://guides.rubyonrails.org/i18n.html)
- [](http://rails-i18n.org/wiki)
- [](https://github.com/svenfuchs/i18n)
- [](https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/en.yml)




##

***codice 01 - .../config/locle/it.yml - line: 1***

```r
t('my.messages.hello')

# same as 'my.messages.hello'
t(:hello, scope: 'my.messages')
t(:hello, scope: [:my, :messages])

t('my.messages.hello', default: "Hello")
```


```yml
en:
  my:
    messages:
      hello: "Hello"

```

Interpolation

```
t('hello', name: "John")
hello: "Hello %{name}"
Lazy lookup
# from the 'books/index' view
t('.title')
```

```yml
en:
  books:
    index:
      title: "Título"
Plural
t(:inbox, count: 1)  #=> 'one message'
t(:inbox, count: 2)  #=> '2 messages'
inbox:
  one: 'one message',
  other: '%{count} messages'
Localizing
Time
l(Time.now)
l(Time.now, format: :short)
en:
  time:
    formats:
      default: "%a, %d %b %Y %H:%M:%S %z"
      long: "%B %d, %Y %H:%M"
      short: "%d %b %H:%M"
Date
l(Date.today)
en:
  date:
    formats:
      default: "%Y-%m-%d" # 2015-06-25
      long: "%B %d, %Y"   # June 25, 2015
      short: "%b %d"      # Jun 25
ActiveRecord
Model names
User.model_name.human            #=> "User"
Child.model_name.human(count: 2) #=> "Children"
en:
  activerecord:
    models:
      user: "User"
      child:
        one: "Child"
        other: "Children"
Attributes
User.human_attribute_for :name   #=> "Name"
en:
  activerecord:
    attributes:
      user:
        # activerecord.attributes.<model>.<field>
        name: "Name"
        email: "Email"
Error messages
error_messages_for(...)
activerecord:
  errors:
    models:
      venue:
        attributes:
          name:
            blank: "Please enter a name."
Possible scopes (in order):

activerecord.errors.models.[model_name].attributes.[attribute_name].[error]
activerecord.errors.models.[model_name].[error]
activerecord.errors.messages.[error]
errors.attributes.[attribute_name].[error]
errors.messages.[error]
Where [error] can be:

validates
  confirmation - :confirmation
  acceptance   - :accepted
  presence     - :blank
  length       - :too_short (%{count})
  length       - :too_long (%{count})
  length       - :wrong_length (%{count})
  uniqueness   - :taken
  format       - :invalid
  numericality - :not_a_number
Form labels
form_for @post do
  f.label :body
helpers:
  # helpers.label.<model>.<field>
  label:
    post:
      body: "Your body text"
Submit buttons
form_for @post do
  f.submit
helpers:
  submit:
    # helpers.submit.<action>
    create: "Create a %{model}"
    update: "Confirm changes to %{model}"

    # helpers.submit.<model>.<action>
    article:
      create: "Publish article"
      update: "Update article"
Numbers
number_to_delimited(2000)             #=> "2,000"
number_to_currency(12.3)              #=> "$12.30"
number_to_percentage(0.3)             #=> "30%"
number_to_rounded(3.14, precision: 0) #=> "3"
number_to_human(12_000)               #=> "12 Thousand"
number_to_human_size(12345)           #=> "12.3 kb"
Delimited
number_to_delimited(n)
number:
  format:
    separator: '.'
    delimiter: ','
    precision: 3
    significant: false
    strip_insignificant_zeroes: false
Currencies
number_to_currency(n)
number:
  currency:
    format:
      format: "%u%n" # %u = unit, %n = number
      unit: "$"
      separator: '.'
      delimiter: ','
      precision: 3
      # (see number.format)
Percentage
number_to_percentage(n)
number:
  percentage:
    format:
      format: "%n%"
      # (see number.format)
```

Programmatic access


```ruby
I18n.backend.store_translations :en, ok: "Ok"
I18n.locale = :en
I18n.default_locale = :en

I18n.available_locales

I18n.translate :ok   # aka, I18n.t
I18n.localize date   # aka, I18n.l

```
