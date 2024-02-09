# <a name="top"></a> Cap i18n_static_config_locale_yaml.02 - Formattiamo le date nelle varie lingue



## Passiamo dei parametri alla traduzione

Se vogliamo dare il benvenuto ad inizio pagina possiamo impostare un parametro per il nome ad esempio.

*** Codice 01 - .../app/views/mockups/page_a.html.erb - linea: 1 ***

```r
<p> 
  <%= t("mockups.page_a.welcome", name: "Flavio") %>
  <%= t(".welcome", name: "Flavio") %>
</p>
<h1> <%= t "mockups.page_a.headline" %> </h1>
<p> <%= t "mockups.page_a.first_paragraph" %> </p>
<br>
<p>  <%= link_to t("mockups.page_a.link_to_page_B"), mockups_page_b_path %> </p>
```


*** Codice 02 - .../config/locales/en.yml - linea: 1 ***

```yml
en:
  mockups:
    page_a:
      welcome: "Welcome, %{name}"
      headline: "This is the homepage"
      first_paragraph: "the text showed here is passed via a 'translation file' and this means that our application is ready to support more languages."
      link_to_page_B: "Let's go to page B."
```

*** Codice 03 - .../config/locales/it.yml - linea: 32 ***

```yml
it:
  mockups:
    page_a:
      welcome: "Benvenuto, %{name}"
      headline: "Questa è l'homepage"
      first_paragraph: "il testo mostrato è o passato da un 'file di traduzione' e questo significa che la nostra applicazione è pronta a supportare più lingue."
      link_to_page_B: "Andiamo alla pagina B"
```



## Passiamo una stringa HTML

Se mettiamo alla fine della parola il suffisso "_html" abilitiamo il passaggio di codice HTML.

ad esempio:

*** Codice 04 - .../app/views/mockups/page_a.html.erb - linea: 1 ***

```r
  <%= t(".welcome_html", name: "Flavio") %>
```

*** Codice 05 - .../config/locales/en.yml - linea: 1 ***

```yml
en:
  mockups:
    page_a:
      welcome: "Welcome, <strong>%{name}</strong>"
```

Questo mette il nome in grassetto.

Attenzione: Se passiamo un parametro in questo caso è bene fare il "sanitize." altrimenti abbiamo una vulnerabilità.

*** Codice 06 - .../app/views/mockups/page_a.html.erb - linea: 1 ***

```r
  <%= t(".welcome_html", name: sanitize.params[:locale]) %>
```

> Personalmente preferisco **non** usare il suffisso `_html`.

