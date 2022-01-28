




## Passiamo dei parametri alla traduzione

Se vogliamo dare il benvenuto ad inizio pagina possiamo impostare un parametro per il nome ad esempio.


{caption: ".../app/views/mockups/page_a.html.erb -- codice 03", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<p> 
  <%= t("mockups.page_a.welcome", name: "Flavio") %>
  <%= t(".welcome", name: "Flavio") %>
</p>
<h1> <%= t "mockups.page_a.headline" %> </h1>
<p> <%= t "mockups.page_a.first_paragraph" %> </p>
<br>
<p>  <%= link_to t("mockups.page_a.link_to_page_B"), mockups_page_b_path %> </p>
```


{id: "01-05-01_02all", caption: ".../config/locales/en.yml -- codice 02", format: yaml, line-numbers: true, number-from: 1}
```
en:
  mockups:
    page_a:
      welcome: "Welcome, %{name}"
      headline: "This is the homepage"
      first_paragraph: "the text showed here is passed via a 'translation file' and this means that our application is ready to support more languages."
      link_to_page_B: "Let's go to page B."
```


{caption: ".../config/locales/it.yml -- codice 04", format: yaml, line-numbers: true, number-from: 32}
```
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

{caption: ".../app/views/mockups/page_a.html.erb -- codice 03", format: HTML+Mako, line-numbers: true, number-from: 1}
```
  <%= t(".welcome_html", name: "Flavio") %>
```


{id: "01-05-01_02all", caption: ".../config/locales/en.yml -- codice 02", format: yaml, line-numbers: true, number-from: 1}
```
en:
  mockups:
    page_a:
      welcome: "Welcome, <strong>%{name}</strong>"
```

Questo mette il nome in grassetto.

Attenzione: Se passiamo un parametro in questo caso è bene fare il "sanitize." altrimenti abbiamo una vulnerabilità.

{caption: ".../app/views/mockups/page_a.html.erb -- codice 03", format: HTML+Mako, line-numbers: true, number-from: 1}
```
  <%= t(".welcome_html", name: sanitize.params[:locale]) %>
```

Personalmente preferisco non usare il suffisso "_html".

