# <a name="top"></a> Cap 1.2 - Aggiungiamo informazioni statiche a Mockups test_a

Inseriamo alcune informazioni nella pagina views `mockups/test_a.html.erb` che traduremo nei prossimi paragrafi.
Al momento, per semplicità, le informazioni che inseriamo non le prendiamo dinamicamente dal database ma le scriviamo staticamente nel codice.
Aggiungeremo informazioni dei seguenti tipi/formati:

- data 
- valuta (prezzi in € e $)
- menu a cascata 



## Risorse interne

- []()



## Risorse esterne

- [Rails Internationalization (I18n) API](https://guides.rubyonrails.org/i18n.html)
- [Rails I18n, check if translation exists?](https://stackoverflow.com/questions/12353416/rails-i18n-check-if-translation-exists/12353485#12353485)


##



## Inseriamo links per cambiare `params[:locale]`

Aggiungiamo due links per cambiare la lingua assegnando il relativo valore a `params[:locale]`.

***Codice 04 - .../app/views/mockups/page_a.html.erb - linea:06***

```html+erb
  <%= link_to "Inglese", params.permit(:locale).merge(locale: 'en') %> |
  <%= link_to "Italiano", params.permit(:locale).merge(locale: 'it') %> 
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-internationalization_i18n/03_04-views-mockups-page_a.html.erb)


Per la didattica: Uno switch semplice che ci riporta sempre alla pagina principale: </br>

***Codice n/a - .../app/views/mockups/page_a.html.erb - linea:06***

```html+erb
<ul>
  <li><%= link_to "english", root_paht(locale: :en) %></li>
  <li><%= link_to "italiano", root_paht(locale: :it) %></li>
</ul>
```



## page_a

*** Codice n/a - .../app/views/mockups/page_a.html.erb - linea:n/a ***

```r
<p> testo = "Sono Flavio, quando avevo 5 anni camminavo per la spiaggia"
<p> Data = 01/01/1975 </p>
<p> Soldi = 123456789,12345
<p> Soldi = 499999999,99999 <p>
<p> Soldi (come li direbbe una persona) = 499999999,99999 </p>
```

Vediamo dove stiamo con page_a

*** Codice 01 - .../app/views/mockups/page_a.html.erb - linea: 39 ***

```r
<h1>Hello world</h1>
<p>Welcome to this application made by Flavio. ^_^</p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/02_01-views-mockups-page_a.html.erb)


questa view si appoggia al *layout basic* che è praticamente il *layout application* subito dopo la creazione della nuova applicazione Rails, con un minimo di aggiunte.

*** Codice 02 - .../app/views/layouts/basic.html.erb - linea:01 ***

```r
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

*** Codice 03 - .../app/controllers/mockups_controller.rb - linea:02 ***

```ruby
  def page_a
    render layout: 'basic'
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/02_03-controllers-mockups_controller.rb)




*** ...continua - linea: 3 ***

```html
    <a class="navbar-brand" href="#"><%= t "mockups.test_a.navbar" %></a>
```

*** ...continua - linea: 10 ***

```html
          <a class="nav-link active" aria-current="page" href="#"><%= t "mockups.test_a.home" %></a>
```

*** ...continua - linea: 16 ***

```html
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <%= t "mockups.test_a.navbar_dropdown" %>
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#"><%= t "mockups.test_a.navbar_action" %></a></li>
            <li><a class="dropdown-item" href="#"><%= t "mockups.test_a.navbar_another_action" %></a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#"><%= t "mockups.test_a.navbar_something_else_here" %></a></li>
          </ul>
        </li>
```


```html
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <%= t "mockups.test_a.navbar_dropdown" %>
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#"><%= t "mockups.test_a.navbar_action" %></a></li>
            <li><a class="dropdown-item" href="#"><%= t "mockups.test_a.navbar_another_action" %></a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#"><%= t "mockups.test_a.navbar_something_else_here" %></a></li>
          </ul>
        </li>
```

***Codice 01 - ...continua - linea:27***

```html+erb
          <a class="nav-link disabled"><%= t "mockups.test_a.navbar_disabled" %></a>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-internationalization_i18n/01_01-views-mockups-test_a.html.erb)
