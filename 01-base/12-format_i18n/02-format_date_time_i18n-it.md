# <a name="top"></a> Cap 12.1 - la formattazione delle date nelle varie lingue

Abbiamo aggiunto i due files *it* e *en* con le formattazioni già impostate. 
Adesso entriamo più in profondità nella formattazione delle **date**.



## Risorse interne

- 99-rails_references/data_types/date-time
- 99-rails_references/i18n/02-format_date_time_i18n



## Apriamo il branch "Formats i18n"

Già aperto nel capitolo precedente.



## Visualizziamo il campo ultimo aggiornamento degli articoli

Di default il codice *t.timestamps* nei migrations crea le due colonne *created_at* e *updated_at* come possiamo vedere nello schema del database.

***codice 01 - .../db/schema.rb - line: 54***

```ruby
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/12-format_i18n/02_01-db-schema.rb)

Possiamo usare quelli di *eg_posts* nelle pagine *show* e *index* per visualizzare la data di creazione e quella dell'ultimo aggiornamento.

***codice 02 - .../app/views/eg_posts/_eg_post.html.erb - line: 3***

```html+erb
<p>
  <strong>created_at:</strong>
  <%= eg_post.created_at %>
</p>

<p>
  <strong>updated_at:</strong>
  <%= eg_post.updated_at %>
</p>
```



## Formattiamo la data

Diamo un formato alla data con il metodo *.strftime*. 
Per la *data di creazione* visualizziamo solo il giorno il mese e l'anno.
Invece per la *data dell'ultimo aggiornamento* visualizziamo anche ore e minuti.

***codice 03 - .../app/views/eg_posts/show.html.erb - line: 12***

```html+erb
<p>
  <strong>created_at:</strong>
  <%= eg_post.created_at.strftime("day %d %^B %Y") %>
</p>

<p>
  <strong>updated_at:</strong>
  <%= eg_post.updated_at.strftime("%A %d %^B %Y at %H:%M and %S seconds") %>
</p>
```

Di seguito i parametri più usati di *.strftime*.

Code | Description                                              | Esempio
--- | --------------------------------------------------------- | -----------------------------
%Y  | Anno con incluso il secolo, ossia almeno con 4 cifre. Può essere anche negativo. | Es: -0001, 0000, 1995, 2009, 14292, etc.
%y  | Anno senza il secolo, ossia con solo 2 cifre. | Es: 00..99
%C  | Secolo (Anno / 100 arrotondato per difetto).  | Es: il secolo dell'anno 2019 è rappresentato con "20" 
--- 
%m  | Mese, zero-padded (01..12).             | Es: gennaio è rappresentato con "01"
%-m | Mese, no-padded (1..12).                | Es: gennaio è rappresentato con "1"
%_m | Mese, blank-padded ( 1..12).            | Es: gennaio è rappresentato con " 1"
%B  | Mese, con nome pieno.                   | Es: gennaio è rappresentato con "January"
%^B | Mese, con nome pieno in maiuscolo.      | Es: gennaio è rappresentato con "JANUARY"
%b  | Mese, con nome abbreviato.              | Es: gennaio è rappresentato con "Jan"
%^b | Mese, con nome abbreviato in maiuscolo. | Es: gennaio è rappresentato con "JAN"
--- | 
%d  | Giorno del mese,   zero-padded (01..31). Es: il primo di gennaio è rappresentato con "01"
%-d | Giorno del mese,      no-padded (1..31). Es: il primo di gennaio è rappresentato con "1"
%e  | Giorno del mese,  blank-padded ( 1..31). Es: il primo di gennaio è rappresentato con " 1"
%j  | Giorno dell'anno (001..366)
%A  | Giorno della settimana nome pieno.                        Es: domenica è rappresentata con "Sunday"
%^A | Giorno della settimana nome pieno in maiuscolo.           Es: domenica è rappresentata con "SUNDAY"
%a  | Giorno della settimana abbreviato.                        Es: domenica è rappresentata con "Sun"
%^a | Giorno della settimana abbreviato in maiuscolo.           Es: domenica è rappresentata con "SUN"
%u  | Giorno della settimana in numero (1..7) con Monday is 1.  Es: domenica è rappresentata con "7"
%w  | Giorno della settimana in numero (0..6) con Sunday is 0.  Es: domenica è rappresentata con "0"
--- |
%H  | Hour of the day, 24-hour clock, zero-padded (00..23)
%k  | Hour of the day, 24-hour clock, blank-padded ( 0..23)
%I  | Hour of the day, 12-hour clock, zero-padded (01..12)
%l  | Hour of the day, 12-hour clock, blank-padded ( 1..12)
%P  | Meridian indicator, lowercase ('am' or 'pm')
%p  | Meridian indicator, uppercase ('AM' or 'PM')
--- |
%M  | Minute of the hour (00..59)
%S  | Second of the minute (00..59)
%L  | Millisecond of the second (000..999)




Per una lista completa dei formati per il metodo *.strftime* visitiamo [APIDock](http://apidock.com/ruby/DateTime/strftime)



## Traduciamo la data

La data si presenta in inglese (nomi dei mesi, nomi dei giorni della settimana, ...) ed in questo paragrafo la traduciamo in italiano.
Per formattare in italiano la data possiamo usare le stesse variabili di ".strftime" all'interno del nostro locale (it.yml).
C'è chi ha già fatto questo lavoro quindi prendiamo la traduzione da https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/it.yml

***codice 04 - .../config/locales/it.yml - line: 4***

```yaml
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

***codice 05 - .../app/views/eg_posts/show.html.erb - line: 12***

```html+erb
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

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

- https://mycloud9path.amazonaws.com/eg_posts



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "I18n date fields created_at updated_at on eg_posts"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku btep:main
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge btep
$ git branch -d btep
```



## Facciamo un backup su Github

```bash
$ git push origin master
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
