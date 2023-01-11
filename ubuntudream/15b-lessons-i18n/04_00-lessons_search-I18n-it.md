# <a name="top"></a> Cap 10.1 - Implementiamo il search per le lezioni internazionalizzate

Rivediamo il nostro campo di ricerca in seguito all'internazionalizzazione delle lezioni (I18n dynamic) fatto con la gemma `mobility`.



## Risorse interne

- []()



## Apriamo il branch "Lessons Search I18n"

```bash
$ git checkout -b lsi
```



## Aggiorniamo il model

Interveniamo direttamente sul filtro "search()". 

Nella sezione "# == Scopes"

***Codice 01 - .../app/models/lesson.rb - linea:01***

```ruby
  scope :search, -> (query) {where("name ILIKE ?", "%#{query.strip}%")}
```

Analizziamo il codice:

codice               | descrizione
|:-                  |:-
`->`                 | la freccia "->" è un modo compatto di usare la chiamata "lambda".


