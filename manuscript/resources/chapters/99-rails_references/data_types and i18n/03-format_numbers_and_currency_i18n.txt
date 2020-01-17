# Formattiamo i numeri e la valuta

Per gestire le valute invece di usare "number_to_currency" è meglio usare la gemma "money..."
Ma invece di installare una gemma si può semplificare gestendo la formattazione del numero e la valuta a parte.

Risorse interne:

* 01-base/12-format_i18n/02-format_currencies_i18n.txt




## Formattiamo/traduciamo il numero

In Italia per dividere le migliaia si usa il "." e per le cifre decimali si usa la ",". Negli USA è il contrario. Ad esempio:

* Italia: 1.123.450,50
* USA: 1,123,450.50

Quindi formattiamo in maniera diversa il numero a seconda della lingua che usiamo.

Questo è già stato fatto e lo possiamo trovare nel sito ufficiale di Rails (come ci è anche suggerito nel locale di default en.yml)

# To learn more, please read the Rails Internationalization guide
# available at https://guides.rubyonrails.org/i18n.html.

Nella guida troviamo un riferimento a questo sito per esempi di traduzione in tutte le lingue:

https://github.com/svenfuchs/rails-i18n/tree/master/rails/locale

e da questo possiamo prendere l'italiano

https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/it.yml

e da questo estrarci la parte di formattazione dei numeri


{id: "01-12-01_04", caption: ".../config/locales/it.yml -- codice 04", format: yaml, line-numbers: true, number-from: 4}
```
  number:
    currency:
      format:
        delimiter: "."
        format: "%n %u"
        precision: 2
        separator: ","
        significant: false
        strip_insignificant_zeros: false
        unit: "€"
    format:
      delimiter: "."
      precision: 2
      separator: ","
      significant: false
      strip_insignificant_zeros: false
    human:
      decimal_units:
        format: "%n %u"
        units:
          billion: Miliardi
          million: Milioni
          quadrillion: Biliardi
          thousand: Mila
          trillion: Bilioni
          unit: ''
      format:
        delimiter: ''
        precision: 3
        significant: true
        strip_insignificant_zeros: true
      storage_units:
        format: "%n %u"
        units:
          byte:
            one: Byte
            other: Byte
          gb: GB
          kb: KB
          mb: MB
          tb: TB
    percentage:
      format:
        delimiter: ''
        format: "%n%"
    precision:
      format:
        delimiter: ''
```

Siccome gestiamo la valuta a parte evitiamo che venga visualizzata modifichiamo in "currency -> format" da " unit: "€" " in " unit: '' ".




## Traduzione con passaggio di argomenti/variabili

Possiamo anche passare argomenti nel metodo i18n translate, in questo modo:

{id: "01-12-01_04", caption: ".../config/locales/it.yml -- codice 04", format: yaml, line-numbers: true, number-from: 4}
```
  eg_posts:
    index:
      html_head_title: "Tutti gli articoli"
    show:
      html_head_title: "Art."
      price_fomatted: "Questo costa %{myprice} di soldini"
```

Aggiorniamo le views per visualizzare le traduzioni 

{title=".../app/views/messages/_sidebar.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=56}
~~~~~~~~
<%= t ".price_fomatted", myprice: number_to_currency(1200, precision: 2) %>
~~~~~~~~

ed otteniamo: 1.200,00
