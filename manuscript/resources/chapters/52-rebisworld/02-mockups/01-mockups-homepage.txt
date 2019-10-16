# Creiamo un mockups di homepage

Prendiamo spunto dal tema pofo e creiamo una nostra pagina di homepage.




## Apriamo il branch "Mockup Homepage"

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git checkout -b mh
~~~~~~~~




## Creiamo la view mockups/homepage


{id="03-03-01_03", title=".../app/views/mockups/homepage.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
~~~~~~~~
        <!-- start header -->
        <header>
            <!-- start navigation -->
~~~~~~~~
[Codice 01](#06-01-01_01all)





### Creiamo il menu

facciamo un semplice menu con il logo a sinistra ed a destra le 3 voci: HOME | LA FORMULA | LE ISOLE

* HOME 
* LE ISOLE (sezioni -- usa i tags ed è al posto delle categorie) 
* LE ANIME (firme / gli autori -- chi scrive gli articoli)
* ARCHIVIO (gli articoli visualizzati enfatizzando la data)

{id="03-03-01_03", title=".../app/views/layouts/_pofo_navigation_menu.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
~~~~~~~~

~~~~~~~~




## Implementiamo istradamento


{id="03-03-01_03", title=".../config/routes.rb", lang=ruby, line-numbers=on, starting-line-number=28}
~~~~~~~~
  get 'mockups/homepage'
~~~~~~~~
[Codice 02](#06-01-01_01all)




## Aggiorniamo controller


{id="03-03-01_03", title=".../controllers/mockups_controller.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
  def homepage
    render layout: 'mockups_pofo'
  end
~~~~~~~~
[Codice 03](#06-01-01_01all)




## Verifichiamo preview

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo service postgresql start
$ rails s
~~~~~~~~




## Archiviamo su git

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git add -A
$ git commit -m "Mockup homepage"
~~~~~~~~




## Publichiamo su Heroku


{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git push heroku mh:master
~~~~~~~~




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git checkout master
$ git merge mh
$ git branch -d mh
~~~~~~~~




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git push origin master
~~~~~~~~
