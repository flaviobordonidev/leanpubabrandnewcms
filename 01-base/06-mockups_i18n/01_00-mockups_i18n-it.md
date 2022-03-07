# <a name="top"></a> Cap 6.1 - Internazionalizzazione della pagina di mockups

Attiviamo l'internazionalizzazione statica

Invece di scrivere i contenuti statici (quelli non presi dal database) già tradotti è più elegante mettere dei "segnaposto" che saranno poi usati dai vari files di traduzione nelle varie lingue. Questo permette di avere un'applicazione già pronta per essere tradotta in più lingue.

> Il nome dei "segnaposto" lo mettiamo in inglese per dare un'impronta *world-wide* al nostro applicativo che ci permetterà in futuro di collaborare con sviluppatori da tutto il mondo.



## Apriamo il branch "Mockups Internazionalizazione"

```bash
$ git checkout -b mi
```



## Internazionalizazione (i18n)

Per internazionalizzazione si intende la traduzione dell'applicazione nelle varie lingue.

L'internazionalizzazione si divide in due parti:

- Statica = traduzione delle stringhe usate nell'applicazione. Non traduce i dati del database.
- Dinamica = traduzione dei dati del database.

Al momento noi ci occupiamo solo di quella statica.



## I18n statico con YAML

Per tradurre in varie lingue il contenuto statico della nostra applicazione (quello che non è contenuto nel database) utilizziamo il file *yaml* che è disponibile di default su Rails. Non c'è necessità di installare una nuova gemma. 

> Rimane comunque la possibilità di cambiare successivamente solo il backend ed usarne uno differente invece dei files *yaml*. Tutto il resto dell'internazionalizzazione resta invariato.

Usiamo l'helper "***t***" per tutte le stringhe che dobbiamo internazionalizzare.
la stringa che viene passata all'helper "***t***" è un segnaposto che si usa nel file yaml associandogli la stringa corretta nella lingua scelta.

***codice 01 - .../app/views/mockups/page_a.html.erb - line: 1***

```html+erb
<h1> <%= t ".headline" %> </h1>
<p> <%= t ".first_paragraph" %> </p>
<br>
<p>  <%= link_to t(".link_to_page_B"), mockups_page_b_path %> </p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/01_01-views-mockups-page_a.html.erb)



### Verifichiamo preview

```bash
$ rails s
```

Se visualizziamo sul browser vediamo che si visualizzano i segnaposto.  

- https://mycloud9path.amazonaws.com/mockups/page_a

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/01_fig01-i18n_page_a_placeholds.png)



## Backend en.yml

Per far apparire le descrizioni invece dei segnaposti implementiamo il backend Yaml. 

Iniziamo con il file en.yml perché l'inglese (en) è la lingua che viene selezionata di default.
Avendo usato il "." davanti al nome del segnaposto, per convenzione Rails cerca il segnaposto catalogato nella rispettiva view. In questo caso sotto *en -> mockups -> page_a*.

***codice 02 - .../config/locales/en.yml - line: 32***

```yaml
en:
  mockups:
    page_a:
      headline: "This is the homepage"
      first_paragraph: "the text showed here is passed via a 'translation file' and this means that our application is ready to support more languages."
      link_to_page_B: "Let's go to page B."
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/01_02-config-locales-en.yml)

> ATTENZIONE! i files YAML (.yml) sono sensibili all'indentatura. <br/>
> Per indentare usiamo gli *spazi* e non i *tabs*.



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

Se visualizziamo sul browser vediamo che, al posto dei segnoposto, si presenta il contenuto.

* https://mycloud9path.amazonaws.com/mockups/page_a

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/01_fig02-i18n_page_a.png)



## Problema con uso dei partials e notazione corta su yaml

> Attenzione! C'è un bug e sui partials non mi funziona il "." come previsto quando uso i partials. Ho quindi scelto di usare tutto il percorso.

Esiamo la notazione completa per identificare i segnapoto.

***codice 03 - .../app/views/mockups/page_a.html.erb - line: 1***

```html+erb
<h1> <%= t "mockups.page_a.headline" %> </h1>
<p> <%= t "mockups.page_a.first_paragraph" %> </p>
<br>
<p>  <%= link_to t("mockups.page_a.link_to_page_B"), mockups_page_b_path %> </p>
```



## Backend it.yml

Adesso creiamo il file it.yml per implementare la lingua italiana (it).

***codice 04 - .../config/locales/it.yml - line: 32***

```yaml
it:
  mockups:
    page_a:
      headline: "Questa è l'homepage"
      first_paragraph: "il testo mostrato è o passato da un 'file di traduzione' e questo significa che la nostra applicazione è pronta a supportare più lingue."
      link_to_page_B: "Andiamo alla pagina B"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/01_04-config-locales-it.yml)

Questa traduzione è pronta ma non è ancora utilizzata nella nostra applicazione. La implementeremo nel prossimo capitolo. 



### Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

Se visualizziamo sul browser vediamo che, al posto dei segnoposto, la lingua che si presenta è quella inglese di en.yml perché è quella di default.

- https://mycloud9path.amazonaws.com/mockups/page_a

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/01_fig03-i18n_page_a.png)



## Salviamo su Git

```bash
$ git add -A
$ git commit -m "set i18n static"
```



## pubblichiamo su heroku

```bash
$ git push heroku mi:master
```



## Chiudiamo il branch

Lo chiudiamo nel prossimo capitolo



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/04_00-github-multi-users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/02_00-default_language-it.md)
