# <a name="top"></a> Cap 2.1 - Internazionalizzazione (i18n)

Aggiungiamo la gestione in più lingue del contenuto statico (quello che non è preso dal database).



## Risorse interne

-[code_references/i18n_static_config_locale_yaml/03_00-change_language_by_url_browser]()



## Apriamo il branch "Internazionalizazione Statica"

```shell
$ git checkout -b is
```



## Implementiamo l'internazionalizzazione statica.

I18n statico: `t "nome_segnaposto"`

> `t` è l'helper per la traduzione.</br>

[Codice 01 - .../app/views/mockups/test_a.html.erb - linea:39]()

```html
<!--<h1>Hello world</h1>-->
<!--<p>Welcome to this application made by Flavio. ^_^</p>-->
<h1><%= t "mockups.test_a.headline" %></h1>
<p><%= t "mockups.test_a.first_paragraph" %></p>
```

> `t "mockups.test_a.headline"` indica all'helper che siamo nella view `mockups/test_a` e che vogliamo tradurre il segnaposto `headline`.</br>



## Implementiamo il backend YAML

Per far apparire le descrizioni invece dei segnaposti implementiamo il backend Yaml.
Iniziamo con il file `en.yml` perché l'inglese (en) è la lingua che viene selezionata di default.

[Codice 02 - .../config/locales/en.yml - line: 30]()

```yaml
en:
  mockups:
    test_a:
      headline: "This is the homepage"
      first_paragraph: "the text showed here is passed via a 'translation file' and this means that our application is ready to support more languages"
```

> ATTENZIONE! i files YAML (.yml) sono sensibili all'indentatura. Per indentare usiamo gli *spazi* e non i *tabs*.



## Verifichiamo preview

Adesso proviamo di nuovo il preview

```shell
$ rails s -b 192.168.64.4
```

E lo visualizziamo nel browser all'url: `http://192.168.64.4:3000/mockups/test_a`



## Salviamo su Git

```bash
$ git add -A
$ git commit -m "set i18n static"
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/04_00-github-multi-users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/02_00-default_language-it.md)
