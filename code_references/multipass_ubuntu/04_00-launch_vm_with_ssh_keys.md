# <a name="top"></a> Cap multipass_ubuntu.4 - Creiamo un nuova VM

In questo capitolo creiamo una nuova VM su multipass sfruttando tutto quello cha abbiamo appreso nei capitoli precedenti.
Creiamo una VM con già le chiavi di crittatura ssh utilizzando la configurazione "cloud-init".



## Risorse esterne

- [Enable ssh access to multipass vms](https://dev.to/arc42/enable-ssh-access-to-multipass-vms-36p7)



## Creiamo la coppia di chiavi di crittatura per ssh sul mac

Siamo nel mac quidni sul lato "ssh client".
Creiamo una nuova coppia di chiavi di crittatura (privata e pubblica) che dedichiamo alla nuova vm che creeremo a breve.

> La chiavi di crittatura sono mentenute per convenzione nella cartella nascosta `~/.ssh`

```shell
$ cd ~/.ssh
$ ssh-keygen -t ed25519 -f ub22fla_key_ed25519 -C "ubuntu"
# la "passphrase" la lascio vuota per evitare di metterla ogni volta che mi collego con vscode
```

Esempio:

```shell
❯ cd ~/.ssh
❯ ls
known_hosts   known_hosts.old

❯ ssh-keygen -t ed25519 -f ub22fla_key_ed25519 -C "ubuntu"
Generating public/private ed25519 key pair.
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in ub22fla_key_ed25519
Your public key has been saved in ub22fla_key_ed25519.pub
The key fingerprint is:
SHA256:nQUOX8UYwq1pRX8BPfUCtnAowSrAYtWfUOSSXEcC3cA ubuntu
The keys randomart image is:
+--[ED25519 256]--+
| .....*B*=++B*+.o|
|..o .o+E==oB++.oo|
|.. . +oo..o+o o +|
|    . oo .+o   o |
|     .  S.o      |
|                 |
|                 |
|                 |
|                 |
+----[SHA256]-----+
❯ ls
known_hosts   known_hosts.old   ub22fla_key_ed25519   ub22fla_key_ed25519.pub
❯ 
```

Se vogliamo successivamente inserire, cambiare o togliere la passfrase su una chiave usiamo `ssh-keygen -p ...`.

```shell
❯ cd ~/.ssh
❯ ssh-keygen -p -f ub22fla_key_ed25519
```

> per togliere la passphrase non inseriamo nulla e premiamo enter



## Creiamo la configurazioen cloud-init sul mac

Siamo nel mac quindi sul lato "ssh client".
Nella directory in cui abbiamo generato le chiavi di crittatura ssh creiamo il file `cloud-init.yaml`.

```shell
❯ touch cloud-init.yaml
❯ nano cloud-init.yaml
```

Scriviamo nel file il seguente codice:

*** Codice 01 - ~/.ssh/cloud-init.yaml - linea: 1 ***

```yml
users:
  - default
  - name: ubuntu
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
    - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPnvMUqdYqfJ7/4blAmDs2iD5j7PjwaJyblFXpfjUka8 ubuntu
```

> sotto la voce `ssh_authorized_keys:` c'è il contenuto della nostra chiave pubblica ossia del file `ub22fla_key_ed25519.pub`.



## Creiamo la macchina virtuale con già le chiavi di crittatura per ssh
Launch multipass VM with ssh configuration

Vediamo l'elenco di sistemi operativi che posso caricare nella VM

```shell
❯ multipass find
```

Nel nostro caso siamo interessati a Ubuntu 22.04 LTS (image: 22.04) quindi creiamo la VM con questo sistema operativo.
Creiamo un'istanza con 20Gb di spazio disco e 4Gb di memoria e diamogli un nome. Io la chiamo "ub22fla".

```shell
❯ multipass launch 22.04 --name ub22fla --cpus 1 --memory 4G --disk 20G  --cloud-init cloud-init.yaml
```



## Entriamo nella VM

Possiamo usare `multipass shell ...` oppure direttamente `ssh ...`.

usiamo multipass.

```shell
❯ multipass shell ub22fla
$ exit
```

usiamo ssh.

```shell
❯ ssh -i ~/.ssh/ub22fla_key_ed25519 ubuntu@192.168.64.4
#oppure
❯ ssh -p 22 -i ~/.ssh/ub22fla_key_ed25519 ubuntu@192.168.64.4
```

> `-p 22` specifica la porta a cui collegarci. Può essere omesso perché la porta di default è la 22. L'opzione `-p ...` è utile nel caso in cui avessimo cambiato la porta lato server ssh (sulla vm) nel file `/etc/ssh/sshd_config`.

Funziona!

> se nella VM guardiamo il file `~/.ssh/authorized_keys` vediamo che c'è anche il contenuto della nostra `ub22fla_key_ed25519.pub`.



---
[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/00-frontmatter/03-introduction.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/02_00-install_ssh_server.md)
