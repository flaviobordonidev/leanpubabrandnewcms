# <a name="top"></a> Cap multipass_ubuntu.03 - Montiamo una directory per spos

Montiamo una directory per spostare files dalla macchina virtuale (VM) alla macchina fisica dove sta girando la macchina virtuale (pc host).

> Per spostare ad un altro computer sulla rete vedi comando "scp" o "rsync"



## Risorse interne

- [code_references/postgresql/04_00-backup_and_restore_database_render-it.md]()




## Spostiamo il file dalla VM multipass al PC fisico

Nella VM è presente la cartella "Home" che è un link alla cartella "Home" del nostro pc fisico, nel nostro caso il notebook Macbook pro su cui abbiamo installato multipass.

Quindi basta spostare o copiare il file dentro quella cartella.

```bash
ubuntu@primary:~$ ls Home
ubuntu@primary:~$ mv database_dump.sql  Home/
```

Questo comando sposta il file sulla nostra macchina fisica e precisamente nella cartella "<<root>>/Users/<<username>>". Nel mio caso è su: "FlaMac/Users/FB".

> Volendo spostare una copia si può usare `cp database_dump.sql  Home/`


Se non è montata la possiamo montare con il seguente comando da fare dal terminale di mac (non da dentro l'istanza multipass):

- [How to share data between host and VM with Multipass](https://www.youtube.com/watch?v=vrLcER1V2Co)

```bash
MacBook-Pro-di-Flavio:~ FB$ multipass list
MacBook-Pro-di-Flavio:~ FB$ multipass mount ~ primary
MacBook-Pro-di-Flavio:~ FB$ multipass info primary
MacBook-Pro-di-Flavio:~ FB$ multipass shell primary
ubuntu@primary:~$ cd /Users/FB/
ubuntu@primary:/Users/FB$ cp ~/database_dump.sql .
ubuntu@primary:/Users/FB$ exit
MacBook-Pro-di-Flavio:~ FB$ multipass unmount primary
```

Esempio:

```bash
ubuntu@primary:~$ ls
Home  database_dump.sql  snap
ubuntu@primary:~$ exit
logout
MacBook-Pro-di-Flavio:~ FB$ multipass list
Name                    State             IPv4             Image
primary                 Running           192.168.64.8     Ubuntu 22.04 LTS
ub22fla                 Stopped           --               Ubuntu 22.04 LTS
ubuntufla               Stopped           --               Ubuntu 20.04 LTS
MacBook-Pro-di-Flavio:~ FB$ multipass mount ~/Home primary
Source path "/Users/FB/Home" does not exist
MacBook-Pro-di-Flavio:~ FB$ multipass mount ~ primary
MacBook-Pro-di-Flavio:~ FB$ ls ~
Applications		Desktop			Downloads		Google Drive		Movies			Pictures		eduport_v1.2.0		google-cloud-sdk
Creative Cloud Files	Documents		Dropbox			Library			Music			Public			eduport_v1.2.0.zip	leanpubabrandnewcms
MacBook-Pro-di-Flavio:~ FB$ multipass info primary
Name:           primary
State:          Running
IPv4:           192.168.64.8
Release:        Ubuntu 22.04.3 LTS
Image hash:     59c2363fd71b (Ubuntu 22.04 LTS)
CPU(s):         1
Load:           0.00 0.00 0.00
Disk usage:     2.5GiB out of 4.8GiB
Memory usage:   150.4MiB out of 951.6MiB
Mounts:         /Users/FB => /Users/FB
                    UID map: 501:default
                    GID map: 20:default
MacBook-Pro-di-Flavio:~ FB$ 
MacBook-Pro-di-Flavio:~ FB$ multipass shell primary
Welcome to Ubuntu 22.04.3 LTS (GNU/Linux 5.15.0-86-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sun Dec 24 21:42:45 CET 2023

  System load:  0.0               Processes:               110
  Usage of /:   53.5% of 4.67GB   Users logged in:         0
  Memory usage: 21%               IPv4 address for enp0s2: 192.168.64.8
  Swap usage:   0%

 * Strictly confined Kubernetes makes edge and IoT secure. Learn how MicroK8s
   just raised the bar for easy, resilient and secure K8s cluster deployment.

   https://ubuntu.com/engage/secure-kubernetes-at-the-edge

Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


Last login: Sun Dec 24 19:07:05 2023 from 192.168.64.1
ubuntu@primary:~$ ls
Home  database_dump.sql  snap
ubuntu@primary:~$ ls /
Users  bin  boot  dev  etc  home  lib  lib32  lib64  libx32  lost+found  media  mnt  opt  proc  root  run  sbin  snap  srv  sys  tmp  usr  var
ubuntu@primary:~$ cd /Users/FB/
.Trash/               .config/              .idm/                 .ssh/                 Desktop/              Library/              Public/               
.anydesk/             .cups/                .local/               .vscode/              Documents/            Movies/               eduport_v1.2.0/       
.atom/                .dropbox/             .oracle_jre_usage/    Applications/         Downloads/            Music/                google-cloud-sdk/     
.bash_sessions/       .gem/                 .solargraph/          Creative Cloud Files/ Dropbox/              Pictures/             leanpubabrandnewcms/  
ubuntu@primary:~$ cd /Users/FB/
ubuntu@primary:/Users/FB$ cp ~/database_dump.sql 
cp: missing destination file operand after '/home/ubuntu/database_dump.sql'
Try 'cp --help' for more information.
ubuntu@primary:/Users/FB$ cp ~/database_dump.sql .
ubuntu@primary:~$ exit
logout
MacBook-Pro-di-Flavio:~ FB$ multipass unmount primary
MacBook-Pro-di-Flavio:~ FB$ multipass info primary
Name:           primary
State:          Running
IPv4:           192.168.64.8
Release:        Ubuntu 22.04.3 LTS
Image hash:     59c2363fd71b (Ubuntu 22.04 LTS)
CPU(s):         1
Load:           0.00 0.01 0.00
Disk usage:     2.5GiB out of 4.8GiB
Memory usage:   176.1MiB out of 951.6MiB
Mounts:         --
MacBook-Pro-di-Flavio:~ FB$ 
```

Il file ce lo ritroviamo sul mac con "finder" su /Users/FB.


### Altro metodo per spostare il file

- [`multipass transfer` command](https://multipass.run/docs/transfer-command)
- [How to share data with an instance](https://multipass.run/docs/share-data-with-an-instance)


