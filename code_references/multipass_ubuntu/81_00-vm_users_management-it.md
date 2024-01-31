# <a name="top"></a> Cap multipass_ubuntu.81 - Gestiamo gli utenti

L'utente di default in ogni istanza VM di multipass è: `ubuntu`



## Cambiamo la password

Se lasciamo senza password la VM è più sicura perché per collegarsi si devono usare le chiavi di crittatura ssh.

> Ricordiamoci di impostare nel file di configurazione del server ssh sulla vm: `PasswordAuthentication no`

Se però vogliamo inserire una password lo possiamo fare.

```shell
ubuntu@ub22fla:~$ sudo passwd ubuntu
```

Esempio:

```shell
ubuntu@ub22fla:~$ sudo passwd ubuntu
New password: 
Retype new password: 
passwd: password updated successfully
ubuntu@ub22fla:~$ 
```
