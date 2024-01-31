# <a name="top"></a> Cap multipass_ubuntu.3 - Colleghiamoci da mac alla VM via SSH

Per collegarci da mac a vm via ssh abbiamo bisogno di una coppia di chiavi di crittatura (una Privata e una Pubblica).
Metteremo la chiave pubblica sull'istanza della VM (Virtual Machine) su multipass e ci colleghiamo usando la nostra chiave privata che resta sul mac.
Nel nostro mac creiamo la coppia di chiavi e mettiamo una copia della chiave pubblica sulla VM.
Dal mac useremo l'ssh client per collegarci alla VM in cui è attivo l'ssh server (o meglio, il demone sshd).

Riassumendo:
- Nel mac : chiave privata ed ssh client
- Nella VM : chiave pubblica ed ssh server (sshd)



## Risorse esterne

- [OpenSSH Full Guide - Everything you need to get started!](https://www.youtube.com/watch?v=YS5Zh7KExvE)
- [How to use Multiple SSH Keys | Managing Different SSH Keys on your System](https://www.youtube.com/watch?v=pE3EuiyShoM)
- [How to Enable SSH on Ubuntu](https://linuxize.com/post/how-to-enable-ssh-on-ubuntu-18-04/)
- [How To Install and Enable SSH Server](https://devconnected.com/how-to-install-and-enable-ssh-server-on-ubuntu-20-04/)
- [How to fix SSH Permission denied](https://phoenixnap.com/kb/ssh-permission-denied-publickey#:~:text=the%20solutions%20below.-,Solution%201%3A%20Enable%20Password%20Authentication,login%20in%20the%20sshd_config%20file.&text=In%20the%20file%2C%20find%20the,sure%20it%20ends%20with%20yes%20.)
- [multipass and SSH to the VM From LAN](https://medium.com/codex/use-linux-virtual-machines-with-multipass-4e2b620cc6)
- [Where to find SSH keys for multipass?](https://github.com/canonical/multipass/issues/913)

- [How to connect to GCP VM Instance using SSH MacOS Terminal](https://www.youtube.com/watch?v=2ibBF9YqveY)
  Questo video ha funzionato!!! E mi sembra anche molto semplice. Un ottimo punto di partenza.
  Spiega come collegarsi con MAC e c'è un altro video che spiega come collegarsi con Windows
- [How to connect to GCP VM Instance using SSH on WINDOWS](https://www.youtube.com/watch?v=StA1i-p6G4o)
  Questo video è come quello sopra ma pe WINDOWS.
  Su windows dobbiamo installare le applicazioni "PUTTY" e "PUTTYGEN".
- [How to Connect to Google Compute Engine Virtual Machine with SSH or puTTY on Mac](https://www.youtube.com/watch?v=vA18jo-4gu4)
  Anche questo video dice la stessa cosa ma con altri spunti
- [stackoverflow: ssh to google cloud platform - permission denied](https://stackoverflow.com/questions/51614552/google-cloud-platform-ssh-to-google-cloud-instance-will-have-permission-denied)
  Qui c’è una nota interessante (comunque già considerata nei video sopra)



## Nella VM verifichiamo SSH server

La nostra IDE la collegheremo alla nostra VM Ubuntu Linux tramite *secure shell* (ssh). Quindi attiviamo un server *ssh* nella nostra VM. La nostra scelta è *openssh-server*.

Per impostazione predefinita, SSH è già installato sulla nostra VM, anche con una configurazione base.
Per verificare che sia effettivamente così, eseguiamo il comando `ssh` con l'opzione **-V**.

```shell
$ ssh -V
```

Esempio:

```shell
ubuntu@ub22fla:~$ ssh -V
OpenSSH_8.9p1 Ubuntu-3ubuntu0.6, OpenSSL 3.0.2 15 Mar 2022
```

> Fai attenzione: queste informazioni non significano che hai un server SSH in esecuzione sul tuo server, significa solo che sei attualmente in grado di connetterti come client ai server SSH.

Un modo più specifico per vedere se hai SSH server è: 

```shell
$ which sshd
```

Esempio

```shell
ubuntu@ub22fla:~$ which sshd
/usr/sbin/sshd
```

Oppure 

```shell
$ systemctl status sshd
```

Esempio

```shell
ubuntu@ub22fla:~$ systemctl status sshd
● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
     Active: active (running) since Sun 2024-01-28 23:16:26 CET; 22h ago
       Docs: man:sshd(8)
             man:sshd_config(5)
   Main PID: 652 (sshd)
      Tasks: 1 (limit: 4608)
     Memory: 11.0M
        CPU: 1.084s
     CGroup: /system.slice/ssh.service
             └─652 "sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups"

Jan 29 15:50:30 ub22fla sshd[3254]: pam_unix(sshd:session): session closed for user ubuntu
Jan 29 15:51:01 ub22fla sshd[3380]: Accepted publickey for ubuntu from 192.168.64.1 port 54231 ssh2: RSA SHA256:mdo9MwoxVF91YMtE6mzACz1B4haW+jzT8B8IStKD3vs
Jan 29 15:51:01 ub22fla sshd[3380]: pam_unix(sshd:session): session opened for user ubuntu(uid=1000) by (uid=0)
Jan 29 15:58:21 ub22fla sshd[3459]: Accepted publickey for ubuntu from 192.168.64.1 port 54259 ssh2: RSA SHA256:JzXJFBypEB+tUitj31+XAk4Xa1icnbp/6oTPk8sK8oQ
Jan 29 15:58:21 ub22fla sshd[3459]: pam_unix(sshd:session): session opened for user ubuntu(uid=1000) by (uid=0)
Jan 29 18:24:23 ub22fla sshd[3553]: Accepted publickey for ubuntu from 192.168.64.1 port 54904 ssh2: RSA SHA256:JzXJFBypEB+tUitj31+XAk4Xa1icnbp/6oTPk8sK8oQ
Jan 29 18:24:23 ub22fla sshd[3553]: pam_unix(sshd:session): session opened for user ubuntu(uid=1000) by (uid=0)
Jan 29 18:24:26 ub22fla sshd[3553]: pam_unix(sshd:session): session closed for user ubuntu
Jan 29 22:07:57 ub22fla sshd[3715]: Accepted publickey for ubuntu from 192.168.64.1 port 55552 ssh2: RSA SHA256:mdo9MwoxVF91YMtE6mzACz1B4haW+jzT8B8IStKD3vs
Jan 29 22:07:57 ub22fla sshd[3715]: pam_unix(sshd:session): session opened for user ubuntu(uid=1000) by (uid=0)
```

- `Active: active (running)...` : indica che il server è attivo
- `Loaded: loaded (/lib/systemd/system/ssh.service; enabled...` : la voce `enabled` indica che il server parte in automatico all'avvio del sistema

Per far ripartire o stoppare il server sshd.

```shell
$ systemctl restart sshd
$ systemctl stop sshd
$ systemctl start sshd
```


Se non fosse presente lo possiamo installare con:

```shell
$ sudo apt update
$ sudo apt install openssh-server
```



## Vediamo il file di configurazione di SSH server

Il file di configurazione di ssh server è `/etc/ssh/sshd_config`.

```shell
❯ multipass shell ub22fla
$ sudo nano /etc/ssh/sshd_config
```

*** Codice 01 - /etc/ssh/sshd_config - linea: 55 ***

```shell
# To disable tunneled clear text passwords, change to no here!
#PasswordAuthentication yes
#PermitEmptyPasswords no

# Change to yes to enable challenge-response passwords (beware issues with
# some PAM modules and threads)
KbdInteractiveAuthentication no

# Kerberos options
```

> Su ubuntu 20.04 al posto di `KbdInteractiveAuthentication no` c'era la voce `ChallengeResponseAuthentication no`.

La voce `PasswordAuthentication yes` è commentata ma scritta così dovrebbe indicare che il valore di default è `yes`.
La voce `PasswordAuthentication yes` permette di collegarsi as SSH server usando la password dell'utente, ma questa soluzione non è la più sicura ed in alcuni casi non funziona. È raccomandato impostare il collegamento attraverso le chiavi di crittatura ed disattivare il password authentication mettendo la voce a "no": `PasswordAuthentication no`.

Al momento lasciamo tutto così com'è e non modifichiamo niente.
Se avessimo fatto delle modifiche a questo file avremmo dovuto riavviare il server ssh affinché avessero effetto.

```shell
$ sudo systemctl restart sshd
```

> Comunque la sessione attiva non viene interrotta. Se pero usciamo e proviamo a rientrare allora dobbiamo essere compliant con le modifiche effettuate.



## Verifichiamo il collegamento SSH

Da terminale macOS colleghiamoci alla VM tramite Secure SHell.

```shell
$ ssh -p 22 ubuntu@192.168.64.3
```

Esempio

```shell
ubuntu@ub22fla:~$ exit
logout
❯ ssh -p 22 ubuntu@192.168.64.3
The authenticity of host '192.168.64.3 (192.168.64.3)' can't be established.
ED25519 key fingerprint is SHA256:xcM+0VOFEkozZmC9gRpulSDNDxTpAkg1PUcYQiiCPhQ.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.64.3' (ED25519) to the list of known hosts.
ubuntu@192.168.64.3: Permission denied (publickey). 
```

Non funziona perché gli manca la corretta chiave di crittatura.




## Usiamo la chiave di crittatura di multipass

Possiamo usare la chiave di crittatura `id_rsa` di multipass che è nel percorso `/var/root/Library/Application\ Support/multipassd/ssh-keys/` ma preferisco creare una chiave dedicata come vediamo nel prossimo paragrafo. 

```shell
❯ sudo ssh -i /var/root/Library/Application\ Support/multipassd/ssh-keys/id_rsa ubuntu@192.168.64.3
```

Esempio:

```shell
❯ ssh -p 22 ubuntu@192.168.64.3
ubuntu@192.168.64.3: Permission denied (publickey).

❯ sudo ssh -i /var/root/Library/Application\ Support/multipassd/ssh-keys/id_rsa ubuntu@192.168.64.3
Password:***
Welcome to Ubuntu 22.04.3 LTS (GNU/Linux 5.15.0-92-generic aarch64)
[...]
Last login: Mon Jan 29 13:14:38 2024 from 192.168.64.1
ubuntu@ub22fla:~$ exit
logout
Connection to 192.168.64.3 closed.
```

> L'utente di defualt è `ubuntu` e gli abbiamo assegnato precedentemente una password col comando `$ pswd`, per questo ce la chiede. Anche se è meglio non assegnare una password.



## Creiamo una nuova chiave di crittatura dedicata

Creiamo una chiave di crittatura ssh per ogni server a cui ci vogliamo collegare.
La chiavi di crittatura sono mentenute per convenzione nella cartella nascosta `~/.ssh`

Esempio:

```shell
❯ ls ~/.ssh
```

Se non è stata fatto nessuna connessione ssh, o nessun tentativo di connessione, la cartella potrebbe **non esistere o essere vuota**.
Ma normalmente in questa cartella si trovano questi files:
- `config`      : contine eventuali configurazioni personalizzate per i collegamenti ssh
- `known_hosts` : tiene traccia di server a cui ci siamo già collegati, o abbiamo provato a collegarci
- `id_rsa`      : chiave privata di default
- `id_rsa.pub`  : chiave pubblica di default


Creiamo una coppia di chiavi (Privata e Pubblica). Metteremo la chiave pubblica sull'istanza della VM (Virtual Machine) su multipass e ci colleghiamo usando la nostra chiave privata che resta sul mac.

Creiamo la nuova coppia di chiavi (privata e pubblica).

```shell
$ cd ~/.ssh
$ ssh-keygen -t rsa -f ub22fla_key -C "ubuntu"
```

> nota: per la "passfrase" lascio il campo vuoto

- `cd ~` entra nella cartella dell'utente. Nel mio caso `/Users/fb`.
  `/.ssh` entra nella cartella nascosta dove, di default, sono raccolti i files delle chiavi
- `-t` indica il tipo di criptatura. Abbiamo scelto `rsa`.
- `-f` indica la cartella ed il nome delle chiavi.
- `-C` indica lo "username". Nel nostro caso `ubuntu`. (la "C" sta per "comment" ma in realtà è usato per mettere l'utente.)

> Per creare una chiave ancora più sicura usiamo `-t ed25519` al posto di `-t rsa` e mettiamo sempre il "passphrase" quando ci viene richiesto.
> Ma per multipass non ci serve tutta questa sicurezza perché le VM che creiamo non sono di produzione ma solo di sviluppo.

Esempio:

```shell
❯ ls ~/.ssh
known_hosts
❯ cd ~/.ssh
❯ ssh-keygen -t rsa -f ub22fla_key -C "ubuntu"
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in ub22fla_key
Your public key has been saved in ub22fla_key.pub
The key fingerprint is:
SHA256:JzXJFBypEB+tUitj31+XAk4Xa1icnbp/6oTPk8sK8oQ ubuntu
The keys randomart image is:
+---[RSA 3072]----+
|      ...o++. o .|
|      ...++. = o |
|       o.+= o +  |
|      = +. = =   |
|     . =S.+ + . .|
|        .+.. +...|
|        E o...+o |
|         + ..=o..|
|          . .oB+.|
+----[SHA256]-----+
❯ ls ~/.ssh
known_hosts     ub22fla_key     ub22fla_key.pub
❯ 
```



## Associamo la chiave pubblica alla nosta VM

Associamo la chiave pubblica alla nosta VM ub22fla.

```shell
❯ ssh-copy-id -i ~/.ssh/ub22fla_key.pub 192.168.64.3
```

Se hai già accesso puoi usare `ssh-copy-id` per aggiungere altre chiavi ma nel nostro caso non va bene.

Quindi lo facciamo manualmente.
Mettiamo il file `ub22fla_key.pub` nella nostra home "/Usrs/fb" che abbiamo precedentemente montato (vedi capitolo precedente)
Quindi appendiamo il contenuto del file `ub22fla_key.pub` nel file `authorized_keys`

---
If you do not have the folder `~/.ssh/authorized_keys`, you can create this.

```shell
ubuntu@ub22fla:~$ mkdir -p ~/.ssh
ubuntu@ub22fla:~$ touch ~/.ssh/authorized_keys
```
---

```shell
❯ cp ~/.ssh/ub22fla_key.pub /Users/fb
❯ multipass mount ~ ub22fla
❯ multipass info ub22fla
❯ multipass shell ub22fla
ubuntu@ub22fla:~$ ls /Users/fb/
ubuntu@ub22fla:~$ cat /Users/fb/ub22fla_key.pub 
ubuntu@ub22fla:~$ cat /Users/fb/
ubuntu@ub22fla:~$ ls ~/.ssh/
ubuntu@ub22fla:~$ cat ~/.ssh/authorized_keys 
# iseriamo la chiace pubblica nel file delle chiavi autorizzate
ubuntu@ub22fla:~$ cat /Users/fb/ub22fla_key.pub >> ~/.ssh/authorized_keys
ubuntu@ub22fla:~$ cat ~/.ssh/authorized_keys 
ubuntu@ub22fla:~$ exit
```



## Adesso colleghiamoci

```shell
❯ ssh -i ~/.ssh/ub22fla_key ubuntu@192.168.64.3
```

Yes ci siamo connessi ^_^




## Creiamo il file config per ssh

```shell
❯ cd ~/.ssh/
❯ touch config
❯ nano config
```

*** Codice 02 - ~/.ssh/config - linea: 1 ***

```yaml
Host ub22flapizza
  Hostname 192.168.64.3
  Port 22
  User ubuntu
```

```shell
❯ ssh ub22flapizza
# invece di 
❯ ssh -p 22 ubuntu@192.168.64.3
```






---
[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/01_00-ubuntu_multipass.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/03_00-implement_ide.md)
