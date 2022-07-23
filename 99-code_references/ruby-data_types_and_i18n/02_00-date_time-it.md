# <a name="top"></a> Cap ruby_data_types_and_i18n.2 - Gestire la data e l'ora in Rails



## Risorse interne

- 01-base/12-format_i18n/01-format_date_time_i18n
- 03-cms_pofo/06-dynamic/01-posts_show_with_pofo



## Risorse web

- [Gestiamo le timezones](http://rpanachi.com/2016/07/04/ruby-is-time-to-talk-about-timezones)
- [DateTime.now vs DateTime.current](https://jcxia.com/blog/A-DateTime-bug)
- [spiegazione varia](https://viblo.asia/p/date-time-datetime-trong-ruby-and-rails-bJzKm0x659N)




## La formattazione della data

Per una formattazione rapida possiamo usare

```ruby
Model.created_at.strftime("%FT%T")
```

%F - The ISO 8601 date format (%Y-%m-%d)
%T - 24-hour time (%H:%M:%S)

Per una formattazione più dettagliata abbiamo più parametri da poter usare. Ad esempio per avere "pubblicato il 17 AGOSTO 2019" possiamo usare 

```ruby
@post.published_at.strftime("pubblicato il %d %^B %Y")
```

ossia la variabile "@post.published_at" formattata con ".strftime("%d %^B %Y")" di cui questi sono i parametri più usati:

- %Y - Anno con incluso il secolo, ossia almeno con 4 cifre. Può essere anche negativo. Es: -0001, 0000, 1995, 2009, 14292, etc.
- %y - Anno senza il secolo, ossia con solo 2 cifre. Es: 00..99
- %C - Secolo (Anno / 100 arrotondato per difetto). Es: il secolo dell'anno 2019 è rappresentato con "20" 

- %m  - Mese,  zero-padded (01..12).            Es: gennaio è rappresentato con "01"
- %-m - Mese,     no-padded (1..12).            Es: gennaio è rappresentato con "1"
- %_m - Mese, blank-padded ( 1..12).            Es: gennaio è rappresentato con " 1"
- %B  - Mese, con nome pieno.                   Es: gennaio è rappresentato con "January"
- %^B - Mese, con nome pieno in maiuscolo.      Es: gennaio è rappresentato con "JANUARY"
- %b  - Mese, con nome abbreviato.              Es: gennaio è rappresentato con "Jan"
- %^b - Mese, con nome abbreviato in maiuscolo. Es: gennaio è rappresentato con "JAN"

- %d  - Giorno del mese,   zero-padded (01..31). Es: il primo di gennaio è rappresentato con "01"
- %-d - Giorno del mese,      no-padded (1..31). Es: il primo di gennaio è rappresentato con "1"
- %e  - Giorno del mese,  blank-padded ( 1..31). Es: il primo di gennaio è rappresentato con " 1"
- %j  - Giorno dell'anno (001..366)
- %A  - Giorno della settimana nome pieno.                        Es: domenica è rappresentata con "Sunday"
- %^A - Giorno della settimana nome pieno in maiuscolo.           Es: domenica è rappresentata con "SUNDAY"
- %a  - Giorno della settimana abbreviato.                        Es: domenica è rappresentata con "Sun"
- %^a - Giorno della settimana abbreviato in maiuscolo.           Es: domenica è rappresentata con "SUN"
- %u  - Giorno della settimana in numero (1..7) con Monday is 1.  Es: domenica è rappresentata con "7"
- %w  - Giorno della settimana in numero (0..6) con Sunday is 0.  Es: domenica è rappresentata con "0"

- %H - Hour of the day, 24-hour clock, zero-padded (00..23)
- %k - Hour of the day, 24-hour clock, blank-padded ( 0..23)
- %I - Hour of the day, 12-hour clock, zero-padded (01..12)
- %l - Hour of the day, 12-hour clock, blank-padded ( 1..12)
- %P - Meridian indicator, lowercase (``am'' or ``pm'')
- %p - Meridian indicator, uppercase (``AM'' or ``PM'')

- %M - Minute of the hour (00..59)

- %S - Second of the minute (00..59)

- %L - Millisecond of the second (000..999)

Per una lista completa dei formati per il metodo "strftime" visitare [APIDock](http://apidock.com/ruby/DateTime/strftime)




## DateTime.now vs DateTime.current

In short, always use "DateTime.current" in your Rails application.

```ruby
DateTime.current
```

The issue:
One of our back-end test failed in the CI pipeline today. Which looks really weird since nobody touches that related code for a while so it’s probably not a regression.
After digging into the issue and we finally found the root cause: DateTime.now returns a DateTime object with system timezone instead of the timezone set in Rails application. This isn’t a big deal in most cases but can really cause troubles when you are calculating certain time. In our case, we were adding 2.years to the time and it happens that it could be 2020-02-29 instead of 2020-03-01 in different timezone (Leap year! Surprise! And this happens once every four years!).
Rails has already solved the above issue by patching a DateTime.current method. This method returns the current time with the correct timezone set in Rails.




## ruby-is-time-to-talk-about-timezones

The Rails way
If you are using Ruby on Rails, you don’t need to concern with all this time and time zone related issues. You just need to remember this:

Always configure your application time zone on config/application.rb:

```ruby
config.time_zone = 'Brasilia'
```


Always get the current time via current method:

```ruby
Time.current
=> Sun, 03 Jul 2016 22:46:35 BRT -03:00
```


Always parse time using the configured time zone:

```ruby
Time.zone.parse("2016-07-03 22:33:45")
=> Sun, 03 Jul 2016 22:33:45 BRT -03:00
```

Con Time.zone.parse il timestampt archivia sul database in UTC.


And if you are using a database with time zone supports, instead of the classic t.timestamps, do this on database migrations:

```ruby
create_table :posts do |t|
  # columns definition
end
add_column :posts, :created_at, :timestamptz
add_column :posts, :updated_at, :timestamptz
```

> quest'ultimo consiglio è eccessivo. Con Time.zone.parse il timestampt archivia sul database in UTC e va benissimo.
