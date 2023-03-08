# <a name="top"></a> Cap 15b.2 - Internazionalizziamo le lezioni

Attiviamo l'internazionalizzazione (I18n) dinamica per le lezioni.
In pratica il titolo, la descrizione e poco altro.

> Abbiamo già attivato la gemma `mobility` nel capitolo *09-users-i18n_dynamic*.



## Risorse interne

- [ubuntudream/09-users-i18n_dynamic/03_00-i18n_user-it]()



## Apriamo il branch



## Usiamo mobility

Attiviamo l'internazionalizzazione sul database usando la gemma `mobility` installata precedentemente.
Indichiamo nel *model* i campi della tabella che vogliamo tradurre. 

Aggiorniamo il *model* nella sezione `# == Extensions`, sottosezione `## i18n dynamic`.

***Codice 01 - .../app/models/lesson.rb - linea:01***

```ruby
  extend Mobility
  translates :name, type: :string
  #translates :description, type: :text
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/24-dynamic-i18n/02_01-models-eg_post.rb)




## Attiviamo anche la parte text

Per la descrizione della lezione non usiamo il campo del database *description* perché al suo posto usiamo il campo Active_text che abbiamo dichiarato nel model nella sezione `# == Attributes`, sottosezione `## ActiveText`.

***Codice 01 - ...continua - linea:01***

```ruby
  has_rich_text :description_rtf
```

Se attiviamo `translates :description, type: :text` non funziona perché prende il controllo `has_rich_text :description_rtf`. Dobbiamo quindi commentarlo.

***Codice 02 - .../app/models/lesson.rb - linea:01***

```ruby
  extend Mobility
  translates :name, type: :string
  translates :description_rtf, type: :text
```

***Codice 02 - ...continua - linea:01***

```ruby
  #has_rich_text :description_rtf
```

Questa impostazione funziona ma quando andiamo a visualizzare su lessons/show vediamo il testo plain con i tags html visualizzati al posto della formattazione. Per visualizzare il testo in html in maniera sicura possiamo usare il comando `sanitize`.

***Codice 03 - ..../app/views/lessons/show.html.erb - linea:158***

```html+erb
								<%= sanitize @lesson.description_rtf %>
```

funziona ma non è perfetto. ad esempio non formatta il <blockquote>.
L'autore della gemma `mobility` consiglia come soluzione di usare la gemma `mobility-actiontext` che installiamo nel prossimo capitolo.
