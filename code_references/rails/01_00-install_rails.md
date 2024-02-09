# <a name="top"></a> Cap rails.1 - Installiamo Rails sulla VM

Prima di installare Rails installiamo i programmi necessari a sostenerlo.

- Ruby
- Node.js
- Yarn

> La nostra VM ha un sistema operativo Ubuntu Linux quindi le procedure che seguiremo per installare Rails sono le stesse che si farebbero su un pc con Ubuntu Linux.



## Risorse interne:

- [99-rails_references/gems/rails]
- [99-rails_references/yarn/01-yarn]



## Risorse esterne:

- [rubyonrails.org - getting_started](https://guides.rubyonrails.org/getting_started.html)
- [ruby-lang.org](https://www.ruby-lang.org/en/downloads/)
- [How to Install Ruby on Ubuntu 20.04](https://linuxize.com/post/how-to-install-ruby-on-ubuntu-20-04/)
- [apt vs apt-get](https://itsfoss.com/apt-vs-apt-get-difference/)
- [How to install Node.js](https://joshtronic.com/2021/05/09/how-to-install-nodejs-16-on-ubuntu-2004-lts/)
- [Install Node.js](https://techviewleo.com/install-node-js-and-npm-on-ubuntu/)
- [Heroku - getting-started-with-rails7](https://devcenter.heroku.com/articles/getting-started-with-rails7)



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

> Attenzione! ***NON*** usiamo `$ sudo apt install ruby-full` perché installa una vecchia versione di ruby: *ruby 2.7.0p0 (2019-12-25…)*.

Invece lo installiamo passando per **RVM** (Ruby Version Manager).

> RVM is a command-line tool that you can use to install, manage, and work with multiple Ruby environments.

```bash
$ sudo apt update
$ sudo apt install curl g++ gcc autoconf automake bison libc6-dev \
        libffi-dev libgdbm-dev libncurses5-dev libsqlite3-dev libtool \
        libyaml-dev make pkg-config sqlite3 zlib1g-dev libgmp-dev \
        libreadline-dev libssl-dev
```

Run the following commands to add the GPG keys and install RVM:

```bash
$ curl -sSL https://rvm.io/mpapis.asc | gpg --import -
$ curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
$ curl -sSL https://get.rvm.io | bash -s stable
```

Esempio:

```bash
ubuntu@ubuntufla:~$ curl -sSL https://rvm.io/mpapis.asc | gpg --import -
gpg: directory '/home/ubuntu/.gnupg' created
gpg: keybox '/home/ubuntu/.gnupg/pubring.kbx' created
gpg: key 3804BB82D39DC0E3: 47 signatures not checked due to missing keys
gpg: /home/ubuntu/.gnupg/trustdb.gpg: trustdb created
gpg: key 3804BB82D39DC0E3: public key "Michal Papis (RVM signing) <mpapis@gmail.com>" imported
gpg: Total number processed: 1
gpg:               imported: 1
gpg: no ultimately trusted keys found
ubuntu@ubuntufla:~$ curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
gpg: key 105BD0E739499BDB: public key "Piotr Kuczynski <piotr.kuczynski@gmail.com>" imported
gpg: Total number processed: 1
gpg:               imported: 1
ubuntu@ubuntufla:~$ curl -sSL https://get.rvm.io | bash -s stable
Downloading https://github.com/rvm/rvm/archive/1.29.12.tar.gz
Downloading https://github.com/rvm/rvm/releases/download/1.29.12/1.29.12.tar.gz.asc
gpg: Signature made Fri Jan 15 19:46:22 2021 CET
gpg:                using RSA key 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
gpg: Good signature from "Piotr Kuczynski <piotr.kuczynski@gmail.com>" [unknown]
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 7D2B AF1C F37B 13E2 069D  6956 105B D0E7 3949 9BDB
GPG verified '/home/ubuntu/.rvm/archives/rvm-1.29.12.tgz'
Installing RVM to /home/ubuntu/.rvm/
    Adding rvm PATH line to /home/ubuntu/.profile /home/ubuntu/.mkshrc /home/ubuntu/.bashrc /home/ubuntu/.zshrc.
    Adding rvm loading line to /home/ubuntu/.profile /home/ubuntu/.bash_profile /home/ubuntu/.zlogin.
Installation of RVM in /home/ubuntu/.rvm/ is almost complete:

  * To start using RVM you need to run `source /home/ubuntu/.rvm/scripts/rvm`
    in all your open shell windows, in rare cases you need to reopen all shell windows.
Thanks for installing RVM 🙏
Please consider donating to our open collective to help us maintain RVM.

👉  Donate: https://opencollective.com/rvm/donate


ubuntu@ubuntufla:~$ 
```

To start using RVM, load the script environment variables using the source command:

```bash
$ source ~/.rvm/scripts/rvm
```

To get a list of all Ruby versions that can be installed with this tool, type:

```bash
$ rvm list known
```

Installiamo l'ultima versione stabile di Ruby con RVM e impostiamola come versione predefinita.

> Rails requires Ruby version 2.7.0 or later. It is preferred to use latest Ruby version.

> verifichiamo [l'ultima versione di ruby](https://www.ruby-lang.org/en/downloads/) <br/>
> The current stable version is 3.3.0. 

```bash
$ rvm get stable
$ rvm install ruby-3.3.0
$ rvm use ruby-3.3.0
$ rvm list
$ rvm use ruby-3.3.0 --default
```

> Se ci sono altre versioni le possiamo cancellare con `rvm remove <version>`.

Verifichiamo che versione di ruby stiamo usando. 

```bash
$ ruby --version
```

Esempio:

```bash
ubuntu@ub22fla:~$ ruby --version
ruby 3.3.0 (2023-12-25 revision 5124f9ac75) [aarch64-linux]
```

> La precedente versione che avevo installato come `3.1.1` mi dava version `3.1.1p18`.
> L'ho citata per evidenziare che non dobbiamo indicare la patch, nel nostro caso "p18".



## Installiamo NODE JS

- [NodeSource Node.js Binary Distributions](https://github.com/nodesource/distributions)

```bash
$ curl -fsSL https://deb.nodesource.com/setup_21.x | sudo -E bash - &&\
$ sudo apt-get install -y nodejs
$ node --version
```

> Se *curl* non è installato usiamo `$ sudo apt install -y curl`

Esempio:

```bash
ubuntu@ub22fla:~$ curl -fsSL https://deb.nodesource.com/setup_21.x | sudo -E bash - &&\
> sudo apt-get install -y nodejs
2024-01-31 21:53:19 - Installing pre-requisites
Hit:1 http://ports.ubuntu.com/ubuntu-ports jammy InRelease
Hit:2 http://ports.ubuntu.com/ubuntu-ports jammy-updates InRelease
Hit:3 http://ports.ubuntu.com/ubuntu-ports jammy-backports InRelease
Hit:4 http://ports.ubuntu.com/ubuntu-ports jammy-security InRelease
Reading package lists... Done
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
ca-certificates is already the newest version (20230311ubuntu0.22.04.1).
ca-certificates set to manually installed.
curl is already the newest version (7.81.0-1ubuntu1.15).
gnupg is already the newest version (2.2.27-3ubuntu2.1).
gnupg set to manually installed.
The following NEW packages will be installed:
  apt-transport-https
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 1510 B of archives.
After this operation, 170 kB of additional disk space will be used.
Get:1 http://ports.ubuntu.com/ubuntu-ports jammy-updates/universe arm64 apt-transport-https all 2.4.11 [1510 B]
Fetched 1510 B in 0s (18.5 kB/s)        
Selecting previously unselected package apt-transport-https.
(Reading database ... 72376 files and directories currently installed.)
Preparing to unpack .../apt-transport-https_2.4.11_all.deb ...
Unpacking apt-transport-https (2.4.11) ...
Setting up apt-transport-https (2.4.11) ...
Scanning processes...                                                                                                                                                                                                                                
Scanning linux images...                                                                                                                                                                                                                             

Running kernel seems to be up-to-date.

No services need to be restarted.

No containers need to be restarted.

No user sessions are running outdated binaries.

No VM guests are running outdated hypervisor (qemu) binaries on this host.
gpg: WARNING: unsafe ownership on homedir '/home/ubuntu/.gnupg'
Hit:1 http://ports.ubuntu.com/ubuntu-ports jammy InRelease
Hit:2 http://ports.ubuntu.com/ubuntu-ports jammy-updates InRelease
Hit:3 http://ports.ubuntu.com/ubuntu-ports jammy-backports InRelease
Get:4 https://deb.nodesource.com/node_21.x nodistro InRelease [12.1 kB]
Hit:5 http://ports.ubuntu.com/ubuntu-ports jammy-security InRelease
Get:6 https://deb.nodesource.com/node_21.x nodistro/main arm64 Packages [2494 B]
Fetched 14.6 kB in 0s (30.1 kB/s)
Reading package lists... Done
2024-01-31 21:53:22 - Repository configured successfully. To install Node.js, run: apt-get install nodejs -y
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following NEW packages will be installed:
  nodejs
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 31.2 MB of archives.
After this operation, 200 MB of additional disk space will be used.
Get:1 https://deb.nodesource.com/node_21.x nodistro/main arm64 nodejs arm64 21.6.1-1nodesource1 [31.2 MB]
Fetched 31.2 MB in 1s (38.2 MB/s)
Selecting previously unselected package nodejs.
(Reading database ... 72380 files and directories currently installed.)
Preparing to unpack .../nodejs_21.6.1-1nodesource1_arm64.deb ...
Unpacking nodejs (21.6.1-1nodesource1) ...
Setting up nodejs (21.6.1-1nodesource1) ...
Processing triggers for man-db (2.10.2-1) ...
Scanning processes...                                                                                                                                                                                                                                
Scanning linux images...                                                                                                                                                                                                                             

Running kernel seems to be up-to-date.

No services need to be restarted.

No containers need to be restarted.

No user sessions are running outdated binaries.

No VM guests are running outdated hypervisor (qemu) binaries on this host.

ubuntu@ub22fla:~$ node --version
v21.6.1
```



## Installiamo YARN

YARN lo installiamo sfruttando *npm* messo a disposizione da *node.js*.

> *npm* è il gestore di pacchetti (*package manager*) per la piattaforma Node JavaScript. 
> It puts modules in place so that node can find them, and manages dependency conflicts intelligently. 

> Once you have npm installed you can run the following both to **install** and **upgrade** Yarn:

```bash
$ sudo npm install --global yarn
$ yarn --version
```

> Lo script di installazione ci ha chiesto di eseguire anche `$ sudo npm install -g npm@10.4.0`

Esempio:

```bash
ubuntu@ub22fla:~$ sudo npm install --global yarn

added 1 package in 698ms
npm notice 
npm notice New minor version of npm available! 10.2.4 -> 10.4.0
npm notice Changelog: https://github.com/npm/cli/releases/tag/v10.4.0
npm notice Run npm install -g npm@10.4.0 to update!
npm notice 

ubuntu@ub22fla:~$ sudo npm install -g npm@10.4.0

removed 25 packages, and changed 45 packages in 1s

24 packages are looking for funding
  run `npm fund` for details

ubuntu@ub22fla:~$ yarn --version
1.22.21
```



## Installiamo Rails

Per installare Rails carichiamo la corrispondente gemma ruby.
To install Rails, use the gem install command provided by RubyGems.

I> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/rails)
I>
I> facciamo riferimento al [tutorial della gemma](https://rubyonrails.org/)

> Poiché pubblicheremo in produzione la nostra applicazione su **render** verifichiamo la versione Rails supportata su
> [Deploying Ruby on Rails on Render](https://docs.render.com/deploy-rails)

> Se l'avessimo pubblicata in produzione su Heroku avremmo verificato la versione Rails supportata su
> [Heroku devcenter - Getting Started on Heroku with Rails 7.x](https://devcenter.heroku.com/articles/getting-started-with-rails7)

```bash
$ cd ~
$ gem install rails
```

> Volendo istallare una versione specifica possiamo indicarla. 
> Ad esempio: *$ gem install rails -v 7.1.3*

Per verificare quale versione di rails abbiamo installato

```bash
$ rails --version
```

Esempio:

```shell
ubuntu@ub22fla:~$ gem install rails
Fetching thor-1.3.0.gem
Fetching webrick-1.8.1.gem
Fetching rack-3.0.9.gem
Fetching rackup-2.1.0.gem
Fetching concurrent-ruby-1.2.3.gem
Fetching tzinfo-2.0.6.gem
Fetching minitest-5.21.2.gem
Fetching zeitwerk-2.6.12.gem
Fetching i18n-1.14.1.gem
Fetching connection_pool-2.4.1.gem
Fetching activesupport-7.1.3.gem
Fetching nokogiri-1.16.0-aarch64-linux.gem
Fetching crass-1.0.6.gem
Fetching loofah-2.22.0.gem
Fetching rails-html-sanitizer-1.6.0.gem
Fetching rails-dom-testing-2.2.0.gem
Fetching rack-test-2.1.0.gem
Fetching rack-session-2.0.0.gem
Fetching erubi-1.12.0.gem
Fetching builder-3.2.4.gem
Fetching actionview-7.1.3.gem
Fetching actionpack-7.1.3.gem
Fetching railties-7.1.3.gem
Fetching marcel-1.0.2.gem
Fetching activemodel-7.1.3.gem
Fetching activerecord-7.1.3.gem
Fetching globalid-1.2.1.gem
Fetching activejob-7.1.3.gem
Fetching activestorage-7.1.3.gem
Fetching actiontext-7.1.3.gem
Fetching mini_mime-1.1.5.gem
Fetching mail-2.8.1.gem
Fetching rails-7.1.3.gem
Fetching actionmailer-7.1.3.gem
Fetching actionmailbox-7.1.3.gem
Fetching websocket-extensions-0.1.5.gem
Fetching websocket-driver-0.7.6.gem
Fetching nio4r-2.7.0.gem
Fetching actioncable-7.1.3.gem
Successfully installed zeitwerk-2.6.12
Successfully installed thor-1.3.0
Successfully installed webrick-1.8.1
Successfully installed rack-3.0.9
Successfully installed rackup-2.1.0
Successfully installed concurrent-ruby-1.2.3
Successfully installed tzinfo-2.0.6
Successfully installed minitest-5.21.2
Successfully installed i18n-1.14.1
Successfully installed connection_pool-2.4.1
Successfully installed activesupport-7.1.3
Successfully installed nokogiri-1.16.0-aarch64-linux
Successfully installed crass-1.0.6
Successfully installed loofah-2.22.0
Successfully installed rails-html-sanitizer-1.6.0
Successfully installed rails-dom-testing-2.2.0
Successfully installed rack-test-2.1.0
Successfully installed rack-session-2.0.0
Successfully installed erubi-1.12.0
Successfully installed builder-3.2.4
Successfully installed actionview-7.1.3
Successfully installed actionpack-7.1.3
Successfully installed railties-7.1.3
Successfully installed marcel-1.0.2
Successfully installed activemodel-7.1.3
Successfully installed activerecord-7.1.3
Successfully installed globalid-1.2.1
Successfully installed activejob-7.1.3
Successfully installed activestorage-7.1.3
Successfully installed actiontext-7.1.3
Successfully installed mini_mime-1.1.5
Successfully installed mail-2.8.1
Successfully installed actionmailer-7.1.3
Successfully installed actionmailbox-7.1.3
Successfully installed websocket-extensions-0.1.5
Building native extensions. This could take a while...
Successfully installed websocket-driver-0.7.6
Building native extensions. This could take a while...
Successfully installed nio4r-2.7.0
Successfully installed actioncable-7.1.3
Successfully installed rails-7.1.3
Parsing documentation for zeitwerk-2.6.12
Installing ri documentation for zeitwerk-2.6.12
Parsing documentation for thor-1.3.0
Installing ri documentation for thor-1.3.0
Parsing documentation for webrick-1.8.1
Installing ri documentation for webrick-1.8.1
Parsing documentation for rack-3.0.9
Installing ri documentation for rack-3.0.9
Parsing documentation for rackup-2.1.0
Installing ri documentation for rackup-2.1.0
Parsing documentation for concurrent-ruby-1.2.3
Installing ri documentation for concurrent-ruby-1.2.3
Parsing documentation for tzinfo-2.0.6
Installing ri documentation for tzinfo-2.0.6
Parsing documentation for minitest-5.21.2
Couldn't find file to include 'README.rdoc' from lib/minitest.rb
Installing ri documentation for minitest-5.21.2
Parsing documentation for i18n-1.14.1
Installing ri documentation for i18n-1.14.1
Parsing documentation for connection_pool-2.4.1
Installing ri documentation for connection_pool-2.4.1
Parsing documentation for activesupport-7.1.3
Couldn't find file to include 'activesupport/README.rdoc' from lib/active_support.rb
Installing ri documentation for activesupport-7.1.3
Parsing documentation for nokogiri-1.16.0-aarch64-linux
Installing ri documentation for nokogiri-1.16.0-aarch64-linux
Parsing documentation for crass-1.0.6
Installing ri documentation for crass-1.0.6
Parsing documentation for loofah-2.22.0
Installing ri documentation for loofah-2.22.0
Parsing documentation for rails-html-sanitizer-1.6.0
Installing ri documentation for rails-html-sanitizer-1.6.0
Parsing documentation for rails-dom-testing-2.2.0
Installing ri documentation for rails-dom-testing-2.2.0
Parsing documentation for rack-test-2.1.0
Installing ri documentation for rack-test-2.1.0
Parsing documentation for rack-session-2.0.0
Installing ri documentation for rack-session-2.0.0
Parsing documentation for erubi-1.12.0
Installing ri documentation for erubi-1.12.0
Parsing documentation for builder-3.2.4
Installing ri documentation for builder-3.2.4
Parsing documentation for actionview-7.1.3
Couldn't find file to include 'actionview/README.rdoc' from lib/action_view.rb
Installing ri documentation for actionview-7.1.3
Parsing documentation for actionpack-7.1.3
Installing ri documentation for actionpack-7.1.3
Parsing documentation for railties-7.1.3
Installing ri documentation for railties-7.1.3
Parsing documentation for marcel-1.0.2
Installing ri documentation for marcel-1.0.2
Parsing documentation for activemodel-7.1.3
Couldn't find file to include 'activemodel/README.rdoc' from lib/active_model.rb
Installing ri documentation for activemodel-7.1.3
Parsing documentation for activerecord-7.1.3
Couldn't find file to include 'activerecord/README.rdoc' from lib/active_record.rb
Installing ri documentation for activerecord-7.1.3
Parsing documentation for globalid-1.2.1
Installing ri documentation for globalid-1.2.1
Parsing documentation for activejob-7.1.3
Couldn't find file to include 'activejob/README.md' from lib/active_job.rb
Installing ri documentation for activejob-7.1.3
Parsing documentation for activestorage-7.1.3
Couldn't find file to include 'activestorage/README.md' from lib/active_storage.rb
Installing ri documentation for activestorage-7.1.3
Parsing documentation for actiontext-7.1.3
Couldn't find file to include 'actiontext/README.md' from lib/action_text.rb
Installing ri documentation for actiontext-7.1.3
Parsing documentation for mini_mime-1.1.5
Installing ri documentation for mini_mime-1.1.5
Parsing documentation for mail-2.8.1
Installing ri documentation for mail-2.8.1
Parsing documentation for actionmailer-7.1.3
Couldn't find file to include 'actionmailer/README.rdoc' from lib/action_mailer.rb
Installing ri documentation for actionmailer-7.1.3
Parsing documentation for actionmailbox-7.1.3
Couldn't find file to include 'actionmailbox/README.md' from lib/action_mailbox.rb
Installing ri documentation for actionmailbox-7.1.3
Parsing documentation for websocket-extensions-0.1.5
Installing ri documentation for websocket-extensions-0.1.5
Parsing documentation for websocket-driver-0.7.6
Installing ri documentation for websocket-driver-0.7.6
Parsing documentation for nio4r-2.7.0
Installing ri documentation for nio4r-2.7.0
Parsing documentation for actioncable-7.1.3
Couldnt find file to include 'actioncable/README.md' from lib/action_cable.rb
Installing ri documentation for actioncable-7.1.3
Parsing documentation for rails-7.1.3
Installing ri documentation for rails-7.1.3
Done installing documentation for zeitwerk, thor, webrick, rack, rackup, concurrent-ruby, tzinfo, minitest, i18n, connection_pool, activesupport, nokogiri, crass, loofah, rails-html-sanitizer, rails-dom-testing, rack-test, rack-session, erubi, builder, actionview, actionpack, railties, marcel, activemodel, activerecord, globalid, activejob, activestorage, actiontext, mini_mime, mail, actionmailer, actionmailbox, websocket-extensions, websocket-driver, nio4r, actioncable, rails after 14 seconds
39 gems installed

ubuntu@ub22fla:~$ rails --version
Rails 7.1.3
```

L'ambiente Ruby on Rails è pronto ma prima di creare la nostra applicazione installiamo il database PostgreSQL. Questo lo facciamo nel prossimo capitolo.


---
[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/03_00-implement_ide.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/05_00-install_postgresql.md)
