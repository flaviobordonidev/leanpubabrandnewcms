



*** code 05 - .../db/seeds.rb - line:29 ***

```ruby
puts "setting the first Lesson data with I18n :en :it"
Lesson.new(name: "Paint View of mount Vermon", duration: 90, locale: :en).save
Lessson.last.update(name: "Paint View of mount Vermon", locale: :it)
```

> Non mi piace tradurre il campo *name* perché normalmente lo vedo associato ad un nome proprio, è come se traducessimo in inglese il nome "Giovanni Rossi" in "Jhon Reds".


*** code 05 - .../db/seeds.rb - line:29 ***

```ruby
puts "setting the Company data with I18n :en :it"
Company.new(name: "ABC srl", building: "Roma's office", sector: "Chemical", locale: :en).save
Company.last.update(building: "Ufficio di Roma", sector: "Chimico", locale: :it)

puts "setting the Company data with I18n :en :it"
Company.new(name: "ABC srl", building: "Roma's office", sector: "Chemical", locale: :en).save
Company.last.update(building: "Ufficio di Roma", sector: "Chimico", locale: :it)
```



## Popoliamo manualmente la tabella

Usiamo la console di rails per popolare manualmente la tabella del database di sviluppo (*development*).

```bash
$ sudo service postgresql start
$ rails c

> Lesson.new(name: "View of mount Vermon", duration: 90).save

> Lesson.new(name: "DEF srl", sector: "Pharmaceutical", locale: :en).save
> Company.last.update(sector: "Farmaceutico", locale: :it)

> Company.all
> c1 = Company.first
> c1.sector
> I18n.locale
> I18n.locale = :en
> c1.sector

> Company.new(name:"GHI SpA", sector:"Breweries").save
> c3 = Company.last
> c3.sector
> I18n.locale = :it
> c3.sector
> c3.sector = "Birrerie"
> c3.sector
> c3.save

> c2 = Company.find 2

> exit
```
