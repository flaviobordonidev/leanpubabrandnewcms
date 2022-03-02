# <a name="top"></a> Cap 1.2 - Implementiamo la IDE



## Installiamo ssh server sulla VM


## Attiviamo ssh sulla VM

La nostra IDE la colleghiamo alla nostra VM Ubuntu Linux tramite *secure shell* (ssh). Quindi attiviamo un server *ssh* nella nostra VM. La nostra schelta è *openssh-server*.

```bash
$ sudo apt update
$ sudo apt install openssh-server
```

By default, SSH should already be installed on your host, even for minimal configurations.

To check that this is actually the case, you can run the “ssh” command with the “-V” option.

ssh -V

getting ssh version on linux
As you can see, I am currently running OpenSSH 8.2 on Ubuntu with the OpenSSL 1.1.1 version (dated from the 31th of March 2020).

> Be careful : this information does not mean that you have a SSH server running on your server, it only means that you are currently able to connect as a client to SSH servers.


## Verifichiamo il collegamento da secure shell

Da terminale macOS colleghiamoci alla VM.

```bash
$ ssh -p 22 ubuntu@192.168.64.4
```
