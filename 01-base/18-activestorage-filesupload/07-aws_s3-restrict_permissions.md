{id: 01-base-18-activestorage-filesupload-07-aws_s3-restrict_permissions}
# Cap 18.7 -- Restringiamo i permessi

E' arrivato il momento di lavorare sui files CORS restringendo i permessi di accesso.

In questo capitolo:

* Lo IAM user botbrandnewcmsdev può accedere solo al bucket brandnewcmsdev 
* Lo IAM user botbrandnewcmsprod può accedere solo al bucket brandnewcmsprod
* a scopo didattico creiamo IAM user botbrandnewcmsprodro (read only) che può solo visualizzare i file




---
Questo è da sistemare:


## Aggiungiamo i permessi - Permissions

clicco sul link "botbrandnewcms" e sul tab Permission 
  -> Add Permission (Attach existing policies directly)
  -> "AmazonS3FullAccess - AWS Managed policy"

aws -> services -> IAM -> users -> botbrandnewcms -> Permissions -> 
  -> apriamo la policy AmazonS3FullAccess che abbiamo dato:

![AWS S3](brandnewcms/12img-aws-iam-user-permissions.png)

Il file json si presenta così

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "*"
        }
    ]
}

possiamo dare pieno accesso o selezionare solo quelle che ci servono

* GetObject
* PutObject
* PutObjectAcl

quella di gorail è

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt147561171600",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:DeleteObject",
                "s3:PutObject",
                "s3:PutObjectAcl"
                ],
            "Resource": [
                "arn:aws:s3:::shrine-example/*"
            ]
        }
    ]
}

valida la policy per vedere che non hai fatto errori.

la Resource continene l'ARN dei bucket che vogliamo includere per questo utente. Per trovare l'ARN basta cliccare sulla riga del bucket (e non sul link del bucket) e premere il link "Copy Bucket ARN".

---






### il file CORS per la sicurezza

AWS -> Service -> S3 -> Bucket name -> Permissions -> CORS configuration 

Di default ci sono permessi GET da qualsiasi origine ma nessun PUT.

{title="CORS configuration",lang=markdown, line-numbers=on, starting-line-number=1}
```
<!-- Sample policy -->
<CORSConfiguration>
	<CORSRule>
		<AllowedOrigin>*</AllowedOrigin>
		<AllowedMethod>GET</AllowedMethod>
		<MaxAgeSeconds>3000</MaxAgeSeconds>
		<AllowedHeader>Authorization</AllowedHeader>
	</CORSRule>
</CORSConfiguration>
```

Lasciamo tutti i domini (<AllowedOrigin>*</AllowedOrigin>) ed aggiungiamo anche la possibilità di fare PUT e POST per poter caricare i files.

{title="CORS configuration",lang=markdown, line-numbers=on, starting-line-number=1}
```
<!-- Sample policy -->
<CORSConfiguration>
	<CORSRule>
		<AllowedOrigin>*</AllowedOrigin>
		<AllowedMethod>GET</AllowedMethod>
		<MaxAgeSeconds>3000</MaxAgeSeconds>
		<AllowedHeader>Authorization</AllowedHeader>
	</CORSRule>
	<CORSRule>
		<AllowedOrigin>*</AllowedOrigin>
		<AllowedMethod>PUT</AllowedMethod>
		<AllowedMethod>POST</AllowedMethod>
		<MaxAgeSeconds>3000</MaxAgeSeconds>
		<AllowedHeader>*</AllowedHeader>
	</CORSRule>
</CORSConfiguration>
```

Click su SAVE per applicarli al nostro bucket.


In futuro implementeremo la sicurezza del browser HTTP access control configurando il file CORS (Cross-Origin Resource Sharing). 
Diremo al server di Amazon di accettare richieste solo dai nostri domini. Nel nostro caso mettiamo il dominio di cloud9 ed il dominio di Heroku (o il dominio di produzione).

![AWS S3](brandnewcms/12img-s3-bucket-cors.png)

{title="CORS configuration",lang=markdown, line-numbers=on, starting-line-number=1}
```
<!-- Sample policy -->
<CORSConfiguration>
	<CORSRule>
		<AllowedOrigin>https://brandnewcms-flaviobordonidev.c9users.io</AllowedOrigin>
		<AllowedOrigin>https://fast-brook-60500.herokuapp.com</AllowedOrigin>
		<AllowedMethod>GET</AllowedMethod>
		<MaxAgeSeconds>3000</MaxAgeSeconds>
		<AllowedHeader>Authorization</AllowedHeader>
	</CORSRule>
</CORSConfiguration>
```




## Ripetiamo il processo per il bucket per i files di produzione


Creiamo il bucket
  Create bucket
    Name and region
      Bucket name : rebisworldbr-prod
      Region      : EU (Frankfurt)
    Set properties
      lascia tutto come sta e fai click su "next"
    Set permissions
      lascia tutto come sta e fai click su "next"
    Review
      Il resoconto del bucket con praticamente tutti i valori di defalts. 
      Accettiamo e creiamo il bucket.


AWS -> Service -> S3 -> Bucket name -> Permissions -> CORS configuration 

Lasciamo tutti i domini (<AllowedOrigin>*</AllowedOrigin>) ed aggiungiamo anche la possibilità di fare PUT e POST per poter caricare i files.

{title="CORS configuration",lang=markdown, line-numbers=on, starting-line-number=1}
```
<!-- Sample policy -->
<CORSConfiguration>
	<CORSRule>
		<AllowedOrigin>*</AllowedOrigin>
		<AllowedMethod>GET</AllowedMethod>
		<MaxAgeSeconds>3000</MaxAgeSeconds>
		<AllowedHeader>Authorization</AllowedHeader>
	</CORSRule>
	<CORSRule>
		<AllowedOrigin>*</AllowedOrigin>
		<AllowedMethod>PUT</AllowedMethod>
		<AllowedMethod>POST</AllowedMethod>
		<MaxAgeSeconds>3000</MaxAgeSeconds>
		<AllowedHeader>*</AllowedHeader>
	</CORSRule>
</CORSConfiguration>
```

Click su SAVE per applicarli al nostro bucket.



----
Messaggio di avviso su upload su heroku.

remote: ###### WARNING:
remote: 
remote:        We detected that some binary dependencies required to
remote:        use all the preview features of Active Storage are not
remote:        present on this system.
remote:        
remote:        For more information please see:
remote:          https://devcenter.heroku.com/articles/active-storage-on-heroku






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
