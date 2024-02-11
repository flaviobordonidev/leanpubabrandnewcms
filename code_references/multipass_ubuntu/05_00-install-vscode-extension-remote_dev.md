# <a name="top"></a> Cap 1.3 - Permettiamo a vscode di collegarsi alla VM di multipass

Colleghiamo vscode (Visual Studio Code) alla VM tramite SSH.

Per farlo installiamo in vscode l'estensione `remote_dev` (install-vscode-extension-remote_dev).



## Risorse esterne

- [Remote Development using SSH](https://code.visualstudio.com/docs/remote/ssh)
- [VS Code Remote Development](https://code.visualstudio.com/docs/remote/remote-overview)
- [Remote Development with VS Code on Mac](https://medium.com/macoclock/remote-development-with-vscode-on-mac-in-simple-5-steps-6ae100938d67)
- [SSH into Remote VM with VS Code | Tunneling into any cloud | GCP Demo](https://www.youtube.com/watch?v=0Bjx3Ra8PRM)
- [Using VS Code with GCP VMs](https://learn.canceridc.dev/cookbook/virtual-machines/using-vs-code-with-gcp-vms)
- [Use VSCode and Remote SSH extension to connect to Compute Engine on Google Cloud](https://medium.com/@ivanzhd/vscode-sftp-connection-to-compute-engine-on-google-cloud-platform-gcloud-9312797d56eb)
- [ssh -A option](https://yakking.branchable.com/posts/ssh-A/)



## Installiamo Visaul Studio Code

- [vedi code_references/visual_studio_code/01_00-overview]()



## Installiamo l'estensione remote-ssh

L'estensione che ci serve su vscode è:

- `Remote - SSH`

> Alcuni articoli suggeriscono di usare l'estensione `Remote Development` che è una suite con più estensioni all'interno tra cui `Remote - SSH` che è quella che ci serve realmente. 

Apriamo Visual Studio Code. Sulla barra del menu laterale clicchiamo sull'icona *extension*. Cerchiamo *remote-ssh* ed installiamolo.

- Apriamo Visual Studio Code 
- clicchiamo nella sezione delle estensioni (extensions)
- Verifichiamo che "Remote - SSH" sia installato.
  - Altrimenti lo installiamo mettendo nel campo di ricerca la voce "remote-ssh"
  - clicchiamo sull'icona
  - clicchiamo su "Install"

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/03_fig01-install_remote_development_pack.png)



## Aggiungiamo su VS Code il collegamento SSH alla VM

Colleghiamo Visual Studio Code alla Virtual Machine con Ubuntu Linux tramite Secure SHell.

> Prerequisiti <br/>
> Local: Ssh client compatible with openssh. On macOS, it comes preinstalled. <br/>
> Remote SSH host: A running ssh server on your remote Linux machine. (Fatto nei capitoli precedenti)
>
> Abbiamo già visto che riusciamo a collegarci con la VM eseguendo da terminale di macOS il comando `❯ ssh nomeutente@hostip`. 
> Nello specifico `❯ ssh -i ~/.ssh/ub22fla_key_ed25519 ubuntu@192.168.64.4`.


- *View* -> *Command Palette...* -> selezioniamo *Remote-SSH: Add New SSH Host…*

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/03_fig02-command_palette.png)

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/03_fig03-remote_ssh_add_new.png)

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/03_fig04-remote_ssh_command.png)

> la riga di esempio suggerita da vscode è `ssh hello@microsoft.com -A`.

Noi ci inseriamo il comando per la connessione che abbiamo usato nel capitolo anteriore: `ssh -i ~/.ssh/ub22fla_key_ed25519 ubuntu@192.168.64.4`.

Ci viene poi chiesto di salvare le impostazioni nel file `/Users/FB/.ssh/config` per semplificare i futuri collegamenti.

> *FB* è il mio nome utente su macOS, nel tuo pc sarà differente! ^_^

![fig05](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/03_fig05-remote_ssh_select_config.png)

Il file di configurazione che viene creato ha le indicazioni per la connessione.

```shell
Host 192.168.64.4
  HostName 192.168.64.4
  User ubuntu
  IdentityFile ~/.ssh/ub22fla_key_ed25519
```

![fig06](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/03_fig06-remote_ssh_config_file.png)



## Colleghiamo vscode alla VM tramite SSH

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



## Personaliziamo il file .ssh/config

Invece dell'indirizzo IP possiamo dare un nome alla connessione per rendere più facile i collegamenti successivi.

- Click su "View" -> "Command Palette..."
- cerchiamo per "Remote-SSH: Open SSH Configuration file..." 
  - e scegliamo `~/.ssh/config` (`~` nel mio caso è `/Users/FB`)
  - oppure avremmo potututo cercare per "Remote-SSH: Add new SSH Host..."

La struttura base del file è questa:

```shell
Host alias per dare un nome al posto dell IP address
  HostName hostname or IP address
  IdentityFile percorso alla chiave privata
  User username
```

Diamo alla connessione lo stesso nome che usiamo su multipass.

[Codice 01 - ~/.ssh/config - linea: 1]()

```shell
Host ub22fla
  HostName 192.168.64.4
  IdentityFile ~/.ssh/ub22fla_key_ed25519
  User ubuntu
```


Se aggiungiamo altre connessioni il file crescerà tipo questo:

[Codice 02 - ~/.ssh/config - linea: 1]()

```shell
Host ub22fla
  HostName 192.168.64.4
  IdentityFile ~/.ssh/ub22fla_key_ed25519
  User ubuntu

Host 192.168.64.7
  HostName 192.168.64.7
  IdentityFile ~/.ssh/altro_server_key_ed25519
  User ubuntu

Host mio_server_pippo
  HostName 192.168.64.3
  IdentityFile ~/.ssh/server_pippo_key_ed25519
  User ubuntu
```



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
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/04_00-install_rails.md)
