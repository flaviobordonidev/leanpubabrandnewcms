# <a name="top"></a> Cap multipass_ubuntu.03 - Montiamo una directory per spos

Montiamo una directory per spostare files dalla macchina virtuale (VM) alla macchina fisica dove sta girando la macchina virtuale (pc host).

> Per spostare ad un altro computer sulla rete vedi comando "scp" o "rsync"



## Risorse interne

- [code_references/postgresql/04_00-backup_and_restore_database_render-it.md]()
- [How to share data between host and VM with Multipass](https://www.youtube.com/watch?v=vrLcER1V2Co)



## Spostiamo il file dalla VM multipass al PC fisico

Dal terminale (consolle, shell) del mac montiamo una cartella del ns mac su una VM di multipass.

```shell
❯ multipass list
❯ multipass info ub22fla

# Montiamo la cartella "home" del mac (/Users/FB) sulla VM ub22fla nello stesso percorso (/Users/FB)
❯ multipass mount ~ ub22fla

❯ multipass info ub22fla
❯ multipass shell ub22fla
ubuntu@ub22fla:~$ ls /Users/fb/
ubuntu@ub22fla:~$ cd /Users/fb/
ubuntu@ub22fla:/Users/FB$ cp ~/database_dump.sql .
ubuntu@ub22fla:/Users/FB$ exit

❯ multipass unmount ub22fla
```

Esempio:

```shell
❯ multipass shell ub22fla
ubuntu@ub22fla:~$ pwd
/home/ubuntu
ubuntu@ub22fla:~$ ls
ubuntu@ub22fla:~$ ls -a
.  ..  .bash_history  .bash_logout  .bashrc  .cache  .profile  .ssh  .sudo_as_admin_successful
ubuntu@ub22fla:~$ exit
logout

❯ multipass list
Name                    State             IPv4             Image
ub22fla                 Running           192.168.64.3     Ubuntu 22.04 LTS

❯ multipass info ub22fla
Name:           ub22fla
State:          Running
IPv4:           192.168.64.3
Release:        Ubuntu 22.04.3 LTS
Image hash:     dddfb1741f16 (Ubuntu 22.04 LTS)
CPU(s):         1
Load:           0.00 0.00 0.00
Disk usage:     1.6GiB out of 19.2GiB
Memory usage:   124.0MiB out of 3.8GiB
Mounts:         --

❯ multipass mount ~ ub22fla
❯ multipass info ub22fla
Name:           ub22fla
State:          Running
IPv4:           192.168.64.3
Release:        Ubuntu 22.04.3 LTS
Image hash:     dddfb1741f16 (Ubuntu 22.04 LTS)
CPU(s):         1
Load:           0.16 0.07 0.02
Disk usage:     1.6GiB out of 19.2GiB
Memory usage:   139.5MiB out of 3.8GiB
Mounts:         /Users/fb => /Users/fb
                    UID map: 501:default
                    GID map: 20:default

❯ multipass shell ub22fla
ubuntu@ub22fla:~$ ls /Users/fb/
 Applications   Desktop   Documents   Downloads   Dropbox  'Google Drive'   Library   Movies   Music   Pictures   Public
#Adesso abbiamo la possibilità di scambiarci files tramite ile percorso /Users/fb/
#Sul mac possiamo andarci anche tramite interfaccia grafica usando l'applicazione di default **finder**.

ubuntu@ub22fla:~$ exit
❯ multipass unmount ub22fla
❯ multipass info ub22fla
Name:           ub22fla
State:          Running
IPv4:           192.168.64.3
Release:        Ubuntu 22.04.3 LTS
Image hash:     dddfb1741f16 (Ubuntu 22.04 LTS)
CPU(s):         1
Load:           0.00 0.00 0.00
Disk usage:     1.6GiB out of 19.2GiB
Memory usage:   128.1MiB out of 3.8GiB
Mounts:         --
```


