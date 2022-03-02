# <a name="top"></a> Cap 1.2 - Installiamo server SSH sulla VM



## Risorse esterne

- [How to Enable SSH on Ubuntu](https://linuxize.com/post/how-to-enable-ssh-on-ubuntu-18-04/)
- [How To Install and Enable SSH Server](https://devconnected.com/how-to-install-and-enable-ssh-server-on-ubuntu-20-04/)
- [How to fix SSH Permission denied](https://phoenixnap.com/kb/ssh-permission-denied-publickey#:~:text=the%20solutions%20below.-,Solution%201%3A%20Enable%20Password%20Authentication,login%20in%20the%20sshd_config%20file.&text=In%20the%20file%2C%20find%20the,sure%20it%20ends%20with%20yes%20.)
- [multipass and SSH to the VM From LAN](https://medium.com/codex/use-linux-virtual-machines-with-multipass-4e2b620cc6)


## Attiviamo ssh sulla VM

La nostra IDE la collegheremo alla nostra VM Ubuntu Linux tramite *secure shell* (ssh). Quindi attiviamo un server *ssh* nella nostra VM. La nostra schelta è *openssh-server*.

Per impostazione predefinita, SSH è già installato sulla nostra VM, anche con una configurazione base.
Per verificare che sia effettivamente così, eseguiamo il comando `ssh` con l'opzione **-V**.

```bash
ssh -V
```

Esempio:

```bash
ubuntu@ubuntufla:~$ ssh -V
OpenSSH_8.2p1 Ubuntu-4ubuntu0.4, OpenSSL 1.1.1f  31 Mar 2020
```

> Fai attenzione: queste informazioni non significano che hai un server SSH in esecuzione sul tuo server, significa solo che sei attualmente in grado di connetterti come client ai server SSH.


Se non fosse presente lo possiamo installare con:

```bash
$ sudo apt update
$ sudo apt install openssh-server
```



## Verifichiamo il collegamento SSH

Da terminale macOS colleghiamoci alla VM tramite Secure SHell.

```bash
$ ssh -p 22 ubuntu@192.168.64.3
```

Esempio

```bash
MacBook-Pro-di-Flavio:~ FB$ ssh -p 22 ubuntu@192.168.64.3
The authenticity of host '192.168.64.3 (192.168.64.3)' can't be established.
ECDSA key fingerprint is SHA256:ljgoOPxZ8AegawthfNOzHWreBbG2TccG3RT8qoe9dEw.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.64.3' (ECDSA) to the list of known hosts.
ubuntu@192.168.64.3: Permission denied (publickey).
MacBook-Pro-di-Flavio:~ FB$ 
```


## Risolviamo il "Permission denied"

If you want to use a password to access the SSH server, a solution for fixing the Permission denied error is to enable password login in the sshd_config file.

To do this, open the file in a text editor.  This example uses the nano editor:

```bash
$ multipass shell ubuntufla

$ sudo nano /etc/ssh/sshd_config
```

In the file, find the PasswordAuthentication line and make sure it ends with **yes**.

Find the ChallengeResponseAuthentication option and disable it by adding **no**.

If lines are commented out, remove the hash sign # to uncomment them.

```bash
# To disable tunneled clear text passwords, change to no here!
PasswordAuthentication yes
#PermitEmptyPasswords no

# Change to yes to enable challenge-response passwords (beware issues with
# some PAM modules and threads)
ChallengeResponseAuthentication no
```
Save the file and exit.

Restart the SSH service by typing the following command:

```bash
$ sudo systemctl restart sshd
```



## Verifichiamo

Usciamo dal terminale ubuntu della VM e dal terminale di macOS lanciamo il comando `ssh` per collegarci tramite secure shell. 

```bash
ubuntu@ubuntufla:~$ exit
logout
MacBook-Pro-di-Flavio:~ FB$ ssh -p 22 ubuntu@192.168.64.3
ubuntu@192.168.64.3's password: 
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-99-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Wed Mar  2 18:28:12 CET 2022

  System load:  1.19              Processes:               115
  Usage of /:   6.9% of 19.21GB   Users logged in:         0
  Memory usage: 4%                IPv4 address for enp0s2: 192.168.64.3
  Swap usage:   0%


1 update can be applied immediately.
To see these additional updates run: apt list --upgradable


The list of available updates is more than a week old.
To check for new updates run: sudo apt update

Last login: Wed Mar  2 18:23:30 2022 from 192.168.64.1
ubuntu@ubuntufla:~$ 
```

Adesso funziona! ^_^



---
[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/01_00-ubuntu_multipass.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/03_00-implement_ide.md)
