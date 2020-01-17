{id: 01-base-12-format_i18n-01-format_date_time_i18n}
# Cap 12.1 -- Formattiamo le date nelle varie lingue

Di default il comando di formattazione della data prende i nomi in inglese. Vediamo come implementare l'Italiano.


Risorse interne:

* 99-rails_references/data_types/date-time
* 99-rails_references/i18n/02-format_date_time_i18n




## Visualizziamo il campo ultimo aggiornamento degli articoli

di default la voce "t.timestamps" nei migrations crea le due colonne "created_at" e "updated_at" come possiamo vedere nello schema del database.

{id: "01-12-01_01", caption: ".../db/schema.rb -- codice 01", format: ruby, line-numbers: true, number-from: 54}
```
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
```

Possiamo usarli nella pagina show per visualizzare la data di creazione e quella dell'ultimo aggiornamento.

{id: "01-12-01_02", caption: ".../app/views/eg_posts/show.html.erb -- codice 02", format: HTML+Mako, line-numbers: true, number-from: 3}
```
<p>
  <strong>created_at:</strong>
  <%= @eg_post.created_at %>
</p>

<p>
  <strong>updated_at:</strong>
  <%= @eg_post.updated_at %>
</p>
```




## Formattiamo la data

Diamo un formato alla data con il metodo ".strftime". Per la creazione indichiamo il giorno il mese e l'anno, invece per l'ultimo aggiornamento usiamo più indicazioni:

{id: "01-12-01_02", caption: ".../app/views/eg_posts/show.html.erb -- codice 03", format: HTML+Mako, line-numbers: true, number-from: 12}
```
<p>
  <strong>created_at:</strong>
  <%= @eg_post.created_at.strftime("day %d %^B %Y") %>
</p>

<p>
  <strong>updated_at:</strong>
  <%= @eg_post.updated_at.strftime("%A %d %^B %Y at %H:%M and %S seconds") %>
</p>
```

questi sono i parametri più usati di ".strftime":

* %Y - Anno con incluso il secolo, ossia almeno con 4 cifre. Può essere anche negativo. Es: -0001, 0000, 1995, 2009, 14292, etc.
* %y - Anno senza il secolo, ossia con solo 2 cifre. Es: 00..99
* %C - Secolo (Anno / 100 arrotondato per difetto). Es: il secolo dell'anno 2019 è rappresentato con "20" 

* %m  - Mese,  zero-padded (01..12).            Es: gennaio è rappresentato con "01"
* %-m - Mese,     no-padded (1..12).            Es: gennaio è rappresentato con "1"
* %_m - Mese, blank-padded ( 1..12).            Es: gennaio è rappresentato con " 1"
* %B  - Mese, con nome pieno.                   Es: gennaio è rappresentato con "January"
* %^B - Mese, con nome pieno in maiuscolo.      Es: gennaio è rappresentato con "JANUARY"
* %b  - Mese, con nome abbreviato.              Es: gennaio è rappresentato con "Jan"
* %^b - Mese, con nome abbreviato in maiuscolo. Es: gennaio è rappresentato con "JAN"

* %d  - Giorno del mese,   zero-padded (01..31). Es: il primo di gennaio è rappresentato con "01"
* %-d - Giorno del mese,      no-padded (1..31). Es: il primo di gennaio è rappresentato con "1"
* %e  - Giorno del mese,  blank-padded ( 1..31). Es: il primo di gennaio è rappresentato con " 1"
* %j  - Giorno dell'anno (001..366)
* %A  - Giorno della settimana nome pieno.                        Es: domenica è rappresentata con "Sunday"
* %^A - Giorno della settimana nome pieno in maiuscolo.           Es: domenica è rappresentata con "SUNDAY"
* %a  - Giorno della settimana abbreviato.                        Es: domenica è rappresentata con "Sun"
* %^a - Giorno della settimana abbreviato in maiuscolo.           Es: domenica è rappresentata con "SUN"
* %u  - Giorno della settimana in numero (1..7) con Monday is 1.  Es: domenica è rappresentata con "7"
* %w  - Giorno della settimana in numero (0..6) con Sunday is 0.  Es: domenica è rappresentata con "0"

* %H - Hour of the day, 24-hour clock, zero-padded (00..23)
* %k - Hour of the day, 24-hour clock, blank-padded ( 0..23)
* %I - Hour of the day, 12-hour clock, zero-padded (01..12)
* %l - Hour of the day, 12-hour clock, blank-padded ( 1..12)
* %P - Meridian indicator, lowercase (``am'' or ``pm'')
* %p - Meridian indicator, uppercase (``AM'' or ``PM'')

* %M - Minute of the hour (00..59)

* %S - Second of the minute (00..59)

* %L - Millisecond of the second (000..999)

Per una lista completa dei formati per il metodo ".strftime" visitiamo [APIDock](http://apidock.com/ruby/DateTime/strftime)




## Traduciamo la data

La data si presenta in inglese (nomi dei mesi, nomi dei giorni della settimana, ...) ed in questo paragrafo la traduciamo in italiano.
Per formattare in italiano la data possiamo usare le stesse variabili di ".strftime" all'interno del nostro locale (it.yml).
C'è chi ha già fatto questo lavoro quindi prendiamo la traduzione da https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/it.yml

{id: "01-12-01_04", caption: ".../config/locales/it.yml -- codice 04", format: yaml, line-numbers: true, number-from: 4}
```
  time:
    formats:
      short: "giorno %d %^B %Y"
      long: "%A %d %^B %Y alle %H:%M e %S secondi"

  date:
    abbr_day_names:
    - dom
    - lun
    - mar
    - mer
    - gio
    - ven
    - sab
    abbr_month_names:
    - 
    - gen
    - feb
    - mar
    - apr
    - mag
    - giu
    - lug
    - ago
    - set
    - ott
    - nov
    - dic
```

[tutto il codice](#01-12-01_04all)


e richiamiamo la formattazione con l'helper "l"

{id: "01-12-01_05", caption: ".../app/views/eg_posts/show.html.erb -- codice 05", format: HTML+Mako, line-numbers: true, number-from: 12}
```

<p>
  <strong>created_at:</strong>
  <br>
  <%= @eg_post.created_at.strftime("The day %d %^B %Y") %>
  <br>
  <%= l @eg_post.created_at, format: :short %>
</p>

<p>
  <strong>updated_at:</strong>
  <br>
  <%= @eg_post.updated_at.strftime("%A %d %^B %Y at %H:%M and %S seconds") %>
  <br>
  <%= l @eg_post.created_at, format: :long %>
</p>
```

[tutto il codice](#01-12-01_05all)




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/eg_posts




## salviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "I18n date fields created_at updated_at on eg_posts"
```




## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku btep:master
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge btep
$ git branch -d btep
```




# Aggiorniamo github

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




## Il codice del capitolo




[Codice 01](#01-08b-01_01)

{id="01-08b-01_01all", title=".../app/views/layouts/application.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
```

```
