# <a name="01-01-02"></a> Cap 1.2 -- Creiamo utente IAM per Cloud9

Non è una buona idea lavorara su cloud9 come root. Lo stesso Amazon Web Server consiglia di creare un utente IAM per gestire cloud9.


Risorse interne:

* 99-rails_references/aws_cloud9/02-share_environment




## I tre gruppi di ambienti di cloud9

Su cloud9 ci sono tre raggruppamenti di ambiente:

- Your environments
    gli ambienti creati da uno specifico utente IAM. Ad esempio:
    - user_FB@870054134107 vede i suoi ambienti
    - user_AB@870054134107 vede i suoi ambienti
- Shared with you
    gli ambienti in cui l'utente è stato invitato
- Account environments
    gli ambienti di tutti gli utenti IAM di uno specifico account (Ad esempio: 870054134107)


Se decidiamo di creare un utente IAM facciamo ATTENZIONE:

l'utente IAM è visto come una persona differente dall'utente principale "root" e quindi avrà un suo ambiente cloud9.
Le app create come "root" o come un altro utente IAM non saranno visibili in "Your environments". Le possiamo comunque trovare in "Account environments".

E' quindi importante scegliere con cura l'utente:

- se vogliamo raggruppare le app fatte per i vari clienti possiamo usare IAM users con il nome dei nostri clienti.
- se vogliamo vedere tutte le app in un unico punto usiamo un unico IAM user. 

Per questo tutorial creiamo l'utente " user_fb ", ossia " utente Flavio Bordoni ", con il diritto di accesso alla console di aws e tutti i diritti di utilizzo di Cloud9




## Effettuiamo il login come amministratore

Vediamo adesso come creare uno IAM user da dedicare a cloud9. 

https://console.aws.amazon.com/

Scegliamo il link: "Sign-in using root account credentials"

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/02_fig01-aws_sign_in_as_root.png)



---
## Creiamo un nuovo utente dedicato all'uso di Cloud9

Creiamo un nuovo utente IAM, da assegnare a Flavio Bordoni, con il permesso di effettuare il login sulla console aws.

L'utente IAM " user_FB " è quello che Flavio Bordoni userà per lavorare su amazon web server di volta in volta gli implementeremo le varie autorizzazioni.
Usiamo il prefisso " user_ " per differenziare gli utenti IAM che identificano delle persone fisiche da quelli che identificano applicativi.

Abbiamo due tipi di prefissi per gli utenti IAM:

- user_ : identifica persone fisiche che accedono ai vari servizi di aws.
- bot_  : identifica applicativi che accedono ai vari servizi di aws.


AWS -> Service -> IAM -> Users -> Add user

- Una volta fatto login dalla ConsoleHome AWS faccaimo click sul service "IAM". 
- Andiamo sul link Users e ne creiamo uno nuovo cliccando "Add user".

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/02_fig02-aws_new_user.png)


### Step1

- User name   : user_fb
- Access type : AWS Management Console access
- Console password 
    - Custom password : mypassword
- Require password reset : no

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/02_fig03-new_user_step1.png)



- Step2
    Permissions 
    -> policy : AdministratorAccess
    -> policy : AWSCloud9Administrator
    -> policy : AWSCloud9EnvironmentMember
    -> policy : AWSCloud9User
- Step3
    Non aggiungiamo nessun tag.
- Step4
    Visualizza il riepilogo delle scelte fatte.
- Step5
    L'utente IAM è stato creato e possiamo scaricarci il file ".csv" o inviarci un'email.


![Fig. 01](chapters/01-base/01-new_app/02_fig01-aws_IAM_user_new_step1.png)

![Fig. 02](chapters/01-base/01-new_app/02_fig02-aws_IAM_user_new_step2a.png)

![Fig. 03](chapters/01-base/01-new_app/02_fig03-aws_IAM_user_new_step2b.png)

![Fig. 04](chapters/01-base/01-new_app/02_fig04-aws_IAM_user_new_step3.png)

![Fig. 05](chapters/01-base/01-new_app/02_fig05-aws_IAM_user_new_step4.png)

![Fig. 06](chapters/01-base/01-new_app/02_fig06-aws_IAM_user_new_step5.png)


Facciamo riferimento alla storia di Cloud9 [Volume 1 - Cap 1.1](#01-base-01-new_app-01-aws_cloud9-story)




## Effettuiamo login come nuovo utente IAM ed andiamo su Cloud9

Andiamo sull'account e verifichiamo il nostro Account Id

Account Id: 870054134107 

(Lo stesso numero è anche utilizzato nello User ARN -> arn:aws:iam::870054134107:user/user_fb)


Effettuiamo il logout come amministratore

Nel login scegliamo -> "Sign in to a different account"

![Fig. 07](chapters/01-base/01-new_app/02_fig07-aws-login-as-iam-user-cloud9.png)

Una volta effettuato il login possiamo andare su Service Cloud9 e questa volta non ci apparirà il messaggio di avvertimento che usare " root " non è consigliato.

![Fig. 08](chapters/01-base/01-new_app/02_fig08-aws_c9_dashboard_IAM_root.png)

Ma questo lo vedremo nel prossimo capitolo.

---

[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/03-aws_cloud9_new_environment.md)
