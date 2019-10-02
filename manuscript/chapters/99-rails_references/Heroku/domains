# Gestione dei domini


Risorse web:

* https://devcenter.heroku.com/articles/custom-domains
* 




## I Domini da aggiungere al provider (godaddy)

Dobbiamo aggiungere principalmente 2 domini:

* www.example.com
* example.com (questo si chiama "root domain" e non tutti i providers lo gestiscono)
 



## Rinomina app su heroku

Verifichiamo il dominio 

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ heroku domains
~~~~~~~~

Rinominando l'app diamo un nuovo dominio

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ heroku rename myapp-1-blabla
~~~~~~~~




## Associa un dominio ad un'app di Heroku 

Per aggiungere un dominio (ad esempio un nostro dominio su GoDaddy), usiamo il comando "heroku domains:add" 

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ heroku domains:add www.example.com
~~~~~~~~




# Disassocia app su Heroku ad un dominio su godaddy

Per rimuovere da un'app su Heroku un dominio (ad esempio un nostro dominio su GoDaddy), usiamo il comando "heroku domains:remove" 

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ heroku domains:remove www.example.com
~~~~~~~~




## Esempio 1 : rigenerabatterie

Associamo il dominio che è su godaddy all'applicazione rails in produzione su Heroku.
Apriamo Cloud9 sul workspace "brandnewcms" che punta all'applicazione heroku "rigenerabatterie2" che non ha nessun dominio collegato.
Aggiungiamo il dominio

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ heroku domains:add www.rigenerabatterie.it


flaviobordonidev:~/workspace/brandnewcms (niu) $ heroku domains:add www.rigenerabatterie.it
Adding www.rigenerabatterie.it to ⬢ rigenerabatterie2... done
 ▸    Configure your app's DNS provider to point to the DNS Target secure-capybara-bjsqzvil9fbk8jpzx0av4kx5.herokudns.com.
 ▸    For help, see https://devcenter.heroku.com/articles/custom-domains

The domain www.rigenerabatterie.it has been enqueued for addition
 ▸    Run heroku domains:wait 'www.rigenerabatterie.it' to wait for completion
~~~~~~~~

Adesso che abbiamo aggiunto il domino dobbiamo puntare i DNS del nostro provider (nel nostro caso GoDaddy).

Riverifichiamo i domini

~~~~~~~~
$ heroku domains


flaviobordonidev:~/workspace/brandnewcms (niu) $ heroku domains
=== rigenerabatterie2 Heroku Domain
rigenerabatterie2.herokuapp.com

=== rigenerabatterie2 Custom Domains
Domain Name              DNS Record Type  DNS Target
───────────────────────  ───────────────  ──────────────────────────────────────────────────────
www.rigenerabatterie.it  CNAME            secure-capybara-bjsqzvil9fbk8jpzx0av4kx5.herokudns.com
~~~~~~~~

ATTENZIONE! 
Non lasciamoci ingannare dal "DNS Target"
il CNAME da inserire su godaddy è "rigenerabatterie2.herokuapp.com" e non "secure-capybara-bjsqzvil9fbk8jpzx0av4kx5.herokudns.com"




### Inseriamo il CNAME su GoDaddy

Logghiamoci su godaddy ed andiamo nella gestione dei DNS del nostro dominio.

![Fig. 01](images/99-rails_references/Herokup/domains-godaddy-dominio.png)

Nella lista ci si presente già inserito un "CNAME - www - @" quindi modifichiamo questo

![Fig. 02](images/99-rails_references/Herokup/domains-godaddy-gestione_dns-step1.png)

e quindi il risultato finale è "CNAME - www - rigenerabatterie2.herokuapp.com"

![Fig. 03](images/99-rails_references/Herokup/domains-godaddy-gestione_dns-step3.png)



### verifichiamo se si è propagato

Per la verifica della corretta assegnazione del domain possiamo usare il seguente comando

~~~~~~~~
$ host www.rigenerabatterie.it


flaviobordonidev:~/workspace/brandnewcms (niu) $ host www.rigenerabatterie.it
www.rigenerabatterie.it is an alias for rigenerabatterie2.herokuapp.com.
rigenerabatterie2.herokuapp.com is an alias for us-east-1-a.route.herokuapp.com.
us-east-1-a.route.herokuapp.com has address 52.71.153.10
us-east-1-a.route.herokuapp.com has address 52.6.103.192
us-east-1-a.route.herokuapp.com has address 52.72.224.148
us-east-1-a.route.herokuapp.com has address 52.6.165.91
us-east-1-a.route.herokuapp.com has address 52.71.195.70
us-east-1-a.route.herokuapp.com has address 52.72.205.91
us-east-1-a.route.herokuapp.com has address 52.70.139.21
us-east-1-a.route.herokuapp.com has address 52.72.62.94
flaviobordonidev:~/workspace/brandnewcms (niu) $ 
~~~~~~~~

Perfetto! risulta che adesso "www.rigenerabatterie.it" è un alias per "rigenerabatterie2.herokuapp.com"




## Esempio 2 : rebisworld

Associamo il dominio che è su (senti roberto) all'applicazione rails in produzione su Heroku.
Apriamo Cloud9 sul workspace "myapp_1" che punta all'applicazione heroku "rebisworld" che non ha nessun dominio collegato.
Aggiungiamo il dominio

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ heroku domains:add www.rebisworld.com


ec2-user:~/environment/myapp (if) $ heroku domains:add www.rebisworld.com
Adding www.rebisworld.com to ⬢ rebisworld... !
 ▸    www.rebisworld.com is currently in use by another app.
~~~~~~~~

Purtroppo il dominio risulta già associato ad un'altra app di heroku.




### Togliamolo dall'altra app Heroku

Apriamo Cloud9 sul workspace "brandnewcms" che punta all'applicazione heroku "rigenerabatterie2" che ha il collegamento al dominio "www.rebisworld.com"
Ed effettuiamo la rimozione del dominio

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ heroku domains:remove www.rebisworld.com


flaviobordonidev:~/workspace/brandnewcms (niu) $ heroku domains
 ›   Warning: heroku update available from 7.0.86 to 7.21.0
=== rigenerabatterie2 Heroku Domain
rigenerabatterie2.herokuapp.com

=== rigenerabatterie2 Custom Domains
Domain Name         DNS Record Type  DNS Target
──────────────────  ───────────────  ────────────────────────────────
www.rebisworld.com  CNAME            www.rebisworld.com.herokudns.com

flaviobordonidev:~/workspace/brandnewcms (niu) $ heroku domains:remove www.rebisworld.com
Removing www.rebisworld.com from ⬢ rigenerabatterie2... done
~~~~~~~~

Adesso che l'abbiamo tolto possiamo aggiungerlo alla nostra app





### Torniamo sull'app Heroku "rebisworld"

Torniamo sul workspace "myapp_1" di aws Cloud9 che punta all'applicazione heroku "rebisworld". 
Ed effettuiamo l'aggiunta del dominio.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ heroku domains:add www.rebisworld.com


ec2-user:~/environment/myapp (if) $ heroku domains:add www.rebisworld.com
Adding www.rebisworld.com to ⬢ rebisworld... done
 ▸    Configure your app's DNS provider to point to the DNS Target clear-tern-xfcwl4lrsa4uvgzhdqpojkgt.herokudns.com.
 ▸    For help, see https://devcenter.heroku.com/articles/custom-domains

The domain www.rebisworld.com has been enqueued for addition
 ▸    Run heroku domains:wait 'www.rebisworld.com' to wait for completion
~~~~~~~~

Questa volta funziona!


Adesso che abbiamo aggiunto il domino dobbiamo puntare i DNS del nostro provider (senti roberto).

Riverifichiamo i domini

~~~~~~~~
$ heroku domains


ec2-user:~/environment/myapp (if) $ heroku domains
=== rebisworld Heroku Domain
rebisworld.herokuapp.com

=== rebisworld Custom Domains
Domain Name         DNS Record Type  DNS Target
──────────────────  ───────────────  ─────────────────────────────────────────────────
www.rebisworld.com  CNAME            clear-tern-xfcwl4lrsa4uvgzhdqpojkgt.herokudns.com
~~~~~~~~


TODO: aggiorniamo il CNAME e verifichiamo con "host"




----
----

## Aggiungiamo il ROOT DOMAIN

~~~~~~~~
$ heroku domains:add rigenerabatterie.it


$ heroku domains:add example.com
Adding example.com to ⬢ example-app... done
 ▸    Configure your app's DNS provider to point to the DNS Target
 ▸    whispering-willow-5678.herokudns.com.
 ▸    For help, see https://devcenter.heroku.com/articles/custom-domains

The domain example.com has been enqueued for addition
 ▸    Run heroku domains:wait 'example.com' to wait for completion
~~~~~~~~






## Esempio di log di rebisworld smanettando con roberto il 26/09/2019

~~~~~~~~
ubuntu:~/environment $ cd rebisworld/
ubuntu:~/environment/rebisworld (pi) $ heroku domains:add www.rebisworld.com
Adding www.rebisworld.com to ⬢ rebisworld4... !
 ▸    www.rebisworld.com is currently in use by another app.


ubuntu:~/environment/rebisworld (pi) $ heroku domains:remove www.rebisworld.com
Removing www.rebisworld.com from ⬢ rebisworld4... !
 ▸    Couldn't find that domain name.
ubuntu:~/environment/rebisworld (pi) $ heroku domains
=== rebisworld4 Heroku Domain
rebisworld4.herokuapp.com

ubuntu:~/environment/rebisworld (pi) $ heroku domains:add www.rebisworld.com
Adding www.rebisworld.com to ⬢ rebisworld4... done
 ▸    Configure your app's DNS provider to point to the DNS Target vertical-stegosaurus-j19z850ap8w4p58ulfw4837w.herokudns.com.
 ▸    For help, see https://devcenter.heroku.com/articles/custom-domains

The domain www.rebisworld.com has been enqueued for addition
 ▸    Run heroku domains:wait 'www.rebisworld.com' to wait for completion
ubuntu:~/environment/rebisworld (pi) $ heroku domains
=== rebisworld4 Heroku Domain
rebisworld4.herokuapp.com

=== rebisworld4 Custom Domains
Domain Name         DNS Record Type  DNS Target
──────────────────  ───────────────  ───────────────────────────────────────────────────────────
www.rebisworld.com  CNAME            vertical-stegosaurus-j19z850ap8w4p58ulfw4837w.herokudns.com
ubuntu:~/environment/rebisworld (pi) $ host www.rebisworld.com
www.rebisworld.com is an alias for rebisworld4.herokuapp.com.
rebisworld4.herokuapp.com has address 52.202.243.29
rebisworld4.herokuapp.com has address 52.200.81.157
rebisworld4.herokuapp.com has address 52.54.183.101
rebisworld4.herokuapp.com has address 52.6.103.192
rebisworld4.herokuapp.com has address 52.4.142.55
rebisworld4.herokuapp.com has address 34.230.212.94
rebisworld4.herokuapp.com has address 34.199.61.234
rebisworld4.herokuapp.com has address 3.227.155.128
ubuntu:~/environment/rebisworld (pi) $ heroku domains:add rebisworld.com
Adding rebisworld.com to ⬢ rebisworld4... done
 ▸    Configure your app's DNS provider to point to the DNS Target boiling-mouse-9ptn596ypefb3hcxi065lt1a.herokudns.com.
 ▸    For help, see https://devcenter.heroku.com/articles/custom-domains

The domain rebisworld.com has been enqueued for addition
 ▸    Run heroku domains:wait 'rebisworld.com' to wait for completion
ubuntu:~/environment/rebisworld (pi) $ heroku domains:remove rebisworld.com
Removing rebisworld.com from ⬢ rebisworld4... done
ubuntu:~/environment/rebisworld (pi) $ heroku domains:add rebisworld.com
Adding rebisworld.com to ⬢ rebisworld4... done
 ▸    Configure your app's DNS provider to point to the DNS Target shrouded-ape-urhn2k78aylej26qrppgkukq.herokudns.com.
 ▸    For help, see https://devcenter.heroku.com/articles/custom-domains

The domain rebisworld.com has been enqueued for addition
 ▸    Run heroku domains:wait 'rebisworld.com' to wait for completion
ubuntu:~/environment/rebisworld (pi) $ host www.rebisworld.com                                                               
www.rebisworld.com is an alias for rebisworld4.herokuapp.com.
rebisworld4.herokuapp.com has address 52.4.220.207
rebisworld4.herokuapp.com has address 34.237.174.28
rebisworld4.herokuapp.com has address 34.202.37.53
rebisworld4.herokuapp.com has address 54.208.229.218
rebisworld4.herokuapp.com has address 52.202.243.29
rebisworld4.herokuapp.com has address 52.45.74.184
rebisworld4.herokuapp.com has address 52.22.242.39
rebisworld4.herokuapp.com has address 52.20.167.39
ubuntu:~/environment/rebisworld (pi) $ host rebisworld.com
rebisworld.com has address 184.168.131.241
ubuntu:~/environment/rebisworld (pi) $ 
~~~~~~~~
