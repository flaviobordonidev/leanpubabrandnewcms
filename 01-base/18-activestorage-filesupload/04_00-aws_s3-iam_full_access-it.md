# <a name="top"></a> Cap 18.4 - Amazon Web Services S3 - IAM user full access

Iniziamo a dialogare con AWS - S3. Creiamo un utente IAM e gli diamo il permesso (CORS) pieno accesso a tutti i buckets di S3, ossia a tutta la parte di archiviazione.
Successivamente restringeremo i permessi (CORS) ai soli buckets produzione e sviluppo della nostra applicazione.



## Risorse interne

- [99-rails_references/active_storage/aws_s3]()




## Non apriamo il branch "Amazon Web Services S3"

questo capitolo è dedicato interamente alla preparazione dell'ambiente lato AWS S3
quindi non creiamo un branch sulla nostra applicazione rails



## Best practise di AWS S3

- La forma più semplice di fare upload è usare AmazonS3 PUTs che carica il file prima nel server dove gira l'applicazione Rails (Heroku nel nostro caso) e poi nel server di Amazon. Questo doppio passaggio è molto più lento. E lo stesso Heroku scoraggia fortemente questo approccio mettendo un taglio a 30s che può causare l'impossibilità di caricare files molto grandi.
- La forma più performante è usare Amazon S3 POST che passa al browser dell'utente un token di autorizzazione ed il file è direttamente caricato sul server Amazon.

Inizialmente useremo la prima forma che non richiede javascript.
Più avanti nel libro implementeremo la seconda forma più performante inserendo il codice javascript.



## Effettuiamo il login su AWS

andiamo sul sito di amazon web service https://console.aws.amazon.com e facciamo login.
Per l'upload dei files su aws useremo solo due dei servizi (services) di AWS:

- Identity and Access Management (IAM)
- il service di storage (S3) 



## Creiamo un nuovo utente - IAM user : Access key e Secret access key

E' utile avere **un utente per ogni dominio web** che ha i diritti di archiviare e visualizzare i files su AWS S3. Questo utente, che non è un utente fisico ma del codice che si autentica ed archivia o visualizza i files, viene definito "bot". Per comodità creeremo un utente "bot" per ogni nostra applicazione rails.

AWS -> Service -> IAM -> Users

- Una volta fatto login dalla Console Home AWS fare click sul service "IAM". 
- Andiamo sul link Users creiamone uno nuovo. "Add user"



## Step1

Come nome dell'utente usiamo bot+nome_app_rails; nel nostro caso "botbl7_0".

User name   : botbl7_0
Access type : Programmatic access

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/04_fig01-new-iam_user-step1.png)

"bot" convenzionalemente indica che non è un utente fisico ma un accesso per una applicazione.



## Step2

Come autorizzazioni diamo pieno accesso al nostro utente, questo ci permette di concentrarci sulla connessione tra Rails e lo storage in AWS S3.

Diamo permission *AmazonS3FullAccess* senza altre configurazioni.

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/04_fig02-new-iam_user-step2.png)

Una volta che tutto sta funzionando possiamo restringere gli accessi ed aumentare la sicurezza.



## Step3

Non aggiungiamo nessun tag

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/04_fig03-new-iam_user-step3.png)



## Step4

Visualizza il riepilogo delle scelte fatte

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/04_fig04-new-iam_user-step4.png)


## Step5

Una volta creato facciamo il download delle "user security credentials". E' un file csv dove abbiamo

- access_key_id : UL...WGERY
- secret_access_key : zx3I...ela+hg

Salviamoci i dati nel nostro programma di gestione delle passwords o comunque in un luogo sicuro.
Se torniamo sullo IAM user possiamo solo rivisualizzare la access_key_id. Per la secret_access_key dobbiamo eliminarlo e crearne uno nuovo.

![fig05](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/04_fig05-new-iam_user-step5.png)



## Connessione al bucket di amazon web service S3.

Per connetterci al "cestello dei files" (bucket) di AWS S3 abbiamo bisogno delle seguenti informazioni:

- access_key_id
- secret_access_key
- s3_region
- nome del bucket

Le credentials, ossia access_key_id e secret_access_key, identificano l'utente IAM e quindi i diritti di accesso ad AmazonWebService (nel nostro caso al solo servizio S3).
La s3_region ed il nome del bucket identificano dove archiviare i files.



## Il Bucket

creiamo il cestello (Bucket) dove archivieremo i files.

AWS -> Service -> S3

Facciamo click su create bucket.



## Step1

Che nome gli diamo?
Per i nomi dei buckets possiamo rifarci ai nomi dei databases della nostra app: 

- bl7_0_development  
- bl7_0_production

Quindi avremo i seguenti due buckets:

- bl7-0-dev
- bl7-0-prod

(l'underscore "_" non è accettato nel nome del bucket.)

Iniziamo con 

Bucket name : bl6-0-dev
Region      : US East (N. Virginia)

Nota:
la "Region: EU (Ireland)" sarebbe la scelta più saggia dal punto di vista delle prestazioni perché è più vicina all'Italia ma costa di più quindi, per risparmiare, preferisco usare US East.

![fig06](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/04_fig06-new-bucket-step1.png)



## Step2

Lasciamo le opzioni di default

![fig07](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/04_fig07-new-bucket-step2.png)



## Step3

Lasciamo le autorizzazioni di default

![fig08](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/04_fig08-new-bucket-step3.png)



## Step4

Visualizza il riepilogo delle scelte fatte

Accettiamo e creiamo il bucket.

![fig09](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/04_fig09-new-bucket-step4.png)

![fig10](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/04_fig10-new-bucket-done.png)


## Per recuperare la s3_region del bucket appena creato

AWS -> Service -> S3 -> Bucket name -> Properties -> Static website hosting -> Endpoint 

Una volta fatto login dalla ConsoleHome AWS fare click sul service "S3". Ci si presenterà un elenco con tutti i bucket creati con relativo nome. Facciamo click sul bucket, andiamo sul tab "properties" e facciamo click sul "quadrato" Static web hosting. Lì troveremo un Endpoint simile al seguente:

Endpoint : http://bl6-0-dev.s3-website-us-east-1.amazonaws.com

La region in questo caso è "us-east-1" e corrisponde alla region US East (N. Virginia)

![fig11](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/04_fig11-bucket_endpoint.png)

(
se avessimo usato "Region: EU (Ireland)" sarebbe stato "http://s5beginning-dev.s3-website-eu-west-1.amazonaws.com
La region in questo caso sarebbe stata "eu-west-1" e corrisponde alla region di UE (Irlanda)
)

(
Se avessimo scelto la region di Frankfurt avremmo avuto La nostra s3_region è "eu-central-1" e l'endpoint sarebbe stato:
Endpoint : http://s5beginning-dev.s3-website-eu-central-1.amazonaws.com
)


E con questo abbiamo tutti i dati che ci servono per collegarci. Nel prossimo capitolo ci collegheremo tramite Rails.



## Verifichiamo preview

nessun preview da visualizzare



## salviamo su git

nessuna modifica fatta al codice


## Pubblichiamo su Heroku

niente di nuovo da pubblicare


## Chiudiamo il branch

Lo lasciamo aperto per il prossimo capitolo



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/03_00-image_resize.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/05_00-aws_s3_activestorage-it.md)
