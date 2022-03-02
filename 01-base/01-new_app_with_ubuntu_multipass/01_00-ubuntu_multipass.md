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

Multipass è fatto da Canonical e nasce per creare macchine virtuali linux sul nostro computer.
Nel caso di questo corso il computer usato ha un sistema operativo macOS, ma multipass possiamo installarlo anche su un pc con sistema operativo windows o anche linux stesso. 

> Multipass è un modo semplice per creare e gestire VM (Virtual Machines) tutto da terminale. <br/>
> Con multipass puoi creare dei server linux da terminale.

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

## First run

Once installed, open the Terminal app and you can use multipass launch to create your first instance.

With `multipass version` you can check which version you have running.

```bash
$ multipass version
```

Esempio:

```bash
multipass 1.0.0+mac
multipassd 1.0.0+mac
```



## Creiamo la macchina virtuale

Creiamo la macchina virtuale (VM: Virtual Machine). 

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



## Giochiamo con multipass


```bash
$ multipass list
$ multipass stop <nome-server-ubuntu>
$ multipass start <nome-server-ubuntu>
$ multipass shell flub <nome-server-ubuntu>
```

Esempio:

```bash
$ multipass list
MacBook-Pro-di-Flavio:~ FB$ multipass list
Name                    State             IPv4             Image
flub                    Stopped           --               Ubuntu 20.04 LTS
```



## Entriamo nella nostra VM

Adesso logghiamoci nella nostra istanza di Ubuntu Linux ed impostiamo la password per l'utente di default che si chiama *ubuntu* (che fantasia che hanno in Canonical ^_^).

```bash
$ multipass shell ubuntufla

$ sudo passwd ubuntu
```

Ci sarà chiesto di inserire una password e di confermarla.



## Verifichiamo i nostri privilegi 

Verfichiamo che l'utente *ubuntu* sulla VM abbia i privilegi di amministratore.

```bash
$ multipass shell ubuntufla

$ sudo -l
```

If you see the following lines on your terminal, it means that you currently belongs to the sudo group.

User user may run the following commands on server-ubuntu:
    (ALL : ALL) ALL
Alternatively, you can run the “groups” command and verify that “sudo” is one of the entries.

```bash
$ multipass shell ubuntufla

$ groups
```


## Non ci serve interfaccia grafica

> ATTEMZIONE! potete **saltare** questo paragrafo.
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
