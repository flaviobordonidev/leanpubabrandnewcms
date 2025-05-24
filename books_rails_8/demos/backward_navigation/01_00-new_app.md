# <a name="top"></a> Link per tornare indietro di più pagine

[25/05/21]
Prepariamo una nuova app per implementare un link "Torna indietro" che ci permette di ritornare indietro nelle pagine precedentemente visitate ma *saltando quelle per cui non vogliamo visualizzare tornando indietro* come ad esempio un form da compilare o nel caso di ubuntudream tutti i vari video di una stessa lezione.



## Iniziamo creando l'app `mediaplayer_videojs`


```shell
❯ cd /Users/fb/ror
❯ rails new backwardnav
❯ cd backwardnav
```



## Generiamo `Article`

Generiamo un blog di articoli per avere una struttura in cui implementare il link di "torna indietro".

```shell
❯ rails g scaffold Article title content
❯ bin/rails db:migrate
```



## Facciamo partire il server

Invece di usare `rails s` usiamo `bin/dev` perché questo permette di far partire anche dei processi ausiliari, *"auxiliaries watcher processes"*, ad esempio nel caso di utilizzo di `esbuild` o di `tailwindcss`.

```shell
❯ bin/dev
```

Vediamo il risultato nel browser all'url: `http://127.0.0.1:3000/`

Creiamo qualche nuovo articolo.




## Risorse esterne

Una risorsa importante è ChatGPT.
(Tip: Usa ChatGPT per aiutarti mentre implementi)

-[]()


---
[top](#top) |
[index](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/index.md)

