# <a name="top"></a> Cap 3.1 - Mockups

I mockups sono delle pagine statiche di esempio usate per verificare la GUI (Graphic User Interface).
Servono principalmente in fase di sviluppo e sono un buon modo di interfacciamento tra Graphic Designer e Code Developper.


 
## Verifichiamo dove eravamo rimasti

```bash
$ git status
$ git log
```

Esempio:

```bash
user_fb:~/environment $ cd bl7_0/
user_fb:~/environment/bl7_0 (main) $ git status
On branch main
nothing to commit, working tree clean
user_fb:~/environment/bl7_0 (main) $ git log
commit d64bcf1dfc29ecacc5652754eae6a40b1ad5b579 (HEAD -> main, tag: v0.1.0)
Author: Flavio Bordoni Dev <flavio.bordoni.dev@gmail.com>
Date:   Tue Jan 18 14:37:49 2022 +0000

    new rails app
user_fb:~/environment/bl7_0 (main) $ 
```



## Apriamo il branch "Mockups Static Pages"

Assicuriamoci di essere nella directory della nostra applicazione Rails e creiamo il ramo con git.

```bash
$ cd ~/environment/bl7_0
$ git checkout -b msp
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (main) $ pwd
/home/ubuntu/environment/bl7_0
user_fb:~/environment/bl7_0 (main) $ git checkout -b msp
Switched to a new branch 'msp'
user_fb:~/environment/bl7_0 (msp) $ 
```

> Nell'esempio non eseguiamo il comando *cd ...* perché siamo già nella directory giusta come vediamo con il comando *pwd* (present working directory).



## Creiamo il controller e le views per i mockups

Non usiamo né il **generate scaffold** né il **generate model** perché le pagine di mockups non usano dati archiviati nel database.
Invece usiamo il **generate controller** e gli associamo le azioni **page_a** e **page_b**. 
(non gli associamo le classiche azioni restful: index, show, edit, new, ...)

> ATTENZIONE: con "rails generate controller ..." -> usiamo il PLURALE ed otteniamo un controller al plurale.

Poiché sono più pagine statiche usiamo il nome del controller al plurale anche se non abbiamo un elenco di elementi da visualizzare

```bash
$ rails g controller Mockups page_a page_b
```

```bash
user_fb:~/environment/bl7_0 (msp) $ rails g controller Mockups page_a page_b
      create  app/controllers/mockups_controller.rb
       route  get 'mockups/page_a'
              get 'mockups/page_b'
      invoke  erb
      create    app/views/mockups
      create    app/views/mockups/page_a.html.erb
      create    app/views/mockups/page_b.html.erb
      invoke  test_unit
      create    test/controllers/mockups_controller_test.rb
      invoke  helper
      create    app/helpers/mockups_helper.rb
      invoke    test_unit
user_fb:~/environment/bl7_0 (msp) $ 
```

> Non abbiamo nessun migrate perché non ci interfacciamo con il database.



### Verifichiamo preview

Vediamo la nostra applicazione rails funzionante. Attiviamo il webserver

```bash
$ sudo service postgresql start
$ rails s
```

e vediamo i vari URLs sul nostro browser:

- https://mycloud9path.amazonaws.com
- https://mycloud9path.amazonaws.com/mockups/page_a
- https://mycloud9path.amazonaws.com/mockups/page_b

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/03-mockups/01_fig01-views-mockups-page_a.png)

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/03-mockups/01_fig02-views-mockups-page_b.png)




## Instradiamo con routes

Aggiorniamo il file routes per mettere l'homepage come pagina principale (root)

***codice 01 - .../config/routes.rb - line: 2***

```ruby
  root 'mockups#page_a'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/03-mockups/01_01-config-routes.rb)



## Verifichiamo preview

Attiviamo il webserver

```bash
$ sudo service postgresql start
$ rails s
```

e vediamo che addesso sull'URL della root "/" ci reinstrada su page_a:

- https://mycloud9path.amazonaws.com
- https://mycloud9path.amazonaws.com/mockups/page_a
- https://mycloud9path.amazonaws.com/mockups/page_b

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/03-mockups/01_fig03-views-mockups-page_a-root_path.png)



## Vediamo gli instradamenti da terminale


```bash
$ rails routes
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (msp) $ rails routes
                                  Prefix Verb   URI Pattern                                                                                       Controller#Action
                                    root GET    /                                                                                                 mockups#page_a
                          mockups_page_a GET    /mockups/page_a(.:format)                                                                         mockups#page_a
                          mockups_page_b GET    /mockups/page_b(.:format)                                                                         mockups#page_b
        turbo_recede_historical_location GET    /recede_historical_location(.:format)                                                             turbo/native/navigation#recede
        turbo_resume_historical_location GET    /resume_historical_location(.:format)                                                             turbo/native/navigation#resume
       turbo_refresh_historical_location GET    /refresh_historical_location(.:format)                                                            turbo/native/navigation#refresh
           rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                           action_mailbox/ingresses/postmark/inbound_emails#create
              rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                              action_mailbox/ingresses/relay/inbound_emails#create
           rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                           action_mailbox/ingresses/sendgrid/inbound_emails#create
     rails_mandrill_inbound_health_check GET    /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#health_check
           rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#create
            rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                                       action_mailbox/ingresses/mailgun/inbound_emails#create
          rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#index
                                         POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#create
       new_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/new(.:format)                                      rails/conductor/action_mailbox/inbound_emails#new
      edit_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id/edit(.:format)                                 rails/conductor/action_mailbox/inbound_emails#edit
           rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#show
                                         PATCH  /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#update
                                         PUT    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#update
                                         DELETE /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#destroy
new_rails_conductor_inbound_email_source GET    /rails/conductor/action_mailbox/inbound_emails/sources/new(.:format)                              rails/conductor/action_mailbox/inbound_emails/sources#new
   rails_conductor_inbound_email_sources POST   /rails/conductor/action_mailbox/inbound_emails/sources(.:format)                                  rails/conductor/action_mailbox/inbound_emails/sources#create
   rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                               rails/conductor/action_mailbox/reroutes#create
rails_conductor_inbound_email_incinerate POST   /rails/conductor/action_mailbox/:inbound_email_id/incinerate(.:format)                            rails/conductor/action_mailbox/incinerates#create
                      rails_service_blob GET    /rails/active_storage/blobs/redirect/:signed_id/*filename(.:format)                               active_storage/blobs/redirect#show
                rails_service_blob_proxy GET    /rails/active_storage/blobs/proxy/:signed_id/*filename(.:format)                                  active_storage/blobs/proxy#show
                                         GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                                        active_storage/blobs/redirect#show
               rails_blob_representation GET    /rails/active_storage/representations/redirect/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations/redirect#show
         rails_blob_representation_proxy GET    /rails/active_storage/representations/proxy/:signed_blob_id/:variation_key/*filename(.:format)    active_storage/representations/proxy#show
                                         GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format)          active_storage/representations/redirect#show
                      rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                                       active_storage/disk#show
               update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                               active_storage/disk#update
                    rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                                    active_storage/direct_uploads#create
user_fb:~/environment/bl7_0 (msp) $ 
```

Nella colonna *Prefix* c'è la voce che utiliziamo per creare i **paths** per i nostri links: *Prefix + _path*.

Esempi:

- **root_path**
- **mockups_page_a_path**
- **mockups_page_b_path**



## Implementiamo le due pagine di mockups

***codice 02 - .../views/mockups/page_a.html.erb - line: 1***

```html+erb
<h1> Pagina A </h1>
<p> Benvenuti nella pagina  A </p>
<br>
<%= link_to 'andiamo alla pagina B', mockups_page_b_path %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/03-mockups/01_02-views-mockups-page_a.html.erb)


***codice 03 - .../views/mockups/page_b.html.erb - line: 1***

```html+erb
<h1> Pagina B </h1>
<p> Benvenuti nella pagina  B </p>
<p> <%= link_to 'Torniamo alla pagina A',mockups_page_a_path %> </p>
<p> <%= link_to 'Torniamo alla homepage', root_path %> </p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/03-mockups/01_03-views-mockups-page_b.html.erb)



## Verifichiamo preview

Attiviamo il webserver

```bash
$ sudo service postgresql start
$ rails s
```

e vediamo i vari URLs sul nostro browser:

- https://mycloud9path.amazonaws.com
- https://mycloud9path.amazonaws.com/mockups/page_a
- https://mycloud9path.amazonaws.com/mockups/page_b

adesso invece di scrivere sull'URL, per spostarsi tra le pagine, possiamo cliccare sui links.

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/03-mockups/01_fig04-views-mockups-page_a.png)

![fig05](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/03-mockups/01_fig05-views-mockups-page_b.png)



## Salviamo su git

```bash
$ git add -A
$ git commit -m "implement mockups"
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (msp) $ git add -A
user_fb:~/environment/bl7_0 (msp) $ git commit -m "implement mockups"
[msp 92f76c7] implement mockups
 6 files changed, 34 insertions(+)
 create mode 100644 app/controllers/mockups_controller.rb
 create mode 100644 app/helpers/mockups_helper.rb
 create mode 100644 app/views/mockups/page_a.html.erb
 create mode 100644 app/views/mockups/page_b.html.erb
 create mode 100644 test/controllers/mockups_controller_test.rb
user_fb:~/environment/bl7_0 (msp) $ 
```



## Chiudiamo il branch

Se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge msp
$ git branch -d msp
```

> Prima git andava inizializzato a parte ed il ramo principale era chiamato **master**.
> Da Rails 7 lo hanno integrato nell'installazione ed il ramo principale lo hanno chiamato **main**.

Esempio:

```bash
user_fb:~/environment/bl7_0 (msp) $ git checkout main
Switched to branch 'main'
user_fb:~/environment/bl7_0 (main) $ git merge msp
Updating d64bcf1..92f76c7
Fast-forward
 app/controllers/mockups_controller.rb       |  7 +++++++
 app/helpers/mockups_helper.rb               |  2 ++
 app/views/mockups/page_a.html.erb           |  4 ++++
 app/views/mockups/page_b.html.erb           |  4 ++++
 config/routes.rb                            |  4 ++++
 test/controllers/mockups_controller_test.rb | 13 +++++++++++++
 6 files changed, 34 insertions(+)
 create mode 100644 app/controllers/mockups_controller.rb
 create mode 100644 app/helpers/mockups_helper.rb
 create mode 100644 app/views/mockups/page_a.html.erb
 create mode 100644 app/views/mockups/page_b.html.erb
 create mode 100644 test/controllers/mockups_controller_test.rb
user_fb:~/environment/bl7_0 (main) $ git branch
* main
  msp
user_fb:~/environment/bl7_0 (main) $ git branch -d msp
Deleted branch msp (was 92f76c7).
user_fb:~/environment/bl7_0 (main) $ git branch
* main
user_fb:~/environment/bl7_0 (main) $ 
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/02-git/03-daily_routine.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/04-heroku/01-heroku_story.md)
