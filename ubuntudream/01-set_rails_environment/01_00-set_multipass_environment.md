# <a name="top"></a> Cap 1.1 - Impostiamo l'ambiente di sviluppo su Ubuntu Server Multipass

Creiamo la nostra app Ubuntudream usando Ubuntu Server su multipass come nostro ambiente di sviluppo.
Preparaziamo l'ambiente multipass.



## Risorse interne
- [code_references/multipass_ubuntu/01_00-ubuntu_multipass.md](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/multipass_ubuntu/01_00-ubuntu_multipass.md)
- [code_references/multipass_ubuntu/03_00-connect_via_ssh]()
- [code_references/visual_studio_code/01_00-install_vscode]()
- [code_references/multipass_ubuntu/05_00-connect_vscode]()
- [code_references/rails/01_00-install_rails]()
- [code_references/postgresql/01_00-install_rails]()
- [code_references/postgresql/12_00-authorize_postgresql_for_rails]()
- [code_references/multipass_ubuntu/05_00-install-vscode-extension-remote_dev]()



## Installiamo multipass

Scarichiamo il file ".pkg" dal sito https://multipass.run/

per approfondimenti vedi:

- [code_references/multipass_ubuntu/01_00-ubuntu_multipass.md](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/multipass_ubuntu/01_00-ubuntu_multipass.md)



## Creiamo la VM con le chiavi di crittatura

Creiamo la coppia di chiavi di crittatura.

```shell
$ cd ~/.ssh
$ ssh-keygen -t ed25519 -f ub22fla_key_ed25519 -C "ubuntu"
# la "passphrase" la lascio vuota per evitare di metterla ogni volta che mi collego con vscode
```

Creiamo il file `cloud-init.yaml`.

```shell
❯ touch cloud-init.yaml
❯ nano cloud-init.yaml
```

[Codice 01 - ~/.ssh/cloud-init.yaml - linea: 1]()

```yml
users:
  - default
  - name: ubuntu
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
    - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPnvMUqdYqfJ7/4blAmDs2iD5j7PjwaJyblFXpfjUka8 ubuntu
```

Creiamo la macchina virtuale con già le chiavi di crittatura per ssh.

```shell
❯ multipass find
❯ multipass launch 22.04 --name ub22fla --cpus 1 --memory 4G --disk 20G  --cloud-init cloud-init.yaml
```

per approfondimenti vedi:

- [code_references/multipass_ubuntu/04_00-launch_vm_with_ssh_keys.md](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/multipass_ubuntu/04_00-launch_vm_with_ssh_keys.md)



## Entriamo nella VM via SSH

Entriamo nella VM usando ssh.

```shell
❯ ssh -i ~/.ssh/ub22fla_key_ed25519 ubuntu@192.168.64.4
```

> otteniamo lo stesso risultato di `multipass shell ub22fla`.

per approfondimenti vedi:

- [code_references/multipass_ubuntu/04_00-launch_vm_with_ssh_keys.md](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/multipass_ubuntu/04_00-launch_vm_with_ssh_keys.md)
- [code_references/multipass_ubuntu/03_00-connect_via_ssh.md](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/multipass_ubuntu/03_00-connect_via_ssh.md)






Implementiamo la IDE
In questo capitolo Implementiamo la parte grafica per lo sviluppo e Colleghiamo VS Code alla VM tramite SSH.

3. [code_references/visual_studio_code/01_00-install_vscode]()
4. [code_references/multipass_ubuntu/05_00-connect_vscode]()

Installiamo Rails sulla VM

5. [code_references/rails/01_00-install_rails]()

Installiamo PostgreSQL
Di default Rails ha attivo il database sqlite3 ma noi sin da subito nella nostra nuova applicazione useremo PostgreSQL, quindi è bene installarlo.

6. [code_references/postgresql/01_00-install_rails]()
7. [code_references/postgresql/12_00-authorize_postgresql_for_rails]()

VS Code extensions
In questo capitolo installiamo le *estensioni* di Visual Studio Code per lavorare meglio con Ruby on Rails.

8. [code_references/multipass_ubuntu/05_00-install-vscode-extension-remote_dev]()



---
[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/00-section/01-index.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/02_00-install_ssh_server.md)
