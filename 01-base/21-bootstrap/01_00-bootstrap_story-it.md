{id: 01-base-21-bootstrap-01-bootstrap_story}
# Cap 21.1 -- Bootstrap

Prepariamo un'interfaccia grafica per la dashboard di gestione degli articoli. Questa parte è sganciata dal template scelto per la presentazione del Blog.
Inizialmente preperiamo una dashboard molto semplice sfruttando la potente libreria bootstrap. In seguito sceglieremo un tema più elaborato per abbellire la dashboard ed aggiungervi ulteriori funzionalità.




## Perchè Bootstrap?

Bootstrap è un framework sviluppato da Mark Otto e Jacob Thornton (aka @mdo and @fat) a Twitter con l’obiettivo di mettere a punto un set di strumenti
che uniformasse l’interfaccia web del Social Network facilitandone la manutenzione.

Un altro motivo i moduli o i plugin di questi software non sono sempre gratuiti o a passo con i tempi, la possibilità di avere un CMS personalizzabile
ed avere il pieno controllo, alla lunga porta dei benefici di tempo ed economici.

Nel 2011 Twitter ha rilasciato Bootstrap sotto licenza open source, da allora questo framework è stato adottato da un numero crescente di sviluppatori ed
al contempo ha raggiunto la release 3.3.6.

I> Apprendiamo che al momento della stesura di questo libro il mondo è attesa dell'imminiente arrivo della versione 4

Bootstrap è indubbiamente uno dei framework HTML,CSS,JS più diffusi e a breve approderà alla 4 release.
In questa breve carrellata Bob vi presenta 5 siti da consultare se avete intenzione di sviluppare un progetto con questo framework.
Questi portali da soli elencano perlomeno l’80% delle risorse più rilevanti.




### Bootsnipp

![Bootsnipp Home Page](images/originals/bootsnipp.jpg)

Bootsnip è un utile punto di partenza per chi è alla ricerca di risorse e snippet di codice da integrare al proprio progetto Bootstrap.
Fra le risorse da segnalare trova posto un form builder per la creazione visuale di form, un market place per temi a pagamento basati su Bootstrap e una libreria di snippet suddivisa in base alla compatibilità con le release del framework.
[http://www.bootsnipp.com/](http://www.bootsnipp.com/)




### Expo Get Bootstrap

expo.getbootstrap è uno showcase che elenca progetti di elevata qualità realizzati utilizzando Bootstrap.
La gallery è minimale ed organizzata in ordine cronologico ma può fornire indubbiamente delle indicazioni su quelle che sono le potenzialità della piattaforma.
La gallery ha anche una sezione risorse da consultare.




### The Big Badass List of Twitter Bootstrap Resources
bootstraphero.com propone una lista molto corposa di risorse (ad oggi 319) organizzata per componenti, framework Integrations, interface builders,
tool per il mockup, strumenti e servizi, how to e javascript addons.

I> Spiccano le integrazioni e i temi per diversi CMS come Joomla e WordPress.




### Design Posts: 50 risorse, tool e design
Designposts ci propone un post che elenca 50 risorse per Bootstrap, fra questi la maggior parte sono plugin javascript facilmente integrabili in Bootstrap.
La maggior parte sono espressamente pensati per questa piattaforma.




### Bootstrap Bay
Bootstrap Bay è un marketplace di temi focalizzato sul framework. La qualità delle proposta è medio alta mentre i prezzi sono contenuti e comunque in linea con il mercato.
Fra le proposte abbiamo anche il Boostrap Theme Start Kit sostanzialmente un theme builder estremamente veloce ed efficace.






---



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## salviamo su git

```bash
$ git add -A
$ git commit -m "users_controllers notice messages i18n"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku ui:master
```



## Chiudiamo il branch

Lo lasciamo aperto per il prossimo capitolo



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)