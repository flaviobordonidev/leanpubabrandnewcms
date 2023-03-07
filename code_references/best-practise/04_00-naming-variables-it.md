# <a name="top"></a> Cap best-practiesr.4 - Nomenclatura variabili

Buone pratiche per dare un nome alle varie variabili



## Risorse interne

- []()



## Risorse esterne

- []()



## I campi `data`

Vediamo la definizione di una tabella per i film. Per archiviare la data in cui abbiamo visto il film usiamo il nome `watched_on`.

> il suffisso `_on` si inserisce per convenzione sui nomi dei campi di tipo `date`.<br/>
> **Non** si usa invece nel caso di campi di tipo `datetimes`.

```bash
$ rails g model Movie title director storyline:text watched_on:date
```

Here you are setting the `title` and `director` as strings (default type if not specified), `storyline` as text, and `watched_on` as date (when setting dates, not datetimes, the convention is to append on to the name).



## I campi dei nomi propri di persone

Per le persone la maggior parte delle volte si usano i campi `first_name` e `last_name` ma questi non sono la soluzione migliore.

[dafa]



## I campi indirizzo

[dafa]



## Altri campi

```bash
$ rails g scaffold Person title:string first_name:string last_name:string homonym:string memo:text
```


Colonna                        | Descrizione
| :-                           | :-
`tax_code:string`              | (25 caratteri) il codice fiscale della persona
`sex:integer`                  | (enum) e non boolean perché oltre maschio e femmina esiste anche la possibilità transgend/transex/... Inoltre è più semplice la gestione per le varie lingue con un menu a cascata (dropdown menu).
`nationality_id:integer`      | (enum) Le nazioni
`born_on:date`                | (gg/mm/aaaa) La data di nascita
`born_city_id:integer`        | (enum) La città dove è nato (può essere anche `:string`)




## Progettiamo le colonne per la tabela users

Colonna                        | Descrizione
| :-                           | :-
`first_name:string`            | (65 caratteri) il Nome della persona
`last_name:string`             | (65 caratteri) il Cognome della persona
`username:string`              | (65 caratteri) Il "nick name" mostrato nell'app
`email:string`                 | (65 caratteri) l'email con cui fai login
`location:string`              | (65 caratteri) La nazione dove sei
`bio:string`                   | (160 caratteri) Una breve descrizione dell'utente. (`about_me`)
`profile_image` -> in model    | immagine caricata con active_storage su aws S3
`password:string`              | (65 caratteri) La password
`phone_number:string`          | (20 caratteri) questo andrebbe nella tabella morphic "telephonable"




Colonne principali

Colonna                 | Descrizione
|:-                     | :-
`name:string`           | (255 caratteri) Nome esercizio / aula / lezione  (es: View of mount Vermon, The isle of the death, ...) - Questo appare nelle cards nell'index
`duration:integer`      | Quanto dura l'esercizio in media. (Uso un numero intero che mi rappresenta quanti **minuti** dura. es: 90 minuti, 180 minuti, ...)



Colonne secondarie

Colonna                       | Descrizione
|:-                           | :-
`picture_author_image -> model`	| Foto dell'autore del quadro (via upload ActiveStorage)
`picture_image -> model` 			| Foto del quadro (via upload ActiveStorage)
`picture_author_name:string` 	| Nome autore (eg: Joachim Ferdinand Richardt)
`picture_museum_name:string` 	| Nome museo (eg: Young museum)
`description:text`						| Descrizione del corso e del quadro. (Descrizione RichTextFormat perché 
`Categoria/Tag`               | 7. Interpretazione, Dipinto, Suoni ambiente, ... <br/> (vedi gemma taggable)
`blocco (lucchetto)`          | -> lock_value_percorsocoach1 (livello a cui devi essere per sbloccarlo?) <br/> -> lock_value_percorsocoach2 (indipendente dal percorsocoach1 ) <br/> Quindi metto tante colonne quanti sono i percorsicoach (attualmente è 1 solo ^_^)
`note:text`                   | (molti caratteri) Note Aggiuntive - questo appare nello show. è un approfondimento sull'esercizio
`meta_title:string`           | Per il SEO
`meta_description:string`     | Per il SEO


Tabelle collegate 1-a-molti (non c'è *chiave esterna* perché è sull'altra tabella)

Colonna    | Descrizione
|:-        | :-
`steps`    | una lezione è collegata a vari steps: azioni richieste (spesso sono domande a cui rispondere).


Tabelle collegate molti-a-1 (c'è *chiave esterna*)

Colonna                   | Descrizione
|:-                       | :-
`tags?!?`                 | vedi gemma taggable



