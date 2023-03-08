# <a name="top"></a> Cap 38-users-i18n_dynamic.3 - Internazionalizziamo gli utenti

Usiamo `mobility` per avere versioni in più lingue delle bio degli utenti.

> (questo si avvicina all'esempio dei superheroes nella "risorsa esterna")

Facciamo la traduzione in italiano, portoghese ed inglese (:it, :pt, :en)

- Attiviamo anche tutti i campi bio nelle tre lingue sulla stessa view (bio_it, bio_pt, bio_en)
- Attiviamo la traduzione differenziata della parte statica "locale" con la parte dinamica "mobility_locale"
- Attiviamo un fallback
- Attiviamo il search (con Ransack)



## Risorse interne

- []()



## Risorse esterne

- [Mobility Gem: How to store Rails translations inside a database](https://lokalise.com/blog/storing-rails-translations-in-database-with-mobility/)



## Apriamo il branch 

Continuiamo nel branch aperto nel capitolo precedente



## Usiamo mobility

Attiviamo l'internazionalizzazione sul database usando la gemma `mobility` installata precedentemente.
Indichiamo nel *model* i campi della tabella che vogliamo tradurre. 

Aggiorniamo il *model* nella sezione `# == Extensions`, sottosezione `## i18n dynamic`.

***Codice 01 - .../app/models/user.rb - linea:12***

```ruby
  ## i18n dynamic
  extend Mobility
  translates :bio, type: :string
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/24-dynamic-i18n/02_01-models-eg_post.rb)


> Se inseriamo il nome di una colonna già presente nella tabella quello che succede è che viene bypassata.
> Se c'erano già dei valori presenti quelli restano nella tabella ma non ci accedi da Rails perché Rails passa tramite `mobility` e mette i valori nelle tabelle create da `mobility`; la tabella per i valori tradotti di tipo :string ed una tabella per i valori tradotti di tipo :text.</br>
> Praticamente lo stesso comportamento di ActiveRecord per le immagini o ActiveText che usa Trix per testo formattato RTF (rich text file).

> Personalmente credo sia più utile rimuovere dalla tabella la colonna che inseriamo in `translates`.
> Anche perché possono esserci situazioni in cui si fa confusione. Ad esempio se facciamo uno scope di search nel model e questo va a leggere il valore nella tabella invece di usare `mobility` allora interroga eventuali vecchi dati presenti in tabella invece di quelli nuovi nella tabella di "mobility".</br>
> Mi è successo ^_^ con questo scope nel model `lesson.rb`:</br>
> `scope :search, -> (query) {where("name ILIKE ?", "%#{query.strip}%")}`</br>
> Prima di attivare mobility lavorava con i titoli dei quadri lasciati in inglese. Quando ho attivato la traduzione con mobility sembrava che continuasse a funzionare perché c'erano ancora i dati nella tabella vecchia e stava usando quelli. Infatti il comportamento era strano e mi sono accorto che usava i dati vecchi quando ho aggiunto una nuova lezione con un nuovo quadro che non riuscivo a trovare col "search".



## Eliminiamo il campo "bio" dalla tabella users

Quindi lasciamo il campo tradotto solo nella rispettiva tabella di mobility.
Nel nostro caso togliamo il campo "bio" dalla tabella "users".

```bash
$ rails g migration RemoveBioFieldFromUsers bio:string
```

***Codice 02 - .../db/migration/xxx_remove_bio_field_from_companies.rb - linea:01***

```ruby
remove_column :users, :bio, :string
```



## Popoliamo la tabella da console

Usiamo la console di rails per popolare la tabella del database.

```bash
$ rails c

> usr = User.first
> usr.bio
> usr.bio = "La bio scritta in italiano sulla tabella di mobility"
> I18n.locale
> I18n.locale = :en
> usr.bio = "The bio written in english on the mobility's table"
> usr.save

> usr.bio
> I18n.locale = :it
> usr.bio
> exit
```

> Quando chiamiamo il record con `User.first` ci presenta anche tutto il contenuto della tabella `usrs` e quindi vediamo che c'è il campo `bio` ed ha del testo all'interno.<br/>
> Quando chiediamo di leggere il contenuto del campo bio con `usr.bio` vediamo "nil" perché è intercettato da `mobility` e viene mostrato il contenuto nella tabella di `mobility`. Nel nostro caso inizialmente non c'è nulla.


Esempio:

```ruby
ubuntu@ubuntufla:~/ubuntudream (lng)$rails c
Loading development environment (Rails 7.0.4)
3.1.1 :001 > usr = User.first
  User Load (14.5ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1  [["LIMIT", 1]]
  Mobility::Backends::ActiveRecord::KeyValue::StringTranslation Load (4.5ms)  SELECT "mobility_string_translations".* FROM "mobility_string_translations" WHERE "mobility_string_translations"."translatable_id" = $1 AND "mobility_string_translations"."translatable_type" = $2 AND "mobility_string_translations"."key" = $3  [["translatable_id", 1], ["translatable_type", "User"], ["key", "bio"]]                                   
 => #<User id: 1, username: "Ann", first_name: "Anna", last_name: "Falchi", location: "milano", bio: "Una persona decisa c... 
3.1.1 :002 > usr.bio
 => nil 
3.1.1 :003 > usr.bio = "La bio scritta in italiano sulla tabella di mobility"
 => "La bio scritta in italiano sulla tabella di mobility" 
3.1.1 :004 > I18n.locale
 => :it 
3.1.1 :005 > I18n.locale = :en
 => :en 
3.1.1 :006 > usr.bio = "The bio written in english on the mobility's table"
 => "The bio written in english on the mobility's table" 
3.1.1 :007 > usr.save
  TRANSACTION (0.3ms)  BEGIN
  Mobility::Backends::ActiveRecord::KeyValue::StringTranslation Exists? (0.7ms)  SELECT 1 AS one FROM "mobility_string_translations" WHERE "mobility_string_translations"."key" = $1 AND "mobility_string_translations"."translatable_id" = $2 AND "mobility_string_translations"."translatable_type" = $3 AND "mobility_string_translations"."locale" = $4 LIMIT $5  [["key", "bio"], ["translatable_id", 1], ["translatable_type", "User"], ["locale", "it"], ["LIMIT", 1]]        
  Mobility::Backends::ActiveRecord::KeyValue::StringTranslation Exists? (0.4ms)  SELECT 1 AS one FROM "mobility_string_translations" WHERE "mobility_string_translations"."key" = $1 AND "mobility_string_translations"."translatable_id" = $2 AND "mobility_string_translations"."translatable_type" = $3 AND "mobility_string_translations"."locale" = $4 LIMIT $5  [["key", "bio"], ["translatable_id", 1], ["translatable_type", "User"], ["locale", "en"], ["LIMIT", 1]]        
  Mobility::Backends::ActiveRecord::KeyValue::StringTranslation Create (669.2ms)  INSERT INTO "mobility_string_translations" ("locale", "key", "value", "translatable_type", "translatable_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["locale", "it"], ["key", "bio"], ["value", "La bio scritta in italiano sulla tabella di mobility"], ["translatable_type", "User"], ["translatable_id", 1], ["created_at", "2023-02-07 11:11:21.722831"], ["updated_at", "2023-02-07 11:11:21.722831"]]                                                 
  Mobility::Backends::ActiveRecord::KeyValue::StringTranslation Create (0.6ms)  INSERT INTO "mobility_string_translations" ("locale", "key", "value", "translatable_type", "translatable_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["locale", "en"], ["key", "bio"], ["value", "The bio written in english on the mobility's table"], ["translatable_type", "User"], ["translatable_id", 1], ["created_at", "2023-02-07 11:11:22.435995"], ["updated_at", "2023-02-07 11:11:22.435995"]]
  User Update (5.3ms)  UPDATE "users" SET "updated_at" = $1 WHERE "users"."id" = $2  [["updated_at", "2023-02-07 11:11:22.437508"], ["id", 1]]
  TRANSACTION (7.8ms)  COMMIT
 => true 
3.1.1 :008 > usr.bio
 => "The bio written in english on the mobility's table" 
3.1.1 :009 > I18n.locale = :it
 => :it 
3.1.1 :010 > usr.bio
 => "La bio scritta in italiano sulla tabella di mobility" 
3.1.1 :011 > exit
ubuntu@ubuntufla:~/ubuntudream (lng)$
```

> Il primo record ha già un contenuto nella colonna "bio". Ma quando lo interroghiamo interviene `mobility` e ci da `nil` perché non trova traduzioni nelle tabelle che ha creato. Quando reinseriamo di nuovo la bio cambiando il locale per avere lingue diverse, se interroghiamo vediamo le descrizioni nelle varie lingue perché vanno a finire nella tabella creata da mobility.



## seed

Di seguito mostriamo come popolare la tabella in automatico ma noi eseguiremo la procedura manuale descritta nel prossimo capitolo.

***codice 04 - .../db/seeds.rb - line:1***

```ruby
puts "setting Users data with I18n :it :en :pt"
i18n.locale = :it
User.where(username: "Bob").update(bio: "Sono Bob e mi piacciono i cani").save
i18n.locale = :en
User.where(username: "Bob").update(bio: "Sono Bob e mi piacciono i cani").save
i18n.locale = :pt
User.where(username: "Bob").update(bio: "Eu sou Bob e gosto de cachorros").save
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/24-dynamic-i18n/02_02-db-migrate-xxx_create_eg_post_transaltions.rb)

> Abbiamo già creato 8 utenti quindi adesso assegniamo la bio in varie lingue ad ognuno di essi.

Se volessimo creare un nuovo utente faremmo:

***codice n/a - .../db/seeds.rb - line:n/a***

```ruby
puts "setting new User with data with I18n :it :en :pt"
i18n.locale = :it
User.new(bio: "Sono Bob e mi piacciono i cani").save
i18n.locale = :en
User.last.update(bio: "I'm Bob and I like dogs").save
i18n.locale = :pt
User.last.update(bio: "Eu sou Bob e gosto de cachorros").save
```


Per popolare il database con i seed si possono usare i comandi:

```bash
$ rake db:seed
o
$ rake db:setup
```

- il `rake db:seed` esegue nuovamente tutti i comandi del file *db/seeds.rb*. Quindi dobbiamo commentare tutti i comandi già eseguiti altrimenti si creano dei doppioni. Gli stessi comandi possono essere eseguiti manualmente sulla rails console e si lascia l'esecuzione del seed solo in fase di inizializzazione di tutto l'applicativo.
- il `rake db:setup` ricrea TUTTO il database e lo ripopola con *db/seeds.rb*. Quindi tutto il database è azzerato ed eventuali records presenti sono eliminati.



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

- http://192.168.64.3:3000/users?locale=en

Possiamo verificare la presenza delle traduzioni cambiando la lingua nella barra di navigazione in alto.
Se creiamo una bio in italiano possiamo mettere la versione inglese cambiando prima la lingua e poi creando la bio nella nuova lingua. Questo farà sì che quando siamo in inglese vediamo l'inglese e se torniamo all'italiano la rivediamo in italiano.


## Archiviamo su git

```bash
$ git add -A
$ git commit -m "add i18n users seeds"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku igg:main
$ heroku run rake db:migrate
```

I> Lato produzione su heroku c'è un database indipendente da quello di sviluppo quindi risulta vuoto.

per popolare il database di heroku basta aprire la console con il comando:

```bash
$ heroku run rails c
```

E rieseguire i passi già fatti nel paragrafo precedentemente




---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/17-pagination/01_00-gem-pagy-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/17-pagination/03_00-users_pagination-it.md)