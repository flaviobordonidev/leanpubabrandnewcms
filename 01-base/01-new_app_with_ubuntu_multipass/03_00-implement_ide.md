# <a name="top"></a> Cap 1.3 - Implementiamo la IDE

In questo capitolo Implementiamo la parte grafica per lo sviluppo e Colleghiamo VS Code alla VM tramite SSH.



## Risorse esterne

- [Remote Development with VS Code on Mac](https://medium.com/macoclock/remote-development-with-vscode-on-mac-in-simple-5-steps-6ae100938d67)



## Che cos'è un IDE

L'IDE è un *ambiente di sviluppo integrato* (Integrated Development Environment). Ossia il programma che usiamo per scrivere il codice. Nel nostro caso la scelta è **Visual Studio Code**.


## Installiamo Visaul Studio Code

Basta andare sul sito della microsoft e scaricarlo tanto è gratuito ed open source ^_^

- Download and install VS Code for mac
    Go to URL https://code.visualstudio.com/download and click on the download button.
- Extract the zip file generated using the below command on the command line. or double click on the zip file to extract the content.
    tar -xvzf VSCode-darwin-stable.zip
- Double click on the Visual Studio Code. app to launch VS Code.

> Note: Drag it to the application folder to make it available on the launch pad. Make it available on the dock by right-clicking and choosing option keep in doc



## Installiamo Visual Studio Code Remote Development Extension Pack

Apriamo Visual Studio Code. Sulla barra del menu laterale clicchiamo sull'icona *extension*. Cerchiamo *remote development extension pack* ed installiamolo.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/03_fig01-install_remote_development_pack.png)



## Aggiungiamo su VS Code il collegamento SSH alla VM

Colleghiamo Visual Studio Code alla Virtual Machine con Ubuntu Linux tramite Secure SHell.

> Prerequisiti <br/>
> Local: Ssh client compatible with openssh. On macOS, it comes preinstalled. <br/>
> Remote SSH host: A running ssh server on your remote Linux machine. (Fatto nei capitoli precedenti)
>
> Abbiamo già visto che riusciamo a collegarci con la VM eseguendo da terminale di macOS il comando `$ ssh nomeutente@hostip`. Nello specifico `$ ssh -p 22 ubuntu@192.168.64.3`.



Nella *palette dei comandi* (F1) selezioniamo *Remote-SSH: Add New SSH Host…*

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/03_fig02-command_palette.png)

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/03_fig03-remote_ssh_add_new.png)

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/03_fig04-remote_ssh_command.png)

Inseriamo il comando per la connessione `$ ssh ubuntu@192.168.64.3`.

> la riga di esempio suggerita da VS Code aggiunge l'opzione *-A* ma noi non la usiamo

Ci viene poi chiesto di salvare le impostazioni in un file che userà per collegarsi.  

![fig05](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/03_fig05-remote_ssh_select_config.png)

> Nel mio caso Scelgo */Users/FB/.ssh/config* <br/>
> *FB* è il mio nome utente su macOS, nel tuo pc sarà differente! ^_^

Il file di configurazione che viene creato ha le indicazioni per la connessione.

![fig06](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/03_fig06-remote_ssh_config_file.png)



## Colleghiamo VS Code alla VM tramite SSH

Colleghiamo Visual Studio Code alla Virtual Machine con Ubuntu Linux tramite Secure SHell.

Nella *palette dei comandi* (F1) selezioniamo *Remote-SSH: Connect to Host…*

![fig07](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/03_fig07-remote_ssh_connect.png)

Dal menu a tendina scegliamo l'host già aggiunto (*192.168.64.3*).

![fig08](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/03_fig08-remote_ssh_select.png)

Digitiamo la password quando richiesta.

![fig09](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/03_fig09-remote_ssh_password.png)

Adesso VS Code è connesso come possiamo vedere dal menu in basso.

> Normalamente Vs Code rileva automaticamente il tipo di server e si connette. In caso contrario ci verrà chiesto di selezionare il tipo manualmente.

![fig10](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/03_fig10-remote_ssh_connected.png)

You can edit this in vscode settings (Code > Preferences > Settings)by updating remote.SSH.remotePlatform property
After a moment, VS Code will connect to the SSH server and set itself up. VS Code will keep you up-to-date using a progress notification and you can see a detailed log in the Remote - SSH output channel. You can check the status bar to check the remote host you are connected to.



## Apriamo la directory test

Apriamo da VS Code la cartella *test* che abbiamo creato sulla ns VM.
Usiamo `File > Open…` oppure `File > Open Workspace…` 

![fig11](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/03_fig11-remote_ssh_file_open.png)

Selezioniamo *test* e premiamo il pulsante *OK*.
Ci verrà chiesta di nuovo la password.
Adesso siamo collegati e possiamo lavorare in quella cartella. 
Ad esempio aggiungiamo il file *pippo.md* e scriviamoci dentro *Ciao VM!*.

![fig12](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/03_fig12-remote_ssh_file_pippo.png)

Se adesso ci colleghiamo da Terminale di macOS alla VM usando multipass possiamo vedere che c'è il nuovo file *pippo.md*

```bash
MacBook-Pro-di-Flavio:~ FB$ multipass list
Name                    State             IPv4             Image
flub                    Stopped           --               Ubuntu 20.04 LTS
ubuntufla               Running           192.168.64.3     Ubuntu 20.04 LTS
MacBook-Pro-di-Flavio:~ FB$ multipass shell ubuntufla
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-99-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Thu Mar  3 12:37:43 CET 2022

  System load:  0.13               Processes:               118
  Usage of /:   10.9% of 19.21GB   Users logged in:         0
  Memory usage: 10%                IPv4 address for enp0s2: 192.168.64.3
  Swap usage:   0%

 * Super-optimized for small spaces - read how we shrank the memory
   footprint of MicroK8s to make it the smallest full K8s around.

   https://ubuntu.com/blog/microk8s-memory-optimisation

13 updates can be applied immediately.
To see these additional updates run: apt list --upgradable


*** System restart required ***
Last login: Thu Mar  3 10:44:51 2022 from 192.168.64.1
ubuntu@ubuntufla:~$ ls
test
ubuntu@ubuntufla:~$ cd test/
ubuntu@ubuntufla:~/test$ ls
pippo.md
ubuntu@ubuntufla:~/test$ nano pippo.md 
ubuntu@ubuntufla:~/test$ cat pippo.md 
Ciao VM!
ubuntu@ubuntufla:~/test$ 
```


---
[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/02_00-install_ssh_server.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/04_00-intall_rails.md)
