# <a name="top"></a> Cap multipass_ubuntu.1 - L'ambiente di sviluppo Ubuntu Server Multipass

Il nostro ambiente di sviluppo è su Ubuntu Server attivato con multipass e raggiunto tramite ssh con Visual Code.



## Risorse esterne

- [Dal sito di ubuntu al -> sito multipass](https://multipass.run/docs/installing-on-macos)
- https://multipass.run/docs
- https://brew.sh/
- https://ubuntu.com/server/docs/virtualization-multipass
- https://discourse.ubuntu.com/t/graphical-desktop-in-multipass/16229
- https://www.techrepublic.com/article/how-to-install-a-full-desktop-on-a-multipass-virtual-machine-for-easier-linux-development/
- https://discourse.ubuntu.com/t/is-there-a-way-to-extend-the-disk-allocated-for-the-instance/19346
- https://github.com/canonical/multipass/issues/62

- https://medium.com/codex/use-linux-virtual-machines-with-multipass-4e2b620cc6



## Che cos'è Ubuntu Server Multipass

Multipass è un progetto di Canonical (l'azienda che mantiene Ubuntu) per creare macchine virtuali Ubuntu Linux sul nostro computer tramite terminale.
Per il nostro progetto sto utilizzando un notebook MAC con sistema operativo macOS, ma multipass possiamo installarlo anche su un pc con sistema operativo windows o anche linux stesso.

> Con multipass puoi creare dei server linux da terminale. <br/>
> Multipass è un modo semplice per creare e gestire VM (Virtual Machines) tutto da terminale.
> Multipass è open source e gratuito.

Multipass utilizza hypervisor nativi di tutte le piattaforme supportate (Windows, macOS e Linux), ci dà una riga di comando di Ubuntu con un semplice comando nel terminale `multipass shell <nome-VM>`.



## Installazione (install)

- [homebrew site: multipass](https://formulae.brew.sh/cask/multipass)
- [How to install Multipass on macOS](https://multipass.run/docs/installing-on-macos)

Si può fare l'installazione scaricando il file ".pkg" oppure usare "brew".

> multipass 1.13.0 ha problemi con mac con chip M3
> ho dovuto installare multipass 1.11.1 (l'ho fatto tramite file ".pkg")
> https://github.com/canonical/multipass/issues/3308


Vediamo l'installazione con brew:

> Se non l'hai già installato, per installare "brew" vedi [code_references/brew]().

```shell
$ brew install --cask multipass
```

Esempio:

```shell
❯ brew install --cask multipass
==> Downloading https://formulae.brew.sh/api/cask.jws.json
######################################################################### 100.0%
==> Downloading https://raw.githubusercontent.com/Homebrew/homebrew-cask/393b87c
######################################################################### 100.0%
==> Downloading https://github.com/canonical/multipass/releases/download/v1.13.0
Already downloaded: /Users/fb/Library/Caches/Homebrew/downloads/d693bce8b9851bd947f5f62099819bd403aaf30009760e46c51dbddce5532dba--multipass-1.13.0+mac-Darwin.pkg
==> Installing Cask multipass
==> Running installer for multipass with sudo; the password may be necessary.
Password:
installer: Package name is multipass
installer: Installing at base path /
installer: The install was successful.
🍺  multipass was successfully installed!
 ~ ──────────────────────────────────────────────────────────── 15s │ 00:43:14 
❯ 
```

Verifichiamo la versione.

```shell
❯ multipass version
multipass   1.13.0+mac
multipassd  1.13.0+mac
```

-[info sulle releases](https://github.com/canonical/multipass/releases)



## Disinstallazione (Unistall)

Salta questo paragrafo a meno che non ti serva.

- [Multipass si era bloccato e non riuscivo a disinstallarlo e questo post ha risolto](https://github.com/canonical/multipass/issues/3257)
- [How to install (and uninstall) Multipass on macOS](https://multipass.run/docs/installing-on-macos#heading--install-upgrade-uninstall)

Per disinstallare un installazione fatta scaricando il file ".dmg / .pkg" --> To uninstall, run the script:

```shell
❯ sudo sh "/Library/Application Support/com.canonical.multipass/uninstall.sh"
```

Se invece abbiamo installato con "brew"

To uninstall:

```shell
$ brew uninstall multipass

# or

$ brew uninstall --zap multipass # to destroy all data, too
```

Col comando `multipass version` puoi controllare quale versione hai in esecuzione.

```shell
$ multipass version
```




## Creiamo la macchina virtuale

-[Dal manuale multipass](https://ubuntu.com/server/docs/virtualization-multipass)

Vediamo l'elenco di sistemi operativi che posso caricare nella VM

```shell
❯ multipass find
```

Esempio:

```shell
❯ multipass find
Image                       Aliases           Version          Description
20.04                       focal             20240118         Ubuntu 20.04 LTS
22.04                       jammy,lts         20240126         Ubuntu 22.04 LTS
23.10                       mantic            20240125         Ubuntu 23.10

Blueprint                   Aliases           Version          Description
anbox-cloud-appliance                         latest           Anbox Cloud Appliance
charm-dev                                     latest           A development and testing environment for charmers
docker                                        0.4              A Docker environment with Portainer and related tools
jellyfin                                      latest           Jellyfin is a Free Software Media System that puts you in control of managing and streaming your media.
minikube                                      latest           minikube is local Kubernetes
ros-noetic                                    0.1              A development and testing environment for ROS Noetic.
ros2-humble                                   0.1              A development and testing environment for ROS 2 Humble.
```

Nel nostro caso siamo interessati a Ubuntu 22.04 LTS (image: 22.04) quindi creiamo la VM con questo sistema operativo.

*** ATTENZIONE ***
*** Al capitolo 4 c'è il comando `multipass launch ...` in cui impostiamo anche le CHIAVI DI CRITTATURA ***
*** Possiamo saltare direttamente là ed usare i capitoli 1, 2 e 3 come supporto ***

Creiamo un'istanza con 20Gb di spazio disco e 4Gb di memoria e diamogli un nome. Io la chiamo "ub22fla".

```shell
❯ multipass launch 22.04 --name ub22fla --cpus 1 --memory 4G --disk 20G
```

> Se avessi avuto un computer con 4 cpus 16 Gb di RAM ed 1 TB di hd probabilmente avrei usato il comando <br/>
> $ multipass launch 22.04 --name ub22fla --cpus 2 --memory 4G --disk 40G

Non lanciamo il comando senza parametri altrimenti ci crea una VM con le impostazioni di default e gli da un nome a caso.

> La versione multipass 1.13 di default crea una macchina virtuale con 1 cpu, 1G mem, 5G disk. 
>
> È più corretto dire "creare un'istanza di VM" ma per semplicità uso "creare la VM".
> VM vuol dire macchina virtuale (Virtual Machine)


Esempio:

```shell
MacBook-Pro-di-Flavio:~ FB$ multipass launch --name ubuntufla --mem 4G --disk 20G
Launched: ubuntufla                                                             
MacBook-Pro-di-Flavio:~ FB$ multipass list
Name                    State             IPv4             Image
flub                    Running           192.168.64.4     Ubuntu 20.04 LTS
ubuntufla               Running           192.168.64.3     Ubuntu 20.04 LTS
MacBook-Pro-di-Flavio:~ FB$ 
```



## Comandi base di multipass

I comandi base di multipass per fermare e far ripartire le VM e per entrare sul loro terminale.

```shell
❯ multipass list
❯ multipass stop <VMnname>
❯ multipass start <VMnname>
❯ multipass shell <VMnname>
```

Esempio:

```shell
MacBook-Pro-di-Flavio:~ FB$ multipass list
Name                    State             IPv4             Image
flub                    Running           192.168.64.4     Ubuntu 20.04 LTS
ubuntufla               Running           192.168.64.3     Ubuntu 20.04 LTS
MacBook-Pro-di-Flavio:~ FB$ multipass stop flub
MacBook-Pro-di-Flavio:~ FB$ multipass list
Name                    State             IPv4             Image
flub                    Stopped           --               Ubuntu 20.04 LTS
ubuntufla               Running           192.168.64.3     Ubuntu 20.04 LTS
```



## Comandi multipass per eliminare una VM


```shell
❯ multipass list
❯ multipass stop <VMnname>

❯ multipass delete <VMnname>
❯ multipass purge
```



## Entriamo nella nostra VM

Adesso logghiamoci nella nostra istanza di Ubuntu Linux ed impostiamo la password per l'utente di default che si chiama *ubuntu* (che fantasia che hanno in Canonical ^_^).

```shell
$ multipass shell ubuntufla
```



## Aggiorniamo il sistema operativo

Per mantenere il sistema operativo aggiornato eseguiamo:

```bash
$ sudo apt update
$ sudo apt upgrade
```

Poi uscire e riavviare la macchina.

> prima di dare `shell` assicurarsi che la macchina sia "running" con `list`

```bash
$ exit
$ multipass stop ub22fla
$ multipass start ub22fla
$ multipass list
$ multipass shell ub22fla
```



## Assegnamo una password al nostro utente

*** FACOLTATIVO! POSSIAMO SALTARLO ***

```shell
$ whoami
$ sudo passwd ubuntu
```

Ci sarà chiesto di inserire una password e di confermarla.

Esempio:

```shell
ubuntu@ubuntufla:~$ whoami
ubuntu
ubuntu@ubuntufla:~$ sudo passwd ubuntu
New password: 
Retype new password: 
passwd: password updated successfully
ubuntu@ubuntufla:~$ 
```



## Verifichiamo i nostri privilegi 

Verfichiamo che l'utente *ubuntu* sulla VM abbia i privilegi di amministratore.

```shell
$ sudo -l
```

> Se vedi le seguenti righe sul tuo terminale, significa che attualmente appartieni al gruppo **sudo**.
>
> `User user may run the following commands on server-ubuntu:`
> `   (ALL : ALL) ALL`

Esempio:

```shell
ubuntu@ub22fla:~$ sudo -l
Matching Defaults entries for ubuntu on ub22fla:
    env_reset, mail_badpass, secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin, use_pty

User ubuntu may run the following commands on ub22fla:
    (ALL : ALL) ALL
    (ALL) NOPASSWD: ALL
ubuntu@ub22fla:~$ 
```

In alternativa, puoi eseguire il comando `groups` e verificare che **sudo** sia una delle voci.

```shell
$ groups
```

Esempio:

```shell
ubuntu@ub22fla:~$ groups
ubuntu adm dialout cdrom floppy sudo audio dip video plugdev netdev lxd
ubuntu@ub22fla:~$ 
```



## Mantenere la distribuzione aggiornata

```bash
$ sudo apt update
$ sudo apt upgrade
```



## Installare interfaccia grafica (Non ci serve)

> ATTENZIONE! possiamo **saltare** questo paragrafo.
> è solo didattico e non lo useremo nella nostra app.

Attenzione questo **non** serve per la nostra app perché useremo un IDE grafico direttamente su MAC che si collegherà alla macchina virtuale tramite ssh.

```shell
❯ multipass shell ubuntufla
$ sudo apt update`
$ sudo apt install ubuntu-desktop xrdp
```

To connect on MacOS, we can use the “Microsoft Remote Desktop” application, from the Mac App Store.
There, we enter the virtual machine’s IP address (which can be found by issuing the command ip addr on the guest), set the session to XOrg and enter the username and password we created on the previuos step. And we are done… a graphical desktop!

On Linux, there are applications such as ***Remmina*** to visualize the desktop (make sure the package remmina-plugin-rdp is installed in your host along with remmina, and that username and password are specified using the “New connection profile” button in the top left of the window).

> Noi **Non** usiamo il collegamento tramite Remote Desktop perché non installiamo l'interfaccia grafica sul server. <br/
> Invece attiviamo il server ssh e ci colleghiamo con Visual Studio Code tramite ssh.



---
[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/00-frontmatter/03-introduction.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/02_00-install_ssh_server.md)
