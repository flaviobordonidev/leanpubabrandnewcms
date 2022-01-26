# Condividiamo l'ambiente cloud9


Risorse web:

* [](https://docs.aws.amazon.com/cloud9/latest/user-guide/share-environment.html)
* [](https://docs.aws.amazon.com/cloud9/latest/user-guide/share-environment.html#share-environment-invite-user)




## Invite users

In the Share this environment dialog box, for Invite Members, type one of the following.

* To invite an IAM user, type the user's name.
* To invite the AWS account root user, type arn:aws:iam::123456789012:root, replacing 123456789012 with your AWS account ID.
* To invite a user with an assumed role or a federated user with an assumed role, type arn:aws:sts::123456789012:assumed-role/MyAssumedRole/MyAssumedRoleSession, replacing 123456789012 with your AWS account ID, MyAssumedRole with the name of the assumed role, and MyAssumedRoleSession with the session name for the assumed role.




## Esempio invitiamo utente root

Se vogliamo condividere il nostro ambiente aws Cloud9 con un collaboratore che è loggato come root dobbiamo invitarlo come " arn:aws:iam::870054134107:root ".

arn:aws:iam::771240163965:root



## URL per web server development shared

Quando apri un workspace condiviso il link "Share" in alto a destra non c'è più.
Allora una volta fatto partire il server con ** $ rails s -b $IP -p $PORT **
L'url da usare ha la struttura https://<nomeworkspace>-<nomeutentec9>.c9users.io
es:
    https://donamat5-bobdesa64.c9users.io
    https://ang5-donamat-flaviobordonidev.c9users.io

Un modo per prenderlo è lanciare "Preview -> Preview Running Application" e copiarsi l'URL che viene usato in una finestra locale.
