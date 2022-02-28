# <a name="top"></a> Cap 1.1 - L'ambiente di sviluppo Ubuntu Server Multipass

Il nostro ambiente di sviluppo è su Ubuntu Server attivato con multipass e raggiunto tramite ssh con Visual Code.



## Risorse esterne

- [Dal sito di ubuntu al -> sito multipass](https://multipass.run/docs/installing-on-macos)



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

