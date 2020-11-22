# Globalize

Risorse interne

* 01-base/29-dynamic-i18n/01-install_i18n_globalize




## OLD passages for RAIL5 5.2


Uno dei requisiti è che activerecord sia  >= 4.2.0 

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ bundle show activerecord

/usr/local/rvm/gems/ruby-2.3.0/gems/activerecord-5.0.0.1
~~~~~~~~

Al momento per installare su Rails 5 dobbiamo puntare sul loro branch master su github.

{title="Gemfile", lang=ruby, line-numbers=on, starting-line-number=54}
~~~~~~~~
# Internationalization (I18n) for ActiveRecord model/data translation.
gem 'globalize', git: 'https://github.com/globalize/globalize'
gem 'activemodel-serializers-xml'
~~~~~~~~

Installiamo

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ bundle install
~~~~~~~~



## Popoliamo da console

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo service postgresql start
$ rails c

> EgPost.all
> I18n.locale
> EgPost.find 1
> I18n.locale = :en
> EgPost.find 1
> EgPost.find(1).update(headline: "My first post", locale: :en)
> EgPost.find 1
> I18n.locale = :it
> EgPost.find 1




> SelectRelated.new(name: "favorites", metadata: "favorites", locale: :en).save
> SelectRelated.last.update(name: "favoriti", locale: :it)
 
> SelectRelated.new(name: "people", metadata: "people", bln_homepage: TRUE, bln_people: FALSE, bln_companies: TRUE, locale: :en).save
> SelectRelated.last.update(name: "persone", locale: :it)
 
> SelectRelated.new(name: "companies", metadata: "companies", bln_homepage: TRUE, bln_people: TRUE, bln_companies: FALSE, locale: :en).save
> SelectRelated.last.update(name: "aziende", locale: :it)
 

> EgPost.all
> exit
~~~~~~~~





## seed

Di seguito mostriamo come popolare la tabella in automatico ma noi eseguiremo la procedura manuale descritta nel prossimo capitolo.

{title=".../db/seeds.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "setting the Select_Relateds data with I18n :en :it"
SelectRelated.new(name: "favorites", metadata: "favorites", bln_homepage: TRUE, bln_people: TRUE, bln_companies: TRUE, locale: :en).save
SelectRelated.last.update(name: "favoriti", locale: :it)

SelectRelated.new(name: "people", metadata: "people", bln_homepage: TRUE, bln_people: FALSE, bln_companies: TRUE, locale: :en).save
SelectRelated.last.update(name: "persone", locale: :it)

SelectRelated.new(name: "companies", metadata: "companies", bln_homepage: TRUE, bln_people: TRUE, bln_companies: FALSE, locale: :en).save
SelectRelated.last.update(name: "aziende", locale: :it)

SelectRelated.new(name: "contacts", metadata: "contacts", bln_homepage: FALSE, bln_people: TRUE, bln_companies: TRUE, locale: :en).save
SelectRelated.last.update(name: "contatti", locale: :it)

SelectRelated.new(name: "addresses", metadata: "addresses", bln_homepage: FALSE, bln_people: TRUE, bln_companies: TRUE, locale: :en).save
SelectRelated.last.update(name: "indirizzi", locale: :it)
~~~~~~~~

Per popolare il database con i seed si possono usare i comandi:

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rake db:seed
o
$ rake db:setup
~~~~~~~~

* il "rake db:seed" esegue nuovamente tutti i comandi del file "db/seeds.rb". Quindi dobbiamo commentare tutti i comandi già eseguiti altrimenti si creano dei doppioni. Gli stessi comandi possono essere eseguiti manualmente sulla rails console e si lascia l'esecuzione del seed solo in fase di inizializzazione di tutto l'applicativo.
* il "rake db:setup" ricrea TUTTO il database e lo ripopola con "db/seeds.rb". Quindi tutto il database è azzerato ed eventuali records presenti sono eliminati.





## routes

aggiustiamo l'instradamento [(codice: 02)](#code-homepage-select_realateds_seeds-02) nel file routes

{title="config/routes.rb", lang=ruby, line-numbers=on, starting-line-number=8}
~~~~~~~~
  resources :select_relateds, only: [:index]
~~~~~~~~

I se voglilamo verificare che funziona tutto da browser dobbiamo togliere dalla pagina index i links alle altre pagine perché abbiamo attivato l'instradamento per la sola pagina index. Altrimenti ci da errore.

{title=".../app/views/select_relateds/index.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
~~~~~~~~
<p id="notice"><%= notice %></p>

<h1>Select Relateds</h1>

<table>
  <thead>
    <tr>
      <th>Name</th>
      <th>Metadata</th>
      <th>Bln homepage</th>
      <th>Bln people</th>
      <th>Bln companies</th>
    </tr>
  </thead>

  <tbody>
    <% @select_relateds.each do |select_related| %>
      <tr>
        <td><%= select_related.name %></td>
        <td><%= select_related.metadata %></td>
        <td><%= select_related.bln_homepage %></td>
        <td><%= select_related.bln_people %></td>
        <td><%= select_related.bln_companies %></td>
      </tr>
    <% end %>
  </tbody>
</table>
~~~~~~~~

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo service postgresql start
$ rails s -b $IP -p $PORT
https://elisinfo6-flaviobordonidev.c9users.io/select_relateds
https://elisinfo6-flaviobordonidev.c9users.io/select_relateds?locale=en
~~~~~~~~


{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git add -A
$ git commit -m "add scaffold select_related and populate"
~~~~~~~~

