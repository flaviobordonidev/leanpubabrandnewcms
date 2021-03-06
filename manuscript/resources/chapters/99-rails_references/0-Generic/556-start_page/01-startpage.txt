# La pagina iniziale (startpage)

la pagina iniziale (startpage) precede il login e la pagina principale (homepage).

I> Attenzione a confusioni: A volte la homepage è chiamata pagina iniziale e la startpage è chiamata splash-screen




## Apriamo il branch "start page"

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git checkout -b sp
~~~~~~~~




## Rails generate controller

Non legando startpage al database non usiamo lo scaffold.

Usiamo il "rails generate controller ..." e gli associamo solo l'azione "show". 

A> ATTENZIONE: con "rails generate controller ..." -> usa il SINGOLARE ed ottiene un controller al singolare.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails g controller Startpage show
~~~~~~~~

non ha nessun migrate perché non si interfaccia con il database.




## Routes

Aggiorniamo il file routes per mettere la startpage come pagina principale (root)

{title="config/routes.rb", lang=ruby, line-numbers=on, starting-line-number=3}
~~~~~~~~
Rails.application.routes.draw do

  root 'startpage#show'

  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :users

  get 'startpage/show'
  get 'homepage/show'
  get 'testpages/page_a'
  get 'testpages/page_b'
  get 'mockup_tests/bootstrap_grid'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
~~~~~~~~




## Creiamo lo show della pagina iniziale (startpage)

Prepariamo una pagina di presentazione che permette di effettuare il login su un'altra finestra del browser.

{title=".../app/views/startpage/show.html.erb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
<div class="container-fluid front_mode">

  <h1> Elisinfo </h1>

  <div class="row">
    <div class="col-xs-12">


    <div class="list-group left-pad right-pad bottom-pad">
      <!-- parte dedicata alle finestre multiple -->
      <!-- http://www.w3schools.com/jsref/met_win_open.asp -->
      <!-- https://developer.mozilla.org/en-US/docs/Web/API/Window/open -->
      <!-- http://stackoverflow.com/questions/6213807/open-a-new-tab-with-javascript-but-stay-on-current-tab -->
      <button onclick="myFunction()">
        <span class="glyphiconmy ico_instance right-pad"></span> Nuova istanza
      </button>
      
      <script>
      function myFunction() {
          var myWindow = window.open("/homepage/show", "_blank", "toolbar=no,scrollbars=yes,resizable=yes,top=50,left=50,width=400,height=600");
      }
      </script>
    </div>


    <div class="list-group left-pad right-pad bottom-pad">
      <button onclick="myFunction2()">
        <span class="glyphiconmy ico_instance right-pad"></span> Nuova istanza Sviluppatore
      </button>
      
      <script>
      function myFunction2() {
        window.open("/homepage/show", "_blank");
      }
      </script>
    </div>


    </div> <!-- end - col -->
  </div> <!-- end - row -->

</div> <!-- end - front_mode -->
~~~~~~~~

la parte di codice javascript apre una nuova finestra del browser e punta a "/homepage/show" se l'utente è loggato allora si presenta la pagina altrimenti si apre la pagina di login.

I> Se nel codice javascript avessimo messo "/homepage" avremmo dovuto mettere nel files routes la linea di codice ** get "homepage/", to: "homepage#show" **




## Reindirizzare su una specifica pagina dopo il login o il logout (Devise sign_in o sign_out)

Si presenta però un problema in fase di logout perché non vogliamo che sulla nuova istanza del browser si torni alla startpage. Vogliamo che si torni alla homepage, che in questo caso significa tornare alla pagina di login. Per fare questo reimpostiamo il comportamento di default di devise che è quello di andare sul root_path.

Di default il logout ci reindirizzava sul root_path. Per reistradare su una pagina differente possiamo sovrascrivere il comportamento di default assegnandogli un altro path. Nel nostro caso lo instradiamo su ** homepage_path **. 

{title=".../app/controllers/application_controller.rb", lang=ruby, line-numbers=on, starting-line-number=9}
~~~~~~~~
  def after_sign_out_path_for(resource_or_scope)
    homepage_show_path
  end
~~~~~~~~

* https://github.com/plataformatec/devise/wiki/How-To:-redirect-to-a-specific-page-on-successful-sign_in,-sign_out,-and-or-sign_up
* https://github.com/plataformatec/devise/wiki/How-To:-Redirect-to-a-specific-page-on-successful-sign-in-out


verifichiamo che funziona tutto

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo service postgresql start
$ rails s -b $IP -p $PORT
https://elisinfo6-flaviobordonidev.c9users.io/
~~~~~~~~

![startpage show](images/startpage/startpage/show.png)

aggiorniamo git 

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git add -A
$ git commit -m "add startpage show"
~~~~~~~~




## Publichiamo su heroku

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git push heroku sp:master
~~~~~~~~




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git checkout master
$ git merge sp
$ git branch -d sp
~~~~~~~~