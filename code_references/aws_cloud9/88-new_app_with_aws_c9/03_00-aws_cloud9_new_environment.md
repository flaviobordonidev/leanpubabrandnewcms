# <a name="top"></a> Cap 1.3 - Creiamo nuovo ambiente Cloud9

Creiamo l'ambiente per la nostra applicazione Rails.




## Risorse interne

- 99-rails_references-aws_cloud9




## Entriamo su cloud9

Facciamo login come utente IAM " user_fb " ed andiamo sul servizio di cloud9

Services -> Developer Tools -> Cloud9




## Impostiamo la Region

Per aumentare le prestazioni dovremmo selezionare la "AWS Region" più vicina a noi, o meglio ai nostri clienti. Ad esempio "Ireland".

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/03_fig01-aws_region.png)

Ma c'è da tenere anche presente ceh ogni Region ha dei costi di fatturazione differenti. Ad esempio: 

* EU (Frankfurt)        : n/a
* EU (Ireland)          : $0.11 per GB-month of General Purpose SSD (gp2) 
* US East (N. Virginia) : $0.10 per GB-month of General Purpose SSD (gp2) 

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/03_fig02-aws_billing.png)

Un consiglio è quello di lasciare inizialmente la AWS Region di default perché normalmente è quella più economica ed intervenire in un secondo momento nel cambio della Region; una volta valutate le prestazioni.

ATTENZIONE! Gli ambienti visualizzati sono in funzione della AWS Region selezionata. Se cambiamo Region non vedremo più degli ambienti caricati con la Region precedente. Basta riselezionare la Region precedente per rivisualizzarli.




## Creiamo il nuovo ambiente cloud9

Creare un nuovo ambiente è un processo in 3 passi.

Il nuovo ambiente lo chiamiamo *bl7_0* ad indicare che è l'applicazione *baseline* creata con *Rails 7.0.1* - Released January 6, 2022.
Per applicazione baseline intendiamo che ha il 90% di tutto quello che ci serve per sviluppare e quindi un ottimo punto di partanza da clonare per tutte le altre applicazioni.


### Step1

- Name: bl7_0
- Description : App base con Rails 7.0.1

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/03_fig03-aws_c9_new_environment_step1.png)


### Step2

- Environment type      : Create a new instance for environment (EC2)
- Instance type         : t2.micro (1 GiB RAM + 1 vCPU)
- Platform              : Ubuntu Server 18.04 LTS
- Cost-saving setting   : After 30 minutes (default)

Lasciamo il server virtuale di default che è sufficiente per iniziare. Possiamo potenziarlo in seguito. Più potenza diamo più ci costa.

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/03_fig04-aws_c9_new_environment_step2.png)


### Step 3

Review

![fig05](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/03_fig05-aws_c9_new_environment_step3.png)

Ci sono presentati i seguenti consigli che è interessante implementare successivamente con calma:

Raccomandiamo le seguenti migliori pratiche per l'utilizzo dell'ambiente AWS Cloud9

* Usare un source control (usiamo git) e fare il backup del proprio ambiente frequentemente (usiamo GitHub). AWS Cloud9 non esegue backup automatici.
* Eseguire aggiornamenti regolari del software sul proprio ambiente. AWS Cloud9 non esegue aggiornamenti automatici per tuo conto.
* Attivare AWS CloudTrail nel tuo account AWS per tenere traccia delle attività nel tuo ambiente. Ulteriori informazioni (https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-user-guide.html)
* Condividere il proprio ambiente solo con utenti fidati. La condivisione del tuo ambiente potrebbe mettere a rischio le tue credenziali di accesso AWS. Ulteriori informazioni (https://docs.aws.amazon.com/console/cloud9/share-environment-best-practices)

Click su "Create environment"




## Configuriamo la nostra sessione di AWS Cloud9

* Main theme    : AWS Cloud9 Classic Dark Theme
* Editor theme  : Cloud9 Night Low-Color
* Keyboard Mode : Default

![fig06](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/03_fig06-aws_c9_dark_theme.png)

Su *More Settings...* -> Project Settings -> **Soft tabs: 2**

![fig07](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/03_fig07-aws_c9_soft_tabs.png)

L'ambiente è impostato.


---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/02-aws_IAM_user_for_cloud9.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/04-aws_c9_more_disk_space.md)
