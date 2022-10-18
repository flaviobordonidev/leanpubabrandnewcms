# <a name="top"></a> Cap 4.5 - AWS S3 su ActiveRecord

In questo capitolo implementiamo l'upload dei files su AWS S3 tramite ActiveRecord.
Effettuiamo il collegamento con S3 usando i secrests criptati.



## Risorse interne

- [99-rails_references/active_storage/aws_s3]()


## Risorse esterne

- [Rails guide - Active Storage - Amazon S3](https://guides.rubyonrails.org/active_storage_overview.html#s3-service-amazon-s3-and-s3-compatible-apis)
- [Cosa vuol dire "require = False" nel Gemfile](https://stackoverflow.com/questions/4800721/ruby-what-does-require-false-in-gemfile-mean#:~:text=require%3A%20false%20tells%20Bundler.,search%20path%20setup%20by%20bundler.)
- [AWS SDK for Ruby - Version 3](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/index.html)
- [Backup PostgreSQL to Amazon S3](https://render.com/docs/backup-postgresql-to-s3)



## Apriamo il branch "AWS S3 on ActiveRecord"

```bash
$ git checkout -b asar
```



## Installiamo aws-sdk per comunicare con amazon web service S3

Seguendo la guida Rails installiamo `gem "aws-sdk-s3", require: false`.

> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/aws-sdk-s3)
>
> facciamo riferimento al [tutorial github della gemma](http://github.com/aws/aws-sdk-ruby)
>
> facciamo riferimento alla [Rails guide - Active Storage - Amazon S3](https://guides.rubyonrails.org/active_storage_overview.html#s3-service-amazon-s3-and-s3-compatible-apis)

***Codice 01 - .../Gemfile - linea:58***

```ruby
# API clients for AWS S3 services. Comunicazione con Amazon Web Service S3 per ActiveStorage
gem 'aws-sdk-s3', '~> 1.114', require: false
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/05_01-gemfile.rb)

> l'opzione `require: false` è indicata nella *Rails guide* e permette di installare la gemma ma di **non** caricarla per ogni processo. Ciò consente di risparmiare memoria nei principali processi dell'app e riduce il tempo di avvio. Le prestazioni dell'app, tuttavia, non dovrebbero essere influenzate anche se carichiamo la gemma in ogni processo.


Eseguiamo l'installazione della gemma con bundle

```bash
$ bundle install
```



## Verifichiamo connessione da rails console

- [AWS SDK for Ruby - Version 3](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/index.html)

Attivando `aws-sdk-s3` dalla rails console possiamo connetterci ai nostri buckets su Amazon aws-s3.

```bash
$ rails c
> require "aws-sdk-s3"
> s3 = Aws::S3::Client.new
> s3 = Aws::S3::Client.new(region: 'us-east-1')
> s3 = Aws::S3::Client.new(region: 'us-east-1', access_key_id: 'BJLS6UI4FQTNWREYNI41', secret_access_key: 'A2Y0CbGgeu1g72SQUxdB9Lc7NLem5i3boknDsxFq')
> resp = s3.list_buckets
> resp.buckets.map(&:name)
```

> Visto che sul *Gemfile* abbiamo indicato l'opzione `require: false` per caricare la gemma dobbiamo esplicitamente richiederla con `require "aws-sdk-s3"`.

> Per accedere al client dobbiamo passare *:region*, *:access_key_id* e *secret_access_key*.

Esempio:

```bash
ubuntu@ubuntufla:~/bl7_0 (asar)$rails c
Loading development environment (Rails 7.0.2.2)
3.1.1 :001 > s3 = Aws::S3::Client.new
(irb):1:in '<main>': uninitialized constant Aws (NameError)
3.1.1 :002 > require "aws-sdk-s3"
 => true 
3.1.1 :003 > s3 = Aws::S3::Client.new
/home/ubuntu/.rvm/gems/ruby-3.1.1/gems/aws-sdk-s3-1.113.0/lib/aws-sdk-s3/plugins/s3_signer.rb:23:in 'block in <class:S3Signer>': No region was provided. Configure the `:region` option or export the region name to ENV['AWS_REGION'] (Aws::Errors::MissingRegionError)
3.1.1 :004 > 
3.1.1 :004 > s3 = Aws::S3::Client.new(region: 'us-east-1')
/home/ubuntu/.rvm/gems/ruby-3.1.1/gems/aws-sigv4-1.4.0/lib/aws-sigv4/signer.rb:627:in 'extract_credentials_provider': missing credentials, provide credentials with one of the following options: (Aws::Sigv4::Errors::MissingCredentialsError)
  - :access_key_id and :secret_access_key
  - :credentials
  - :credentials_provider
3.1.1 :005 > 
3.1.1 :005 > s3 = Aws::S3::Client.new(region: 'us-east-1', access_key_id: 'BJLS6UI4FQTNWREYNI41', secret_access_key: 'A2Y0CbGgeu1g72SQUxdB9Lc7NLem5i3boknDsxFq')
 => #<Aws::S3::Client> 
3.1.1 :006 > 
3.1.1 :006 > resp = s3.list_buckets
 => 
#<struct Aws::S3::Types::ListBucketsOutput
... 
3.1.1 :007 > resp.buckets.map(&:name)
 => ["bl7-0-dev", "bl7-0-prod", "elisinfo-dev", "elisinfo-prod", "integram-agency-blog-dev", "integram-agency-blog-prod", "rebisworld-dev", "rebisworld-prod", "rebisworld-pub"] 
3.1.1 :008 > 

#vecchi output

2.6.3 :002 > s3 = Aws::S3::Client.new
 => #<Aws::S3::Client> 
2.6.3 :003 > resp = s3.list_buckets
 => #<struct Aws::S3::Types::ListBucketsOutput buckets=[#<struct Aws::S3::Types::Bucket name="brandnewcms-dev", creation_date=2018-04-07 12:04:24 UTC>, #<struct Aws::S3::Types::Bucket name="elisinfo", creation_date=2017-05-24 10:57:59 UTC>, #<struct Aws::S3::Types::Bucket name="elisinfo-dev", creation_date=2017-05-24 17:25:22 UTC>, #<struct Aws::S3::Types::Bucket name="flatest", creation_date=2016-01-29 12:49:33 UTC>, #<struct Aws::S3::Types::Bucket name="myapp-dev", creation_date=2019-01-12 22:15:18 UTC>, #<struct Aws::S3::Types::Bucket name="myapp-prod", creation_date=2019-01-13 09:07:40 UTC>, #<struct Aws::S3::Types::Bucket name="rebisworldbr-dev", creation_date=2018-06-26 10:15:37 UTC>, #<struct Aws::S3::Types::Bucket name="rebisworldbr-prod", creation_date=2018-06-26 10:58:54 UTC>, #<struct Aws::S3::Types::Bucket name="rigenerabatterie-dev", creation_date=2019-03-10 17:05:43 UTC>, #<struct Aws::S3::Types::Bucket name="rigenerabatterie-prod", creation_date=2019-03-10 17:06:05 UTC>, #<struct Aws::S3::Types::Bucket name="s5beginning-dev", creation_date=2019-08-08 14:05:40 UTC>, #<struct Aws::S3::Types::Bucket name="temi-it", creation_date=2016-01-19 11:12:15 UTC>], owner=#<struct Aws::S3::Types::Owner display_name="flavio.bordoni.dev", id="be65e7f9d1b2710ccc04c3490064a385fe5d41592f1e0d0c69a28b3a6f61f723">> 
2.6.3 :004 > resp.buckets.map(&:name)
 => ["brandnewcms-dev", "elisinfo", "elisinfo-dev", "flatest", "myapp-dev", "myapp-prod", "rebisworldbr-dev", "rebisworldbr-prod", "rigenerabatterie-dev", "rigenerabatterie-prod", "s5beginning-dev", "temi-it"] 
2.6.3 :005 > 
```

Proviamo a leggere il contenuto del bucket "ubuntudream-dev"

```bash
> resp = s3.list_objects(bucket: 'bl7-0-dev', max_keys: 2)
> resp.contents.each do |object|
 >  puts "#{object.key} => #{object.etag}"
 > end
```

Esempio:

```bash
3.1.1 :009 > resp = s3.list_objects(bucket: 'bl7-0-dev', max_keys: 2)
 => #<struct Aws::S3::Types::ListObjectsOutput is_truncated=false, marker="", next_marker=nil, contents=[], name="bl7-0-dev", prefix="", delimiter=nil, max_keys=2, common_prefixes=[], encoding_type="url"> 
3.1.1 :010 > resp.contents.each do |object|
3.1.1 :011 >   puts "#{object.key} => #{object.etag}"
3.1.1 :012 > end
 => [] 
3.1.1 :013 > 
```

> Effettivamente è vuoto perché ancora non abbiamo messo nessun file al suo interno.

Carico dei dati e faccio di nuovo la prova:

```bash
3.1.1 :007 > resp = s3.list_objects(bucket: 'bl7-0-dev', max_keys: 2)
 => 
#<struct Aws::S3::Types::ListObjectsOutput
... 
3.1.1 :008 > resp.contents.each do |object|
3.1.1 :009 >   puts "#{object.key} => #{object.etag}"
3.1.1 :010 > end
1fmi7qbeonldnaswb0mqo1406y1q => "e7e14944c65a8859dd4e189688a01de9"
22jopess1jqjr8p14fnyi5bh0oi0 => "8fdd02952ab8e9953f1be81941884a9f"
 =>                           
[#<struct Aws::S3::Types::Object
  key="1fmi7qbeonldnaswb0mqo1406y1q",
  last_modified=2022-08-11 12:43:52 UTC,
  etag="\"e7e14944c65a8859dd4e189688a01de9\"",
  checksum_algorithm=[],      
  size=2042,                  
  storage_class="STANDARD",   
  owner=#<struct Aws::S3::Types::Owner display_name="flavio.bordoni.dev", id="be65e7f9d1b2710ccc04c3490064a385fe5d41592f1e0d0c69a28b3a6f61f723">>,
 #<struct Aws::S3::Types::Object
  key="22jopess1jqjr8p14fnyi5bh0oi0",
  last_modified=2022-08-11 12:36:05 UTC,
  etag="\"8fdd02952ab8e9953f1be81941884a9f\"",
  checksum_algorithm=[],
  size=3288,
  storage_class="STANDARD",
  owner=#<struct Aws::S3::Types::Owner display_name="flavio.bordoni.dev", id="be65e7f9d1b2710ccc04c3490064a385fe5d41592f1e0d0c69a28b3a6f61f723">>] 
3.1.1 :011 > 
```



## Settiamo config development per Amazon S3

Nel file di configurazione dell'ambiente di sviluppo impostiamo *config.active_storage.service* su *:amazondev* al posto di *:local*. 

***codice 02 - .../app/config/environments/development.rb - line:36***

```ruby
  # Store uploaded files on the local file system (see config/storage.yml for options).
  #config.active_storage.service = :local
  config.active_storage.service = :amazondev
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/05-activestorage-filesupload/05_02-config-environments-development.rb)

La variabile `:amazondev` la creiamo nel prossimo paragrafo. 

> Visto che sia lo *sviluppo* che la *produzione* puntano entrambi ad **aws s3**, la variabile l'avremmo potuta chiamare semplicemente *:amazon* ma abbiamo preferito distinguerla per far capire didatticamente che puoi chiamarla come vuoi e per predisporci all'eventuale creazione di due utenze IAM diverse una per il bucket "myapp-dev" e l'altra per "myapp-prod".



## Implementiamo la variabile ":amazondev" nello storage.yml

Rails predispone commentata le linee di codice per effettuare il collegamento. Dobbiamo solo decommentarle ed adattarle alle nostre esigenze.

***codice 03 - .../app/config/storage.yml - line: 5***

```yaml
# Use rails credentials:edit to set the AWS secrets (as aws:access_key_id|secret_access_key)
amazondev:
  service: S3
  access_key_id: <%= Rails.application.credentials.dig(:aws, :access_key_id) %>
  secret_access_key: <%= Rails.application.credentials.dig(:aws, :secret_access_key) %>
  region: us-east-1
  bucket: ubuntudream-dev
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/05_03-config-storage.yml)


Non resta che impostare in modo sicuro, le variabili *access_key_id* e *secret_access_key*, anche dette *secrets*.



## Implementiamo le due variabili *secrets*

Implementiamo le due variabili *secrets* nel file criptato *credentials*. Per editare il file eseguire:

```bash
$ EDITOR=vim rails credentials:edit
```

Questo apre il file decrittato sul terminale usando vim. Come potrai vedere il file decrittato assomiglia ad un normale file .yml

Per editarlo:
- muoviti usando le frecce sulla tastiera
- quando vuoi inserire del testo premi "i". Quando hai finito premi "ESC"
- per salvare ":w"
- per uscire ":q"

Quando salvi rail automaticamente critta il file usando la master key.

```bash
aws:
  access_key_id: AKI...LWBYA
  secret_access_key: sx1......G2nyKdela
```

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/05_fig01-rails-encrypted-credentials.PNG)



## Per i più pignoli

Volendo essere più precisi avremmo potuto usare il nome di variabile `aws_iam_bot_ubuntudream` al posto di `aws`. 

```bash
aws_iam_bot_ubuntudream:
  access_key_id: AKI...LWBYA
  secret_access_key: sx1......G2nyKdela
```

In questo caso avremmo dovuto portare il cambiamento anche alle due chiamate su `.../app/config/storage.yml`.

***codice n/a - .../app/config/storage.yml - line: 5***

```yaml
  access_key_id: <%= Rails.application.credentials.dig(:aws_iam_bot_ubuntudream, :access_key_id) %>
  secret_access_key: <%= Rails.application.credentials.dig(:aws_iam_bot_ubuntudream, :secret_access_key) %>
```



## Verifichiamo lettura secrets nel file criptato

Verifichiamo che le variabili aws che abbiamo appena aggiunto siano correttamente implementate

```bash
$ rails c
-> Rails.application.credentials.dig(:aws, :access_key_id)   # => "AKI...LWBYA"
-> Rails.application.credentials.dig(:aws, :secret_access_key)   # => "sx1......G2nyKdela"
```



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

proviamo adesso a caricare un file per l'immagine dell'utente.

- http://192.168.64.3:3000/users

Funziona! Adesso le immagini sono caricate su aws s3 e non vengono più cancellate dopo poche ore.
ATTENZIONE! Normalmente le immagini vengono caricate subito ma a volte ci può volere del tempo prima che l'immagine venga uploadata quindi non abbiate fretta e fate un refresh dopo alcuni minuti.

Se su aws S3, entriamo nel bucket "ubuntudream-dev" vediamo il file di cui abbiamo appena fatto l'upload. (Potrebbe essere necessario fare un refresh della pagina)

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/05_fig02-bucket-myapp-dev-file_uploaded.PNG)



## Impleme AWS S3 per la produzione

Al momento quando andiamo in produzione su "render.com" non sfruttiamo il bucket che abbiamo creato su amazon ma salviamo i files in locale.
Questo non va bene. Per due motivi:

- Potrebbe non funzionare e se funziona i files sono cancellati dopo alcune ore.
- Se non fossero cancellati prenderebbero molto spazio su "render.com" che è meglio lasciare al solo codice.

Quindi è bene impostare anche per l'ambiente di produzione (quello su "render.com") che l'upload dei files sia fatto su AWS S3, nel bucket dedicato `ubuntudream-prod`.



## Settiamo config production per Amazon S3

Settiamo config production per Amazon S3. (Al posto di `:local` usiamo `:amazonprod`)

***Codice 04 - .../app/config/environments/production.rb - linea:40***

```ruby
  # Store uploaded files on the local file system (see config/storage.yml for options).
  #config.active_storage.service = :local
  config.active_storage.service = :amazonprod
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/05-activestorage-filesupload/05_03-config-storage.yml)


Aggiorniamo lo storage.yml aggiungendo `:amazonprod` con relativa configurazione. 

***codice 05 - .../app/config/storage.yml - line: 5***

```yaml
# Use rails credentials:edit to set the AWS secrets (as aws:access_key_id|secret_access_key)
amazonprod:
  service: S3
  access_key_id: <%= Rails.application.credentials.dig(:aws, :access_key_id) %>
  secret_access_key: <%= Rails.application.credentials.dig(:aws, :secret_access_key) %>
  region: us-east-1
  bucket: ubuntudream-prod
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/05-activestorage-filesupload/05_05-config-storage.yml)

> Nella nostra app la configurazione ha le stesse credentials di `:amazondev`. <br/>
> Questo perché le credentials sono legata all'utente IAM. <br/>
> In pratica lasciamo il solo utente IAM `bot_ubuntudream` con accesso ad entrambi i buckets `ubuntudream-dev` e `ubuntudream-prod`. <br/>
> Volendo potremmo creare un diverso utente IAM da usare solo per la produzione e qui metteremo le sue credenziali (access_key_id e secret_access_key).



## Implementiamo AWS S3 per la produzione su render.com

Abbiamo già creato nel capitolo precedente il bucket `ubuntudream-prod` su AWS S3 per mantenere distinte le immagini caricate dall'app di produzione da quelle caricate dall'app di sviluppo.

Adesso passiamo la nuova gemma in produzione caricando tutto il codice in produzione su "render.com" e successivamente passiamo le chiavi di accesso al bucket `ubuntudream-prod` di aws S3.



## aggiorniamo git 

```bash
$ git add -A
$ git commit -m "add AWS S3 connection to upload images with ActiveRecord in Production"
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge asar
$ git branch -d asar
```



## Facciamo un backup su Github

Dal nostro branch main di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```



## Publichiamo su render.com

Facciamo prima la pubblicazione con il pulsante...


Se provassimo adesso ad andare sull'URL di produzione

- https://bl7-0.herokuapp.com/

riceveremmo un errore perché non abbiamo ancora passato a render.com le variabili per collegarsi ad aws S3

> In realtà non ho ricevuto errore *_*
> Sta funzionando tutto regolarmente e non capisco come mai!?!

Il seguente passaggio che avrei inserito a livello di variabili su render.com sembra non serva farlo perché si è preso le variabili dall'applicazione rails in qualche modo!?!


## Passiamo a "render.com" le variabili per collegamento ad aws S3

"Render.com" non ha le variabili per accedere al bucket `ubuntudream-prod` che abbiamo creato su aws S3.

> NON è vero, in qualche modo si è preso anche queste variabili quando ho premuto il pulsante di deploy!?!
> Quindi questo passaggio ***NON*** serve farlo.
> Comunque lo documento caso mai possa servire in futuro.

Passiamo le variabile d'ambiente a render.com tramite web GUI.

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/05-activestorage-filesupload/05_fig03-render_environment_variables.png)

Nell'immagine ho aggiunto solo una variabile ma l'idea era di aggiungere tutte le seguenti:

- `AWS_ACCESS_KEY_ID='AKIA....JTOMA'`
- `AWS_SECRET_ACCESS_KEY='LwdJ........45KHZ'`
- `AWS_REGION='us-east-1'`
- `S3_BUCKET_NAME='bl7-0-prod'`

Solo che non è stato necessario farlo perché ha funzionato tutto anche senza dichiararle.



## verifichiamo che funziona tutto

- https://bl7-0.herokuapp.com/eg_posts

creiamo un nuovo post ed inseriamo l'immagine

- https://ubuntudream.onrender.com/users/1

Funziona! Abbiamo l'immagine. E questa è archiviata su aws S3

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/05_fig04-bucket-myapp-prod-file_uploaded.PNG)


Interessante vedere che la nostra archiviazione su AWS rimane nascosta all'utente finale.

Se sul browser facciamo click con tasto destro del mouse sull'immagine e scelgiamo la voce **inspect** si apre la finestra laterale con evidenziato il relativo codice HTML.

***codice n/a - ... - line: 1***

```html+erb
<img src="https://ubuntudream.onrender.com/rails/active_storage/representations/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--2281d72bd57e287324d669b26eb2cf9de85d69e8/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCem9MWm05eWJXRjBTU0lJYW5CbkJqb0dSVlE2RkhKbGMybDZaVjkwYjE5c2FXMXBkRnNIYVdscGFRPT0iLCJleHAiOm51bGwsInB1ciI6InZhcmlhdGlvbiJ9fQ==--601e26bf206071870ac0f04a8f48a13c9e8ba449/Ruedi%20Tschanz.jpg">
```

Possiamo vedere che l'immagine sembra sul nostro server render.com (onrender.com) ma in realtà è solo il puntamento sul database. La vera immagine è su Amazon Web Service S3.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/04_00-aws_s3-iam_full_access-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/06_00-remove_uploaded_file-it.md)
