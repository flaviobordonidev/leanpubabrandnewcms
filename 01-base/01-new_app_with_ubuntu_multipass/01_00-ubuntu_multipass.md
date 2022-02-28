# <a name="top"></a> Cap 1.1 - L'ambiente di sviluppo Ubuntu Server Multipass

Il nostro ambiente di sviluppo è su Ubuntu Server attivato con multipass e raggiunto tramite ssh con Visual Code.



## Risorse esterne

- [Dal sito di ubuntu al -> sito multipass](https://multipass.run/docs/installing-on-macos)
- https://multipass.run/docs
- https://discourse.ubuntu.com/t/graphical-desktop-in-multipass/16229
- https://www.techrepublic.com/article/how-to-install-a-full-desktop-on-a-multipass-virtual-machine-for-easier-linux-development/
- https://discourse.ubuntu.com/t/is-there-a-way-to-extend-the-disk-allocated-for-the-instance/19346
- https://github.com/canonical/multipass/issues/62



## Installato multipass usando brew
Creo istanza da 20G di spazio disco con il comando:

```bash
$ multipass launch --name ubuntufla --cpus 2 --mem 1G --disk 20G
$ multipass shell ubuntufla
$ sudo apt update
$ sudo apt install ubuntu-desktop xrdp
$ sudo passwd ubuntu
```

We will be asked to enter and re-enter a password. And we are done on the server side.

For the client, we can use on Windows the “Remote Desktop Connection” application. There, we enter the virtual machine’s IP address (which can be found by issuing the command ip addr on the guest), set the session to XOrg and enter the username and password we created on the previuos step. And we are done… a graphical desktop!

To connect on MacOS, we can use the “Microsoft Remote Desktop” application, from the Mac App Store.

On Linux, there are applications such as Remmina to visualize the desktop (make sure the package remmina-plugin-rdp is installed in your host along with remmina, and that username and password are specified using the “New connection profile” button in the top left of the window).

> Non usiamo il collegamento tramite Remote Desktop perché non installiamo l'interfaccia grafica sul server. <br/>
> Invece attiviamo il server ssh e ci colleghiamo con Visual Studio Code tramite ssh.


Lascio ubuntu server senza interfaccia grafica e mi collego da Visual Code
https://medium.com/macoclock/remote-development-with-vscode-on-mac-in-simple-5-steps-6ae100938d67
https://devconnected.com/how-to-install-and-enable-ssh-server-on-ubuntu-20-04/

Installato multipass usando brew
Creo istanza da 20G di spazio disco con il comando:

$ multipass launch --name ubuntufla --cpus 2 --mem 1G --disk 20G
$ multipass shell ubuntufla
$ sudo passwd ubuntu

$ sudo apt-get update
$ sudo apt-get install openssh-server
$ sudo systemctl status sshd

Apriamo una nuova finestra di terminale e lanciamo “ssh username@hostip”

$ ssh ubuntu@hostip


Risolviamo errore di connessione (manca la richiesta della password)
https://phoenixnap.com/kb/ssh-permission-denied-publickey#:~:text=the%20solutions%20below.-,Solution%201%3A%20Enable%20Password%20Authentication,login%20in%20the%20sshd_config%20file.&text=In%20the%20file%2C%20find%20the,sure%20it%20ends%20with%20yes%20.




## Che cos'è Ubuntu Server Multipass

Multipass is a mini-cloud on your workstation using native hypervisors of all the supported plaforms (Windows, macOS and Linux), it will give you an Ubuntu command line in just a click (“Open shell”) or a simple multipass shell command, or even a keyboard shortcut. Find what images are available with multipass find and create new instances with multipass launch.

Con multipass puoi creare dei server linux da terminale.

```bash
$ brew install --cask multipass

$ multipass list
$ multipass stop <nome-server-ubuntu>
$ multipass start <nome-server-ubuntu>
$ multipass shell flub <nome-server-ubuntu>

$ ssh -p 22 ubuntu@192.168.64.4
```

Esempio:

```bash
$ multipass list
MacBook-Pro-di-Flavio:~ FB$ multipass list
Name                    State             IPv4             Image
flub                    Stopped           --               Ubuntu 20.04 LTS
```


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

