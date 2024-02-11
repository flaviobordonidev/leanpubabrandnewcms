# <a name="top"></a> Cap 1.1 - Impostiamo l'IDE Visual Studio Code

Aggiungiamo al nostro ambiente di sviluppo l'editor per il codice.
Usiamo Visual Studio Code.


## Risorse interne
- [code_references/visual_studio_code/01_00-install_vscode](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/visual_studio_code/01_00-install_vscode.md)
- [code_references/multipass_ubuntu/05_00-install-vscode-extension-remote_dev.md](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/multipass_ubuntu/05_00-install-vscode-extension-remote_dev.md)


- [code_references/multipass_ubuntu/05_00-connect_vscode]()



## Installiamo vscode

Installiamo Visual Studio Code scaricando il file ".zip" dal sito https://code.visualstudio.com/download


per approfondimenti vedi:

- [code_references/visual_studio_code/01_00-install_vscode](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/visual_studio_code/01_00-install_vscode.md)



## Installiamo l'estensione per connetterci

Apriamo Visual Studio Code. Sulla barra del menu laterale clicchiamo sull'icona *extension*. Cerchiamo *remote-ssh* ed installiamolo.

- Apriamo Visual Studio Code 
- clicchiamo nella sezione delle estensioni (extensions)
- Verifichiamo che "Remote - SSH" sia installato.
  - Altrimenti lo installiamo mettendo nel campo di ricerca la voce "remote-ssh"
  - clicchiamo sull'icona
  - clicchiamo su "Install"


per approfondimenti vedi:

- [code_references/multipass_ubuntu/05_00-install-vscode-extension-remote_dev.md](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/multipass_ubuntu/05_00-install-vscode-extension-remote_dev.md)



## Colleghiamo vscode alla vm

- *View* -> *Command Palette...* -> selezioniamo *Remote-SSH: Add New SSH Host…*
    Inseriamo: `ssh -i ~/.ssh/ub22fla_key_ed25519 ubuntu@192.168.64.4`.
- Salviamo le impostazioni su `/Users/FB/.ssh/config`

```shell
Host 192.168.64.4
  HostName 192.168.64.4
  User ubuntu
  IdentityFile ~/.ssh/ub22fla_key_ed25519
```

- Nella *palette dei comandi* (F1) selezioniamo *Remote-SSH: Connect to Host…*
    Dal menu a tendina scegliamo l'host già aggiunto (*192.168.64.3*).


Personalizziamo il file di configurazione

[Codice 01 - ~/.ssh/config - linea: 1]()

```shell
Host ub22fla
  HostName 192.168.64.4
  IdentityFile ~/.ssh/ub22fla_key_ed25519
  User ubuntu
```

- Nella *palette dei comandi* (F1) selezioniamo *Remote-SSH: Connect to Host…*
    Dal menu a tendina scegliamo l'host (*ub22fla*).


per approfondimenti vedi:

- [code_references/multipass_ubuntu/05_00-install-vscode-extension-remote_dev.md](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/multipass_ubuntu/05_00-install-vscode-extension-remote_dev.md)



---
[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/00-section/01-index.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/02_00-install_ssh_server.md)
