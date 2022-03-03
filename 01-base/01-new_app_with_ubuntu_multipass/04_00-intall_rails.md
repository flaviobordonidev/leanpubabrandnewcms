# <a name="top"></a> Cap 1.4 - Installiamo Rails sulla VM

Per installare Rails installiamo prima i programmi necessari a sostenerlo.

> La nostra VM ha un sistema operativo Ubuntu Linux quindi le procedure che seguiremo per installare Rails sono le stesse che si farebbero su un pc con Ubuntu Linux.



## Risorse eseterne

- https://linuxize.com/post/how-to-install-ruby-on-ubuntu-20-04/
- [apt vs apt-get](https://itsfoss.com/apt-vs-apt-get-difference/)


## Aggiorniamo il sistema

Prima di procedere con le varie installazioni aggiorniamo il sistema operativo

```bash
$ sudo apt update
$ sudo apt upgrade
$ sudo shutdown -r 0
```

> Se `sudo apt upgrade` non riesce a completare l'installazione di tutti i pacchetti si può provare con `sudo apt full-upgrade`.

> A volte si vede l'uso del comando *apt-get* ma è preferibile usare `apt` perché è un comando più nuovo e sviluppato per semplificare la gestione di *apt-get* e *apt-cache*.
> In pratica `apt` abbiamo i comandi comunemente più usati con *apt-get* e *apt-cache* organizzati in un modo migliore con alche alcune utili opzioni già impostate di default. <br/>
> Attenzione! Non sempre esiste un comando *apt* con lo stesso nome del comando *apt-get*. <br/>
> Ad esempio `apt full-upgrade` su apt-get è `apt-get dist-upgrade`.

Esempio:

```bash
ubuntu@ubuntufla:~$ sudo apt update
Hit:1 http://archive.ubuntu.com/ubuntu focal InRelease
Get:2 http://archive.ubuntu.com/ubuntu focal-updates InRelease [114 kB]
Get:3 http://security.ubuntu.com/ubuntu focal-security InRelease [114 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal-backports InRelease [108 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal-updates/main Translation-en [308 kB]
Fetched 644 kB in 1s (824 kB/s)                                         
Reading package lists... Done
Building dependency tree       
Reading state information... Done
13 packages can be upgraded. Run 'apt list --upgradable' to see them.
ubuntu@ubuntufla:~$
ubuntu@ubuntufla:~$ sudo apt upgrade
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Calculating upgrade... Done
The following packages will be upgraded:
  base-files initramfs-tools initramfs-tools-bin initramfs-tools-core libdrm-common libdrm2 motd-news-config open-vm-tools python-apt-common
  python3-apt python3-distupgrade ubuntu-advantage-tools ubuntu-release-upgrader-core
13 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
Need to get 1981 kB of archives.
After this operation, 955 kB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 motd-news-config all 11ubuntu5.5 [4472 B]
Get:2 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 base-files amd64 11ubuntu5.5 [60.5 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libdrm-common all 2.4.107-8ubuntu1~20.04.1 [5408 B]
Get:4 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libdrm2 amd64 2.4.107-8ubuntu1~20.04.1 [34.1 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal-updates/universe amd64 open-vm-tools amd64 2:11.3.0-2ubuntu0~ubuntu20.04.2 [647 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 python-apt-common all 2.0.0ubuntu0.20.04.7 [17.1 kB]
Get:7 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 python3-apt amd64 2.0.0ubuntu0.20.04.7 [154 kB]
Get:8 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 ubuntu-advantage-tools amd64 27.6~20.04.1 [862 kB]
Get:9 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 ubuntu-release-upgrader-core all 1:20.04.37 [24.0 kB]
Get:10 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 python3-distupgrade all 1:20.04.37 [104 kB]
Get:11 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 initramfs-tools all 0.136ubuntu6.7 [9248 B]
Get:12 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 initramfs-tools-core all 0.136ubuntu6.7 [47.8 kB]
Get:13 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 initramfs-tools-bin amd64 0.136ubuntu6.7 [10.8 kB]
Fetched 1981 kB in 0s (4823 kB/s)          
Preconfiguring packages ...
(Reading database ... 94634 files and directories currently installed.)
Preparing to unpack .../motd-news-config_11ubuntu5.5_all.deb ...
Unpacking motd-news-config (11ubuntu5.5) over (11ubuntu5.4) ...
Preparing to unpack .../base-files_11ubuntu5.5_amd64.deb ...
Warning: Stopping motd-news.service, but it can still be activated by:
  motd-news.timer
Unpacking base-files (11ubuntu5.5) over (11ubuntu5.4) ...
Setting up base-files (11ubuntu5.5) ...
Installing new version of config file /etc/issue ...
Installing new version of config file /etc/issue.net ...
Installing new version of config file /etc/lsb-release ...
motd-news.service is a disabled or a static unit, not starting it.
(Reading database ... 94634 files and directories currently installed.)
Preparing to unpack .../00-libdrm-common_2.4.107-8ubuntu1~20.04.1_all.deb ...
Unpacking libdrm-common (2.4.107-8ubuntu1~20.04.1) over (2.4.105-3~20.04.2) ...
Preparing to unpack .../01-libdrm2_2.4.107-8ubuntu1~20.04.1_amd64.deb ...
Unpacking libdrm2:amd64 (2.4.107-8ubuntu1~20.04.1) over (2.4.105-3~20.04.2) ...
Preparing to unpack .../02-open-vm-tools_2%3a11.3.0-2ubuntu0~ubuntu20.04.2_amd64.deb ...
Unpacking open-vm-tools (2:11.3.0-2ubuntu0~ubuntu20.04.2) over (2:11.0.5-4) ...
Preparing to unpack .../03-python-apt-common_2.0.0ubuntu0.20.04.7_all.deb ...
Unpacking python-apt-common (2.0.0ubuntu0.20.04.7) over (2.0.0ubuntu0.20.04.6) ...
Preparing to unpack .../04-python3-apt_2.0.0ubuntu0.20.04.7_amd64.deb ...
Unpacking python3-apt (2.0.0ubuntu0.20.04.7) over (2.0.0ubuntu0.20.04.6) ...
Preparing to unpack .../05-ubuntu-advantage-tools_27.6~20.04.1_amd64.deb ...
Unpacking ubuntu-advantage-tools (27.6~20.04.1) over (27.5~20.04.1) ...
Preparing to unpack .../06-ubuntu-release-upgrader-core_1%3a20.04.37_all.deb ...
Unpacking ubuntu-release-upgrader-core (1:20.04.37) over (1:20.04.36) ...
Preparing to unpack .../07-python3-distupgrade_1%3a20.04.37_all.deb ...
Unpacking python3-distupgrade (1:20.04.37) over (1:20.04.36) ...
Preparing to unpack .../08-initramfs-tools_0.136ubuntu6.7_all.deb ...
Unpacking initramfs-tools (0.136ubuntu6.7) over (0.136ubuntu6.6) ...
Preparing to unpack .../09-initramfs-tools-core_0.136ubuntu6.7_all.deb ...
Unpacking initramfs-tools-core (0.136ubuntu6.7) over (0.136ubuntu6.6) ...
Preparing to unpack .../10-initramfs-tools-bin_0.136ubuntu6.7_amd64.deb ...
Unpacking initramfs-tools-bin (0.136ubuntu6.7) over (0.136ubuntu6.6) ...
Setting up motd-news-config (11ubuntu5.5) ...
Setting up python-apt-common (2.0.0ubuntu0.20.04.7) ...
Setting up libdrm-common (2.4.107-8ubuntu1~20.04.1) ...
Setting up initramfs-tools-bin (0.136ubuntu6.7) ...
Setting up python3-apt (2.0.0ubuntu0.20.04.7) ...
Setting up python3-distupgrade (1:20.04.37) ...
Setting up ubuntu-release-upgrader-core (1:20.04.37) ...
Setting up libdrm2:amd64 (2.4.107-8ubuntu1~20.04.1) ...
Setting up open-vm-tools (2:11.3.0-2ubuntu0~ubuntu20.04.2) ...
Installing new version of config file /etc/vmware-tools/tools.conf.example ...
Installing new version of config file /etc/vmware-tools/vgauth.conf ...
Removing obsolete conffile /etc/vmware-tools/vm-support ...
Setting up ubuntu-advantage-tools (27.6~20.04.1) ...
Setting up initramfs-tools-core (0.136ubuntu6.7) ...
Setting up initramfs-tools (0.136ubuntu6.7) ...
update-initramfs: deferring update (trigger activated)
Processing triggers for systemd (245.4-4ubuntu3.15) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for plymouth-theme-ubuntu-text (0.9.4git20200323-0ubuntu6.2) ...
update-initramfs: deferring update (trigger activated)
Processing triggers for install-info (6.7.0.dfsg.2-5) ...
Processing triggers for libc-bin (2.31-0ubuntu9.7) ...
Processing triggers for initramfs-tools (0.136ubuntu6.7) ...
update-initramfs: Generating /boot/initrd.img-5.4.0-100-generic
ubuntu@ubuntufla:~$ 
ubuntu@ubuntufla:~$ sudo shutdown -r 0
Shutdown scheduled for Thu 2022-03-03 14:25:10 CET, use 'shutdown -c' to cancel.
ubuntu@ubuntufla:~$ Connection to 192.168.64.3 closed by remote host.
Connection to 192.168.64.3 closed.
MacBook-Pro-di-Flavio:~ FB$ multipass list
Name                    State             IPv4             Image
flub                    Stopped           --               Ubuntu 20.04 LTS
ubuntufla               Starting          --               Ubuntu 20.04 LTS
MacBook-Pro-di-Flavio:~ FB$ multipass shell ubuntufla
Starting ubuntufla  Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.4.0-99-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Thu Mar  3 14:26:32 CET 2022

  System load:  0.31               Processes:               127
  Usage of /:   10.8% of 19.21GB   Users logged in:         0
  Memory usage: 4%                 IPv4 address for enp0s2: 192.168.64.3
  Swap usage:   0%

 * Super-optimized for small spaces - read how we shrank the memory
   footprint of MicroK8s to make it the smallest full K8s around.

   https://ubuntu.com/blog/microk8s-memory-optimisation

0 updates can be applied immediately.


Last login: Thu Mar  3 13:04:00 2022 from 192.168.64.1
ubuntu@ubuntufla:~$ 
```



## Installiamo RUBY

https://linuxize.com/post/how-to-install-ruby-on-ubuntu-20-04/

NON USIAMO ($ sudo apt install ruby-full) perché installa una vecchia versione di ruby del 2019 ( ruby 2.7.0p0 (2019-12-25…)).

Installing Ruby using RVM

$ sudo apt update
$ sudo apt install curl g++ gcc autoconf automake bison libc6-dev \
        libffi-dev libgdbm-dev libncurses5-dev libsqlite3-dev libtool \
        libyaml-dev make pkg-config sqlite3 zlib1g-dev libgmp-dev \
        libreadline-dev libssl-dev
$ curl -sSL https://rvm.io/mpapis.asc | gpg --import -
$ curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
$ curl -sSL https://get.rvm.io | bash -s stable
$ source ~/.rvm/scripts/rvm


$ rvm get stable
$ rvm install ruby-3.1.0
$ rvm use ruby-3.1.0
$ ruby —version


Installiamo NODE JS

https://joshtronic.com/2021/05/09/how-to-install-nodejs-16-on-ubuntu-2004-lts/

$ sudo apt update
$ sudo apt upgrade

Se “curl” non è installato usare $ sudo apt install -y curl

$ curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
$ sudo apt install -y nodejs
$ node --version


Installiamo YARN

$ sudo npm install --global yarn
$ sudo npm install -g npm@8.3.2




$ rails s -b 192.168.64.4

Di default va sulla porta 3000 se vogliamo spostarlo sulla porta 8080 facciamo:

$ rails s -b 192.168.64.4 -p  8080

(possiamo usare solo porte libere. se proviamo sulla porta 80 riceviamo un errore.)





