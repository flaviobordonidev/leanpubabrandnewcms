# <a name="top"></a> Cap 1.1 - L'ambiente di sviluppo Ubuntu Server Multipass

Il nostro ambiente di sviluppo è su Ubuntu Server attivato con multipass e raggiunto tramite ssh con Visual Code.



## Risorse esterne

- [Dal sito di ubuntu al -> sito multipass](https://multipass.run/docs/installing-on-macos)
- https://multipass.run/docs
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



## Installazione

Per installare su Mac consigliamo l'installazione attraverso *brew*.

Have a look at [brew.sh](https://brew.sh/) on instructions to install Brew itself. Then, it’s a simple:

```bash
$ brew install --cask multipass
```

To uninstall:

```bash
$ brew uninstall multipass

# or

$ brew uninstall --zap multipass # to destroy all data, too
```

Col comando `multipass version` puoi controllare quale versione hai in esecuzione.

```bash
$ multipass version
```

Esempio:

```bash
MacBook-Pro-di-Flavio:~ FB$ multipass version
multipass   1.8.1+mac
multipassd  1.8.1+mac
```



## Creiamo la macchina virtuale

Una volta installato, apri l'app Terminale e puoi utilizzare il comando `multipass launch` per creare la tua prima istanza. Creiamo la macchina virtuale (VM: Virtual Machine). 

Creo istanza da 20G di spazio disco con il comando:

```bash
$ multipass launch --name ubuntufla --mem 4G --disk 20G
```

> Se avessi usato `multipass launch --name ubuntufla` la macchina virtuale avrebbe avuto 1 cpu, 1G mem, 5G disk. 
>
> Avendo il mio computer una sola CPU lascio il valore di default che è 1 altrimenti potevo passare `--cpus 2`
>
> Se avessi avuto un computer con 4 cpus 16 Gb di RAM ed 1 TB di hd probabilmente avrei usato il comando <br/>
> $ multipass launch --name ubuntufla --cpus 2 --mem 4G --disk 40G

Esempio:

```bash
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

```bash
$ multipass list
$ multipass stop <VMnname>
$ multipass start <VMnname>
$ multipass shell <VMnname>
```

Esempio:

```bash
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



## Entriamo nella nostra VM

Adesso logghiamoci nella nostra istanza di Ubuntu Linux ed impostiamo la password per l'utente di default che si chiama *ubuntu* (che fantasia che hanno in Canonical ^_^).

```bash
$ multipass shell ubuntufla
$ sudo passwd ubuntu
```

Ci sarà chiesto di inserire una password e di confermarla.

Esempio:

```bash
MacBook-Pro-di-Flavio:~ FB$ multipass shell ubuntufla
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-99-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Wed Mar  2 17:27:25 CET 2022

  System load:  0.41              Processes:               121
  Usage of /:   6.9% of 19.21GB   Users logged in:         0
  Memory usage: 4%                IPv4 address for enp0s2: 192.168.64.3
  Swap usage:   0%


1 update can be applied immediately.
To see these additional updates run: apt list --upgradable


The list of available updates is more than a week old.
To check for new updates run: sudo apt update

Last login: Wed Mar  2 17:26:02 2022 from 192.168.64.1
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

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

```bash
$ sudo -l
```

> Se vedi le seguenti righe sul tuo terminale, significa che attualmente appartieni al gruppo **sudo**.
>
> `User user may run the following commands on server-ubuntu:`
> `   (ALL : ALL) ALL`

Esempio:

```bash
ubuntu@ubuntufla:~$ sudo -l
Matching Defaults entries for ubuntu on ubuntufla:
    env_reset, mail_badpass, secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin

User ubuntu may run the following commands on ubuntufla:
    (ALL : ALL) ALL
    (ALL) NOPASSWD: ALL
ubuntu@ubuntufla:~$
```

In alternativa, puoi eseguire il comando `groups` e verificare che **sudo** sia una delle voci.

```bash
$ groups
```

Esempio:

```bash
ubuntu@ubuntufla:~$ groups
ubuntu adm dialout cdrom floppy sudo audio dip video plugdev netdev lxd
ubuntu@ubuntufla:~$ 
```



## Non ci serve interfaccia grafica

> ATTENZIONE! possiamo **saltare** questo paragrafo.
> è solo didattico e non lo useremo nella nostra app.

Attenzione questo **non** serve per la nostra app perché useremo un IDE grafico direttamente su MAC che si collegherà alla macchina virtuale tramite ssh.

> `$ multipass shell ubuntufla`
> 
> `$ sudo apt update` <br/>
> `$ sudo apt install ubuntu-desktop xrdp`

To connect on MacOS, we can use the “Microsoft Remote Desktop” application, from the Mac App Store.
There, we enter the virtual machine’s IP address (which can be found by issuing the command ip addr on the guest), set the session to XOrg and enter the username and password we created on the previuos step. And we are done… a graphical desktop!

On Linux, there are applications such as ***Remmina*** to visualize the desktop (make sure the package remmina-plugin-rdp is installed in your host along with remmina, and that username and password are specified using the “New connection profile” button in the top left of the window).

> Noi **Non** usiamo il collegamento tramite Remote Desktop perché non installiamo l'interfaccia grafica sul server. <br/
> Invece attiviamo il server ssh e ci colleghiamo con Visual Studio Code tramite ssh.



---
[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/00-frontmatter/03-introduction.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/02_00-install_ssh_server.md)
