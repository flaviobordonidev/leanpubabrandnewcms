# <a name="top"></a> Cap i18n_dynamic_database.2 - Internazionalizziamo i passaggi della lezione

Usiamo `mobility` per avere versioni in più lingue anche dei video.



## Risorse interne

- []()



## Apriamo il branch 

Continuiamo nel branch aperto nel capitolo precedente



## Usiamo mobility

Attiviamo l'internazionalizzazione sul database usando la gemma `mobility` installata precedentemente.
Indichiamo nel *model* i campi della tabella che vogliamo tradurre. 

Aggiorniamo il *model* nella sezione `# == Extensions`, sottosezione `## i18n dynamic`.

***Codice 01 - .../app/models/step.rb - linea:01***

```ruby
extend Mobility
translates :question, type: :string
translates :youtube_video_id, type: :string
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/24-dynamic-i18n/02_01-models-eg_post.rb)


> Se inseriamo il nome di una colonna già presente nella tabella quello che succede è che viene bypassata.
> Se c'erano già dei valori presenti quelli restano nella tabella ma non ci accedi da Rails perché Rails passa tramite `mobility` e mette i valori nelle tabelle create da `mobility`; la tabella per i valori tradotti di tipo :string ed una tabella per i valori tradotti di tipo :text.</br>
> Praticamente lo stesso comportamento di ActiveRecord per le immagini o ActiveText che usa Trix per testo formattato RTF (rich text file).

> Personalmente credo sia più utile rimuovere dalla tabella la colonna che inseriamo in `translates`.



## Popoliamo la tabella da console

Usiamo la console di rails per popolare la tabella del database.

```bash
$ rails c

> stp = Step.first
> stp.question
> stp.question = "Domanda in italiano"
> I18n.locale
> I18n.locale = :en
> stp.question = "Question in english"
> stp.save

> I18n.locale
> Step.first.update(question: "Change in the question")
> exit
```

Esempio:

```ruby
ubuntu@ubuntufla:~/ubuntudream (lng)$rails c
Loading development environment (Rails 7.0.4) 
3.1.1 :005 > stp = Step.first
  Step Load (0.4ms)  SELECT "steps".* FROM "steps" ORDER BY "steps"."id" ASC LIMIT $1  [["LIMIT", 1]]
 =>                                                               
#<Step:0x00007f548ddbcd90                                         
...                                                               
3.1.1 :006 > stp
 => 
#<Step:0x00007f548ddbcd90                                         
 id: 1,                                                           
 question: "Quante persone ci sono?",                             
 answer: "Risposta1\nsono contento di questa risposta ^_^",       
 lesson_id: 1,                                                    
 created_at: Tue, 15 Nov 2022 21:52:49.604251000 UTC +00:00,      
 updated_at: Mon, 19 Dec 2022 01:16:36.153316000 UTC +00:00,      
 youtube_video_id: "ee1THdOuMoA">                                 
3.1.1 :007 > stp.question
  Mobility::Backends::ActiveRecord::KeyValue::StringTranslation Load (0.5ms)  SELECT "mobility_string_translations".* FROM "mobility_string_translations" WHERE "mobility_string_translations"."translatable_id" = $1 AND "mobility_string_translations"."translatable_type" = $2 AND "mobility_string_translations"."key" = $3  [["translatable_id", 1], ["translatable_type", "Step"], ["key", "question"]]                                                  
 => nil                                                              
3.1.1 :009 > I18n.locale
 => :it 
3.1.1 :010 > I18n.locale = :en
 => :en 
3.1.1 :011 > stp.question
 => nil 
3.1.1 :002 > I18n.locale
 => :it 
3.1.1 :003 > stp = Step.first
  Step Load (3.3ms)  SELECT "steps".* FROM "steps" ORDER BY "steps"."id" ASC LIMIT $1  [["LIMIT", 1]]
 =>                                                                                  
#<Step:0x00007f57076cc720                                                            
...
3.1.1 :008 > stp.question = "la versione in italiano tradotta di: Quante persone ci sono?"
 => "la versione in italiano tradotta di: Quante persone ci sono?" 
3.1.1 :009 > stp.question
 => "la versione in italiano tradotta di: Quante persone ci sono?" 
3.1.1 :010 > stp
 => 
#<Step:0x00007f57076cc720                                                                                      
 id: 1,                                                                                                        
 question: "Quante persone ci sono?",                                                                          
 answer: "Risposta1\nsono contento di questa risposta ^_^",                                                    
 lesson_id: 1,                                                                                                 
 created_at: Tue, 15 Nov 2022 21:52:49.604251000 UTC +00:00,                                                   
 updated_at: Mon, 19 Dec 2022 01:16:36.153316000 UTC +00:00,                                                   
 youtube_video_id: "ee1THdOuMoA">                                                                              
3.1.1 :011 > I18n.locale = :en
 => :en 
3.1.1 :012 > stp
 => 
#<Step:0x00007f57076cc720                                                             
 id: 1,                                                                               
 question: "Quante persone ci sono?",                                                 
 answer: "Risposta1\nsono contento di questa risposta ^_^",                           
 lesson_id: 1,                                                                        
 created_at: Tue, 15 Nov 2022 21:52:49.604251000 UTC +00:00,                          
 updated_at: Mon, 19 Dec 2022 01:16:36.153316000 UTC +00:00,                          
 youtube_video_id: "ee1THdOuMoA">                                                     
3.1.1 :013 > stp.question
 => nil 
3.1.1 :014 > stp.question = "The english version of: How many persons there are?"
 => "The english version of: How many persons there are?" 
3.1.1 :015 > stp.question
 => "The english version of: How many persons there are?" 
3.1.1 :016 > stp
3.1.1 :016 > stp.save
3.1.1 :017 > exit
```

> Il primo record ha già un contenuto nella colonna "question". Ma quando lo interroghiamo interviene `mobility` e ci da `nil`. Quando mettiamo le traduzioni vediamo queste.





## seed

Di seguito mostriamo come popolare la tabella in automatico ma noi eseguiremo la procedura manuale descritta nel prossimo capitolo.

***codice 04 - .../db/seeds.rb - line:1***

```ruby
puts "setting Steps data with I18n :it :en"
i18n.locale = :it
Step.new(question: "Qual è il tuo nome?").save
i18n.locale = :en
Step.last.update(question: "What is your name?")
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/24-dynamic-i18n/02_02-db-migrate-xxx_create_eg_post_transaltions.rb)


Per popolare il database con i seed si possono usare i comandi:

```bash
$ rake db:seed
o
$ rake db:setup
```

- il `rake db:seed` esegue nuovamente tutti i comandi del file *db/seeds.rb*. Quindi dobbiamo commentare tutti i comandi già eseguiti altrimenti si creano dei doppioni. Gli stessi comandi possono essere eseguiti manualmente sulla rails console e si lascia l'esecuzione del seed solo in fase di inizializzazione di tutto l'applicativo.
- il `rake db:setup` ricrea TUTTO il database e lo ripopola con *db/seeds.rb*. Quindi tutto il database è azzerato ed eventuali records presenti sono eliminati.



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

- http://192.168.64.3:3000/authors/eg_posts

Le modifiche sono già presenti anche nel preview. Anche la modifica. Possiamo verificarlo cambiando la lingua nella barra di navigazione in alto.
Se creiamo un articolo in italiano possiamo mettere la versione inglese cambiando prima la lingua e poi sovrascriviamo la parte italiana. Questo farà sì che quando siamo in inglese vediamo l'inglese e se torniamo all'italiano lo rivediamo in italiano.


## Archiviamo su git

```bash
$ git add -A
$ git commit -m "add i18n eg_posts seeds"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku igg:main
$ heroku run rake db:migrate
```

I> Lato produzione su heroku c'è un database indipendente da quello di sviluppo quindi risulta vuoto.

per popolare il database di heroku basta aprire la console con il comando:

```bash
$ heroku run rails c
```

E rieseguire i passi già fatti nel paragrafo precedentemente






## Archiviamo su git

```bash
$ git add -A
$ git commit -m "New layout entrance for login"
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge siso
$ git branch -d siso
```



## Facciamo un backup su Github

Dal nostro branch main di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```


## In produzione

Andiamo su render.com e premiamo il bottone ^_^



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/04_00-devise-login_logout-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/08-authentication_i18n/01_00-devise_i18n-it.md)





---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/24-dynamic-i18n/01_00-install_i18n_globalize-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/25-nested_forms_with_stimulus/01_00-stimulus-mockup-it.md)
