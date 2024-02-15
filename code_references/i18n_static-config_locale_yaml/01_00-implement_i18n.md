# <a name="top"></a> Cap 2.1 - Internazionalizzazione (i18n)


Per internazionalizzazione si intende la traduzione dell'applicazione nelle varie lingue.

L'internazionalizzazione si divide in due parti:

- Statica = traduzione delle stringhe usate nell'applicazione. Non traduce i dati del database.
- Dinamica = traduzione dei dati del database.

Al momento noi ci occupiamo solo di quella statica.



## Risorse interne

- [ubuntudream/04-i18n_static/01-implement_i18n]()



## Apriamo il branch "Internazionalizazione Statica"

```shell
$ git checkout -b is
```



## Attiviamo l'internazionalizzazione statica.

Invece di scrivere nei mockups dei contenuti statici (quelli non presi dal database) già tradotti è più elegante mettere dei "segnaposto" che saranno poi tradotti nelle varie lingue (locales).

Questo permette di avere un'applicazione già pronta per essere tradotta in più lingue.

> Il nome dei "segnaposto" lo mettiamo in inglese per dare un'impronta *world-wide* al nostro applicativo che ci permetterà in futuro di collaborare con sviluppatori da tutto il mondo.



## I18n statico con YAML

Per tradurre in varie lingue il contenuto statico della nostra applicazione (quello che non è contenuto nel database) utilizziamo il file *yaml* che è disponibile di default su Rails. Non c'è necessità di installare una nuova gemma. 

> Rimane comunque la possibilità di cambiare successivamente solo il backend ed usarne uno differente invece dei files *yaml*. Tutto il resto dell'internazionalizzazione resta invariato.

Usiamo l'helper `t` per tutte le stringhe che dobbiamo internazionalizzare.
la stringa che viene passata all'helper `t` è un segnaposto che si usa nel file yaml associandogli la stringa corretta nella lingua scelta.

> L'helper `t "nome_segnaposto"` è lo short di `I18n.t("nome_segnaposto")`

*** Codice 01 - .../app/views/mockups/test_a.html.erb - linea:39 ***

```html
<!--<h1>Hello world</h1>-->
<!--<p>Welcome to this application made by Flavio. ^_^</p>-->
<h1><%= t "mockups.test_a.headline" %></h1>
<p><%= t "mockups.test_a.first_paragraph" %></p>
```

> `t` è l'helper per la traduzione.</br>
> `t "mockups.test_a.headline"` indica all'helper che siamo nella view `mockups/test_a` e che vogliamo tradurre il segnaposto `headline`.</br>
> si potrebbe omettere la view ed indicare il solo segnaposto `t ".headline"` ma se ci sono dei partials si possono avere degli errori. Per questo è più sicuro scrivere l'intero percorso.



### Verifichiamo preview

```bash
$ rails s
```

Se visualizziamo sul browser vediamo che si visualizza il nome del segnaposto. Questo perché non abbiamo ancora messo la traduzione nei file *yaml*.

- https://mycloud9path.amazonaws.com/mockups/page_a

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-internationalization_i18n/01_fig01-i18n_page_a_placeholds.png)

> inoltre il *search input* ed il *popover* si visualizzano "corrotti" perché manca la traduzione.



## Backend en.yml

Per far apparire le descrizioni invece dei segnaposti implementiamo il backend Yaml. 

Iniziamo con il file en.yml perché l'inglese (en) è la lingua che viene selezionata di default.

***codice 02 - .../config/locales/en.yml - line: 32***

```yaml
en:
  mockups:
    page_a:
      headline: "This is the homepage"
      first_paragraph: "the text showed here is passed via a 'translation file' and this means that our application is ready to support more languages."
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/01_02-config-locales-en.yml)

> ATTENZIONE! i files YAML (.yml) sono sensibili all'indentatura. <br/>
> Per indentare usiamo gli *spazi* e non i *tabs*.



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

Se visualizziamo sul browser vediamo che, al posto dei segnaposto, si presenta il contenuto.

* https://mycloud9path.amazonaws.com/mockups/page_a

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/01_fig02-i18n_page_a.png)




## Salviamo su Git

```bash
$ git add -A
$ git commit -m "set i18n static"
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/04_00-github-multi-users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/02_00-default_language-it.md)
