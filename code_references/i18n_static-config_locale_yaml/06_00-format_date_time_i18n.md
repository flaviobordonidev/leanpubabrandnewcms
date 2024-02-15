# <a name="top"></a> Cap 2.5 - la formattazione delle date nelle varie lingue

Abbiamo aggiunto i due files `it` e `en` con le formattazioni già impostate. 
Adesso entriamo più in profondità nella formattazione delle **date**.



## Risorse interne

- [ubuntudream/04-i18n_static/04_00-default_format_i18n-mockups-test_a]()
- [code_references/ruby-data_types_and_i18n/02_00-date_time]()



## Apriamo il branch "Formats i18n"

Già aperto nel capitolo precedente.



## Usiamo le date del timestamp su mockups/page_a

Inseriamo alcune date su mockups/page_a.

> Ad esempio possiamo copiare i valori della colonna `created_at` o `updated_at` della tabella `users`.


***Codice 01 - .../app/views/mockups/page_a.html.erb - linea:27***

```html+erb
<p> data: Sat, 08 Oct 2022 23:30:28.257872000 UTC +00:00  </p>

```



Di seguito i parametri più usati di *.strftime()*.

Code | Description                                              | Esempio
--- | --------------------------------------------------------- | -----------------------------
%Y  | Anno con incluso il secolo, ossia almeno con 4 cifre.     | -0033, 0000, 1995, 2009, 14292, etc.
%y  | Anno senza il secolo, ossia con solo 2 cifre.             | 00..99
%C  | Secolo (Anno / 100 arrotondato per difetto).              | il secolo dell'anno 2017 è rappresentato con "20" 
--- |                                                           |
%m  | Mese, zero-padded (01..12).                               | gennaio è rappresentato con "01"
%-m | Mese, no-padded (1..12).                                  | gennaio è rappresentato con "1"
%_m | Mese, blank-padded ( 1..12).                              | gennaio è rappresentato con " 1"
%B  | Mese, con nome pieno.                                     | gennaio è rappresentato con "January"
%^B | Mese, con nome pieno in maiuscolo.                        | gennaio è rappresentato con "JANUARY"
%b  | Mese, con nome abbreviato.                                | gennaio è rappresentato con "Jan"
%^b | Mese, con nome abbreviato in maiuscolo.                   | gennaio è rappresentato con "JAN"
--- |                                                           |
%d  | Giorno del mese,   zero-padded (01..31).                  | il primo di gennaio è rappresentato con "01"
%-d | Giorno del mese,      no-padded (1..31).                  | il primo di gennaio è rappresentato con "1"
%e  | Giorno del mese,  blank-padded ( 1..31).                  | il primo di gennaio è rappresentato con " 1"
%j  | Giorno dell'anno (001..366)                               | il primo di febbraio è rappresentato con "32"
%A  | Giorno della settimana nome pieno.                        | domenica è rappresentata con "Sunday"
%^A | Giorno della settimana nome pieno in maiuscolo.           | domenica è rappresentata con "SUNDAY"
%a  | Giorno della settimana abbreviato.                        | domenica è rappresentata con "Sun"
%^a | Giorno della settimana abbreviato in maiuscolo.           | domenica è rappresentata con "SUN"
%u  | Giorno della settimana in numero (1..7) con Monday is 1.  | domenica è rappresentata con "7"
%w  | Giorno della settimana in numero (0..6) con Sunday is 0.  | domenica è rappresentata con "0"
--- |                                                           |
%H  | Hour of the day, 24-hour clock, zero-padded (00..23)      | le otto di sera sono    "20"
%k  | Hour of the day, 24-hour clock, blank-padded ( 0..23)     | le otto di mattina sono " 8"
%I  | Hour of the day, 12-hour clock, zero-padded (01..12)      | le otto di sera sono    "08"
%l  | Hour of the day, 12-hour clock, blank-padded ( 1..12)     | le otto di mattina sono " 8"
%P  | Meridian indicator, lowercase                             | "am" o "pm"
%p  | Meridian indicator, uppercase                             | "AM" o "PM"
--- |                                                           |
%M  | Minute of the hour (00..59)                               | ventitre minuti sono "23"
%S  | Second of the minute (00..59)                             | cinquantasei secondi sono "56"
%L  | Millisecond of the second (000..999)                      | cento millisecondi sono "100"

> Per una lista completa dei formati per il metodo *.strftime* visitiamo [APIDock](http://apidock.com/ruby/DateTime/strftime)



## Traduciamo la data

La data si presenta in inglese (prima il mese, poi i giorni, infine l'anno).
In questo paragrafo la traduciamo in italiano.
Per formattare in italiano la data possiamo usare le stesse variabili di *.strftime* all'interno del nostro locale *it.yml*.
Questo lo abbiamo già dal file scaricato nel capitolo precedente.

***codice n/a - .../config/locales/it.yml - line: 48***

```yaml
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
    day_names:
    - domenica
    - lunedì
    - martedì
    - mercoledì
    - giovedì
    - venerdì
    - sabato
    formats:
      default: "%d/%m/%Y"
      long: "%d %B %Y"
      short: "%d %b"
    month_names:
    - 
    - gennaio
    - febbraio
    - marzo
    - aprile
    - maggio
    - giugno
    - luglio
    - agosto
    - settembre
    - ottobre
    - novembre
    - dicembre
```

***codice n/a - ...continua - line: 263***

```yaml
  time:
    am: am
    formats:
      default: "%a %d %b %Y, %H:%M:%S %z"
      long: "%d %B %Y %H:%M"
      #long: "%A %d %^B %Y alle %H:%M e %S secondi"
      short: "%d %b %H:%M"
      #short: "giorno %d %^B %Y"
    pm: pm
```

Non ci resta che richiamare la formattazione con l'helper *l*.

***codice 04 - .../app/views/eg_posts/_eg_post.html.erb - line: 27***

```html+erb
<p>
  <strong>created_at:</strong>
  <br>
  <%= eg_post.created_at.strftime("day %d %^B %Y") %>
  <br>
  <%= l eg_post.created_at, format: :long %>
  <br>
  <%= l eg_post.created_at, format: :short %>
</p>

<p>
  <strong>updated_at:</strong>
  <br>
  <%= eg_post.updated_at.strftime("%A %d %^B %Y at %H:%M and %S seconds") %>
  <br>
  <%= l eg_post.created_at, format: :long %>
  <br>
  <%= l eg_post.created_at, format: :short %>
</p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/12-format_i18n/02_04-views-eg_posts-_eg_post.html.erb)




---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/12-format_i18n/01_00-overview_i18n-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/12-format_i18n/03_00-eg_posts_add_price-it.md)
