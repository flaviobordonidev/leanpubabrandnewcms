# <a name="top"></a> Cap 1.2 - Mockups page_a

Abbiamo già creato il controller e le views `mockups`. In questo paragrafo aggiungiamo dei valori di data e di valuta e dei menu a cascata in modo da avere una copertura di quasi tutte le situazioni che possiamo trovare nella nostra applicazione ed avere una "base dati" su cui lavorare.

> Questo ci sarà molto utile già nella prossima sezione in cui implementeremo la traduzione statica *i18n*.

> Per la traduzione statica non abbiamo bisogno di valori presi dal database. Possiamo usare dei valori direttamente inseriti a mano.



## Risorse interne

- []()



## Risorse esterne

- [Rails Internationalization (I18n) API](https://guides.rubyonrails.org/i18n.html)
- [Rails I18n, check if translation exists?](https://stackoverflow.com/questions/12353416/rails-i18n-check-if-translation-exists/12353485#12353485)

```ruby
I18n.t("some_translation.key", :default => "fallback text")
```



## page_a

***Codice n/a - .../app/views/mockups/page_a.html.erb - linea:n/a***

```html+erb
<p> testo = "Sono Flavio, quando avevo 5 anni camminavo per la spiaggia"
<p> Data = 01/01/1975 </p>
<p> Soldi = 123456789,12345
<p> Soldi = 499999999,99999 <p>
<p> Soldi (come li direbbe una persona) = 499999999,99999 </p>
```

Vediamo dove stiamo con page_a

***Codice 01 - .../app/views/mockups/page_a.html.erb - linea:39***

```html+erb
<h1>Hello world</h1>
<p>Welcome to this application made by Flavio. ^_^</p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/02_01-views-mockups-page_a.html.erb)


questa view si appoggia al *layout basic* che è praticamente il *layout application* subito dopo la creazione della nuova applicazione Rails, con un minimo di aggiunte.

***Codice 02 - .../app/views/layouts/basic.html.erb - linea:01***

```html+erb
<!DOCTYPE html>
<html>
  <head>
    <title>Ubuntudream</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/02_02-views-layouts-basic.html.erb)


verifichiamo nel controller *mockups* che effettivamente è chiamato il *layout basic*.

***Codice 03 - .../app/controllers/mockups_controller.rb - linea:02***

```ruby
  def page_a
    render layout: 'basic'
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/02_03-controllers-mockups_controller.rb)

