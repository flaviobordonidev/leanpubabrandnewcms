# <a name="top"></a> Cap 18.4 - AWS S3 su ActiveRecord

In questo capitolo implementiamo l'upload dei files su AWS S3 tramite ActiveRecord.
Effettuiamo il collegamento con S3 usando i secrests criptati.



## Risorse interne

- [99-rails_references/active_storage/aws_s3]()



## Apriamo il branch "AWS S3 on ActiveRecord"

```bash
$ git checkout -b asar
```



## installiamo aws-sdk per comunicare con amazon web service S3

Seguendo la guida Rails installiamo " gem "aws-sdk-s3", require: false " invece di tutta la suite " gem 'aws-sdk', '~> 3.0', '>= 3.0.1' "

> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/aws-sdk-s3)
>
> facciamo riferimento al [tutorial github della gemma](http://github.com/aws/aws-sdk-ruby)

***codice 01 - .../Gemfile - line: 25***

```ruby
# API clients for AWS S3 services. Comunicazione con Amazon Web Service S3 per ActiveStorage
gem 'aws-sdk-s3', '~> 1.60', '>= 1.60.1'
```
[tutto il codice](#01-18-04_01all)

Attenzione:
In passato si doveva aggiungere l'opzione "require: false", ma oggi non serve più 

```ruby
# API clients for AWS S3 services. Comunicazione con Amazon Web Service S3 per ActiveStorage
gem "aws-sdk-s3", require: false
```

Eseguiamo l'installazione della gemma con bundle

```bash
$ bundle install
```



## Verifichiamo connessione da rails console

Entrando in console da awsC9 siamo già collegati ad Amazon e possiamo vedere tutti i buckets

```bash
$ rails c
-> s3 = Aws::S3::Client.new
-> resp = s3.list_buckets
-> resp.buckets.map(&:name)


2.6.3 :002 > s3 = Aws::S3::Client.new
 => #<Aws::S3::Client> 
2.6.3 :003 > resp = s3.list_buckets
 => #<struct Aws::S3::Types::ListBucketsOutput buckets=[#<struct Aws::S3::Types::Bucket name="brandnewcms-dev", creation_date=2018-04-07 12:04:24 UTC>, #<struct Aws::S3::Types::Bucket name="elisinfo", creation_date=2017-05-24 10:57:59 UTC>, #<struct Aws::S3::Types::Bucket name="elisinfo-dev", creation_date=2017-05-24 17:25:22 UTC>, #<struct Aws::S3::Types::Bucket name="flatest", creation_date=2016-01-29 12:49:33 UTC>, #<struct Aws::S3::Types::Bucket name="myapp-dev", creation_date=2019-01-12 22:15:18 UTC>, #<struct Aws::S3::Types::Bucket name="myapp-prod", creation_date=2019-01-13 09:07:40 UTC>, #<struct Aws::S3::Types::Bucket name="rebisworldbr-dev", creation_date=2018-06-26 10:15:37 UTC>, #<struct Aws::S3::Types::Bucket name="rebisworldbr-prod", creation_date=2018-06-26 10:58:54 UTC>, #<struct Aws::S3::Types::Bucket name="rigenerabatterie-dev", creation_date=2019-03-10 17:05:43 UTC>, #<struct Aws::S3::Types::Bucket name="rigenerabatterie-prod", creation_date=2019-03-10 17:06:05 UTC>, #<struct Aws::S3::Types::Bucket name="s5beginning-dev", creation_date=2019-08-08 14:05:40 UTC>, #<struct Aws::S3::Types::Bucket name="temi-it", creation_date=2016-01-19 11:12:15 UTC>], owner=#<struct Aws::S3::Types::Owner display_name="flavio.bordoni.dev", id="be65e7f9d1b2710ccc04c3490064a385fe5d41592f1e0d0c69a28b3a6f61f723">> 
2.6.3 :004 > resp.buckets.map(&:name)
 => ["brandnewcms-dev", "elisinfo", "elisinfo-dev", "flatest", "myapp-dev", "myapp-prod", "rebisworldbr-dev", "rebisworldbr-prod", "rigenerabatterie-dev", "rigenerabatterie-prod", "s5beginning-dev", "temi-it"] 
2.6.3 :005 > 
```

Proviamo a leggere il contenuto del bucket "s5beginning-dev"

```bash
-> resp = s3.list_objects(bucket: 's5beginning-dev', max_keys: 2)
-> resp.contents.each do |object|
-->  puts "#{object.key} => #{object.etag}"
--> end

2.6.3 :005 > resp = s3.list_objects(bucket: 's5beginning-dev', max_keys: 2)                  
 => #<struct Aws::S3::Types::ListObjectsOutput is_truncated=false, marker="", next_marker=nil, contents=[], name="s5beginning-dev", prefix="", delimiter=nil, max_keys=2, common_prefixes=[], encoding_type="url"> 
2.6.3 :006 > resp.contents.each do |object|
2.6.3 :007 >     puts "#{object.key} => #{object.etag}"
2.6.3 :008?>   end
 => [] 
2.6.3 :009 > 
```

Effettivamente è vuoto perché ancora non abbiamo messo nessun file al suo interno.

Se vi state chiedendo come fa la console ad avere autorizzazione a leggere nel bucket... me lo sto chiedendo anche io !??
Scherzo. E' semplicemente perché stiamo lavorando con aws cloud9 e l'utente che lo sta usando "user_fb" ha le autorizzazioni anche per aws S3.

Per fare una prova "dall'esterno" possiamo usare la console di heroku ($ heroku run rails c).
E questa è una prova che facciamo alla fine del capitolo perché prima di poterlo usare dobbiamo spostare su heroku la nuova gemma appena installata.



## Settiamo config development per Amazon S3

Nel file di configurazione dell'ambiente di sviluppo impostiamo "config.active_storage.service" su ":amazondev" al posto di ":local". La variabile ":amazondev" la creiamo nel prossimo paragrafo. Visto che sia lo sviluppo che la produzione puntano ad aws s3 la variabile l'avremmo potuta chiamare semplicemente ":amazon" ma abbiamo preferito distinguerla per far capire didatticamente che puoi chiamarla come vuoi e per predisporci all'eventuale creazione di due utenze IAM diverse una per il bucket "myapp-dev" e l'altra per "myapp-prod".

***codice 02 - .../app/config/environments/development.rb - line: 31***

```ruby
  # Store uploaded files on the local file system (see config/storage.yml for options).
  #config.active_storage.service = :local
  config.active_storage.service = :amazondev
```

[tutto il codice](#01-18-04_02all)



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
  bucket: s5beginning-dev
```

[tutto il codice](#01-18-04_03all)


Non resta che impostare in modo sicuro, le variabili *access_key_id* e *secret_access_key*, anche dette *secrets*.



## Implementiamo i due secrets

Implementiamo le due secrets nel file criptato "credentials". Per editare il file eseguire:

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

![Fig. 01](images/01-beginning/11-activestorage-filesupload/04_01-rails-encrypted-credentials.png)


Volendo essere più precisi avremmo potuto usare il più completo *aws_iam_bot_bl6_0* al posto *aws*. 
In questo caso avremmo dovuto portare il cambiamento anche alle due chiamate su *.../app/config/storage.yml*.

```bash
  access_key_id: <%= Rails.application.credentials.dig(:aws_iam_bot_bl6_0, :access_key_id) %>
  secret_access_key: <%= Rails.application.credentials.dig(:aws_iam_bot_bl6_0, :secret_access_key) %>
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
$ sudo service postgresql start
$ rails s
```

proviamo adesso a caricare un file.

- https://mycloud9path.amazonaws.com/eg_posts

Funziona! Adesso le immagini sono caricate su aws s3 e non vengono più cancellate dopo poche ore.
ATTENZIONE! Normalmente le immagini vengono caricate subito ma a volte ci può volere del tempo prima che l'immagine venga uploadata quindi non abbiate fretta e fate un refresh dopo alcuni minuti.

Se su aws S3, entriamo nel bucket "bl6-0-dev" vediamo il file di cui abbiamo appena fatto l'upload. (Potrebbe essere necessario fare un refresh della pagina)

![Fig. 02](images/01-beginning/11-activestorage-filesupload/04_02-bucket-myapp-dev-file_uploaded.png)



## Implementiamo AWS S3 per la produzione sul serve locale

Questo paragrafo non serve per la produzione su Heroku. Lo implementiamo a scopo didattico per far vedere come implementare l'ambiente di produzione sullo stesso server dello sviluppo.

Settiamo config production per Amazon S3. (Al posto di ":local" usiamo ":amazonprod")

***codice 04 - .../app/config/environments/production.rb - line: 38***

```ruby
  # Store uploaded files on the local file system (see config/storage.yml for options).
  #config.active_storage.service = :local
  config.active_storage.service = :amazonprod
```

[tutto il codice](#01-18-04_04all)

Aggiorniamo lo storage.yml aggiungendo ":amazonprod" con relativa configurazione. (al momento con le stesse credentials di ":amazondev". Ma in seguito creeremo un utente IAM per la produzione e qui metteremo le sue credenziali. Oppure lasciamo il solo utente IAM "bot_myapp" con accesso ai due buckets "myapp-dev" e "myapp-prod")

***codice 05 - .../app/config/storage.yml - line: 5***

```yaml
# Use rails credentials:edit to set the AWS secrets (as aws:access_key_id|secret_access_key)
amazonprod:
  service: S3
  access_key_id: <%= Rails.application.credentials.dig(:aws, :access_key_id) %>
  secret_access_key: <%= Rails.application.credentials.dig(:aws, :secret_access_key) %>
  region: us-east-1
  bucket: bl6-0-prod
```

[tutto il codice](#01-18-04_05all)


Nel frattempo avremmo già creato il nuovo bucket "bl6-0-prod" su AWS S3 per mantenere distinte le immagini caricate come development da quelle caricate in produzione. (I passaggi sono gli stessi fatti per bl6-0-dev)



## Implementiamo AWS S3 per la produzione su Heroku

Creiamo il nuovo bucket "bl6-0-prod" su AWS S3 per mantenere distinte le immagini caricate come development da quelle caricate in produzione. (I passaggi sono gli stessi fatti per bl6-0-dev).

Adesso passiamo la nuova gemma in produzione caricando tutto il codice con "git push" e successivamente passiamo le chiavi di accesso al bucket "bl6-0-prod" di aws S3 .



## aggiorniamo git 

```bash
$ git add -A
$ git commit -m "add AWS S3 connection to upload images with ActiveRecord in Production"
```



## Publichiamo su heroku

```bash
$ git push heroku asar:master
```

Se provassimo adesso ad andare sull'URL di produzione

- https://bl6-0.herokuapp.com/

riceveremmo un errore

![Fig. 03](images/01-beginning/11-activestorage-filesupload/04_03-heroku-application_error.png)

Questo perché non abbiamo ancora passato ad heroku le variabili per collegarsi ad aws S3



## Passiamo ad Heroku variabili per collegamento ad aws S3

Heroku non ha le variabili per accedere al bucket "myapp-prod" che abbiamo creato su aws S3.
Passiamo le variabile d'ambiente ad heroku via terminale

```bash
$ heroku config:set AWS_ACCESS_KEY_ID='AKIA....JTOMA'
$ heroku config:set AWS_SECRET_ACCESS_KEY='LwdJ........45KHZ'
$ heroku config:set AWS_REGION='us-east-1'
$ heroku config:set S3_BUCKET_NAME='bl6-0-prod'
```

Le avremmo potute passare anche tramite web GUI di heroku.



## verifichiamo che funziona tutto

- https://myapp-1-blabla.herokuapp.com/example_posts

creiamo un nuovo post ed inseriamo l'immagine

- https://myapp-1-blabla.herokuapp.com/example_posts/10

Funziona! Abbiamo l'immagine. E questa è archiviata su aws S3

![Fig. 04](images/01-beginning/11-activestorage-filesupload/04_04-bucket-myapp-prod-file_uploaded.png)


Interessante vedere che la nostra archiviazione su AWS rimane nascosta all'utente finale.

Se sul browser facciamo click con tasto destro del mouse sull'immagine e scelgiamo la voce **inspect** si apre la finestra laterale con evidenziato il relativo codice HTML.

***codice n/a - ... - line: 1***

```html+erb
<img src="https://s5beginning.herokuapp.com/rails/active_storage/representations/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--8a64acf62bd23522d13f983ab83ca26c6cdc72cd/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCam9MY21WemFYcGxTU0lNTkRBd2VEUXdNQVk2QmtWVSIsImV4cCI6bnVsbCwicHVyIjoidmFyaWF0aW9uIn19--a645c12ff9721ed60214122b6cd9df735ff736ae/samuel-zeller-34775-unsplash.jpg">
```

Possiamo vedere che l'immagine sembra sul nostro server heroku ma in realtà è solo il puntamento sul database. La vera immagine è su Amazon Web Service S3.



## Verifichiamo connessione ad aws S3 da heroku console

  #DAFA

```
> s3 = Aws::S3::Resource.new(region: 'us-east-1')
Aws::Sigv4::Errors::MissingCredentialsError: missing credentials, provide credentials with one of the following options:
  - :access_key_id and :secret_access_key
  - :credentials
  - :credentials_provider
        from (irb):2:in `new'
        from (irb):2

# Se le passiamo sbagliate lui non ci da immediatamente un errore

> s3 = Aws::S3::Resource.new(region: 'us-east-1', access_key_id: 'BULLABALLA', secret_access_key: 'NonSonoQuellaGiusta')

# l'errore ci viene dato quando proviamo ad accedere ai buckets
> bk = s3.bucket('s5beginning-dev')
> obj = s3.bucket('s5beginning-dev').object('miofile')
> obj.upload_file(filepath)

> cs3 = Aws::S3::Client.new(region: 'eu-central-1', access_key_id: 'AKIxxxBYA', secret_access_key: 'sx1xxxKdela')
```



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

- https://mycloud9path.amazonaws.com/users

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

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout master
$ git merge asar
$ git branch -d asar
```



## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin master
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
