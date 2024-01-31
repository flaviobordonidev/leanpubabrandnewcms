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
> The current stable version is 3.1.1. 

```bash
$ rvm get stable
$ rvm install ruby-3.1.1
$ rvm use ruby-3.1.1
$ rvm list
$ rvm use ruby-3.1.1 --default
```

> Se ci sono altre versioni le possiamo cancellare con `rvm remove <version>`.

Verifichiamo che versione di ruby stiamo usando. 

```bash
$ ruby --version
```

Esempio:

```bash
ubuntu@ubuntufla:~$ ruby --version
ruby 3.1.1p18 (2022-02-18 revision 53f5fc4236) [x86_64-linux]
ubuntu@ubuntufla:~$ 
```



## Installiamo NODE JS

```bash
$ curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
$ sudo apt install -y nodejs
$ node --version
```

> Se *curl* non è installato usiamo `$ sudo apt install -y curl`

Esempio:

```bash
ubuntu@ubuntufla:~$ curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -

## Installing the NodeSource Node.js 16.x repo...


## Populating apt-get cache...

+ apt-get update
Hit:1 http://archive.ubuntu.com/ubuntu focal InRelease
Get:2 http://archive.ubuntu.com/ubuntu focal-updates InRelease [114 kB]
Get:3 http://security.ubuntu.com/ubuntu focal-security InRelease [114 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal-backports InRelease [108 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 Packages [1608 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal-updates/universe amd64 Packages [906 kB]
Get:7 http://security.ubuntu.com/ubuntu focal-security/main amd64 Packages [1275 kB]
Get:8 http://security.ubuntu.com/ubuntu focal-security/main amd64 c-n-f Metadata [9736 B]
Get:9 http://security.ubuntu.com/ubuntu focal-security/universe amd64 Packages [680 kB]
Fetched 4815 kB in 2s (2565 kB/s)                        
Reading package lists... Done

## Confirming "focal" is supported...

+ curl -sLf -o /dev/null 'https://deb.nodesource.com/node_16.x/dists/focal/Release'

## Adding the NodeSource signing key to your keyring...

+ curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor | tee /usr/share/keyrings/nodesource.gpg >/dev/null
gpg: WARNING: unsafe ownership on homedir '/home/ubuntu/.gnupg'

## Creating apt sources list file for the NodeSource Node.js 16.x repo...

+ echo 'deb [signed-by=/usr/share/keyrings/nodesource.gpg] https://deb.nodesource.com/node_16.x focal main' > /etc/apt/sources.list.d/nodesource.list
+ echo 'deb-src [signed-by=/usr/share/keyrings/nodesource.gpg] https://deb.nodesource.com/node_16.x focal main' >> /etc/apt/sources.list.d/nodesource.list

## Running `apt-get update` for you...

+ apt-get update
Hit:1 http://security.ubuntu.com/ubuntu focal-security InRelease
Hit:2 http://archive.ubuntu.com/ubuntu focal InRelease                    
Get:3 https://deb.nodesource.com/node_16.x focal InRelease [4583 B]       
Hit:4 http://archive.ubuntu.com/ubuntu focal-updates InRelease
Hit:5 http://archive.ubuntu.com/ubuntu focal-backports InRelease
Get:6 https://deb.nodesource.com/node_16.x focal/main amd64 Packages [775 B]
Fetched 5358 B in 1s (8635 B/s)
Reading package lists... Done

## Run `sudo apt-get install -y nodejs` to install Node.js 16.x and npm
## You may also need development tools to build native addons:
     sudo apt-get install gcc g++ make
## To install the Yarn package manager, run:
     curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
     echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
     sudo apt-get update && sudo apt-get install yarn


ubuntu@ubuntufla:~$ sudo apt install -y nodejs
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following NEW packages will be installed:
  nodejs
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 26.2 MB of archives.
After this operation, 122 MB of additional disk space will be used.
Get:1 https://deb.nodesource.com/node_16.x focal/main amd64 nodejs amd64 16.14.0-deb-1nodesource1 [26.2 MB]
Fetched 26.2 MB in 1s (21.5 MB/s) 
Selecting previously unselected package nodejs.
(Reading database ... 100754 files and directories currently installed.)
Preparing to unpack .../nodejs_16.14.0-deb-1nodesource1_amd64.deb ...
Unpacking nodejs (16.14.0-deb-1nodesource1) ...
Setting up nodejs (16.14.0-deb-1nodesource1) ...
Processing triggers for man-db (2.9.1-1) ...
ubuntu@ubuntufla:~$ node --version
v16.14.0
ubuntu@ubuntufla:~$ 
```



## Installiamo YARN

YARN lo installiamo sfruttando *npm* messo a disposizione da *node.js*.

> *npm* è il gestore di pacchetti (*package manager*) per la piattaforma Node JavaScript. 
> It puts modules in place so that node can find them, and manages dependency conflicts intelligently. 

> Once you have npm installed you can run the following both to **install** and **upgrade** Yarn:

```bash
$ sudo npm install --global yarn
```

> Lo script di installazione ci ha chiesto di eseguire anche `$ sudo npm install -g npm@8.3.2`

Esempio:

```bash
ubuntu@ubuntufla:~$ sudo npm install --global yarn

added 1 package, and audited 2 packages in 2s

found 0 vulnerabilities
npm notice 
npm notice New minor version of npm available! 8.3.1 -> 8.5.2
npm notice Changelog: https://github.com/npm/cli/releases/tag/v8.5.2
npm notice Run npm install -g npm@8.5.2 to update!
npm notice 
ubuntu@ubuntufla:~$ sudo npm install -g npm@8.3.2

changed 17 packages, and audited 215 packages in 4s

11 packages are looking for funding
  run `npm fund` for details

3 moderate severity vulnerabilities

To address all issues, run:
  npm audit fix

Run `npm audit` for details.
ubuntu@ubuntufla:~$ 
ubuntu@ubuntufla:~$ yarn --version
1.22.17
ubuntu@ubuntufla:~$ 
```



## Installiamo Rails

Per installare Rails carichiamo la corrispondente gemma ruby.
To install Rails, use the gem install command provided by RubyGems.

I> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/rails)
I>
I> facciamo riferimento al [tutorial della gemma](https://rubyonrails.org/)

Poiché pubblicheremo in produzione la nostra applicazione su Heroku verifichiamo quale versione Rails è supportata su [Heroku devcenter - Getting Started on Heroku with Rails 7.x](https://devcenter.heroku.com/articles/getting-started-with-rails7)

```bash
$ cd ~/environment
$ gem install rails
```

> Volendo istallare una versione specifica possiamo indicarla. 
> Ad esempio: *$ gem install rails -v 7.0.1*

Per verificare quale versione di rails abbiamo installato

```bash
$ rails --version
```

Esempio:

```bash
ubuntu@ubuntufla:~$ gem install rails
Fetching tzinfo-2.0.4.gem
Fetching activesupport-7.0.2.2.gem
Fetching i18n-1.10.0.gem
Fetching method_source-1.0.0.gem
Fetching concurrent-ruby-1.1.9.gem
Fetching thor-1.2.1.gem
Fetching zeitwerk-2.5.4.gem
Fetching loofah-2.14.0.gem
Fetching rails-html-sanitizer-1.4.2.gem
Fetching rack-2.2.3.gem
Fetching rack-test-1.1.0.gem
Fetching nokogiri-1.13.3-x86_64-linux.gem
Fetching builder-3.2.4.gem
Fetching actionview-7.0.2.2.gem
Fetching actionpack-7.0.2.2.gem
Fetching mini_mime-1.1.2.gem
Fetching marcel-1.0.2.gem
Fetching activemodel-7.0.2.2.gem
Fetching activerecord-7.0.2.2.gem
Fetching crass-1.0.6.gem
Fetching railties-7.0.2.2.gem
Fetching actiontext-7.0.2.2.gem
Fetching globalid-1.0.0.gem
Fetching mail-2.7.1.gem
Fetching activestorage-7.0.2.2.gem
Fetching actionmailer-7.0.2.2.gem
Fetching websocket-extensions-0.1.5.gem
Fetching erubi-1.10.0.gem
Fetching rails-dom-testing-2.0.3.gem
Fetching actionmailbox-7.0.2.2.gem
Fetching activejob-7.0.2.2.gem
Fetching rails-7.0.2.2.gem
Fetching websocket-driver-0.7.5.gem
Fetching nio4r-2.5.8.gem
Fetching actioncable-7.0.2.2.gem
Successfully installed zeitwerk-2.5.4
Successfully installed thor-1.2.1
Successfully installed method_source-1.0.0
Successfully installed concurrent-ruby-1.1.9
Successfully installed tzinfo-2.0.4
Successfully installed i18n-1.10.0
Successfully installed activesupport-7.0.2.2
Successfully installed nokogiri-1.13.3-x86_64-linux
Successfully installed crass-1.0.6
Successfully installed loofah-2.14.0
Successfully installed rails-html-sanitizer-1.4.2
Successfully installed rails-dom-testing-2.0.3
Successfully installed rack-2.2.3
Successfully installed rack-test-1.1.0
Successfully installed erubi-1.10.0
Successfully installed builder-3.2.4
Successfully installed actionview-7.0.2.2
Successfully installed actionpack-7.0.2.2
Successfully installed railties-7.0.2.2
Successfully installed mini_mime-1.1.2
Successfully installed marcel-1.0.2
Successfully installed activemodel-7.0.2.2
Successfully installed activerecord-7.0.2.2
Successfully installed globalid-1.0.0
Successfully installed activejob-7.0.2.2
Successfully installed activestorage-7.0.2.2
Successfully installed actiontext-7.0.2.2
Successfully installed mail-2.7.1
Successfully installed actionmailer-7.0.2.2
Successfully installed actionmailbox-7.0.2.2
Successfully installed websocket-extensions-0.1.5
Building native extensions. This could take a while...
Successfully installed websocket-driver-0.7.5
Building native extensions. This could take a while...
Successfully installed nio4r-2.5.8
Successfully installed actioncable-7.0.2.2
Successfully installed rails-7.0.2.2
Parsing documentation for zeitwerk-2.5.4
Installing ri documentation for zeitwerk-2.5.4
Parsing documentation for thor-1.2.1
Installing ri documentation for thor-1.2.1
Parsing documentation for method_source-1.0.0
Installing ri documentation for method_source-1.0.0
Parsing documentation for concurrent-ruby-1.1.9
Installing ri documentation for concurrent-ruby-1.1.9
Parsing documentation for tzinfo-2.0.4
Installing ri documentation for tzinfo-2.0.4
Parsing documentation for i18n-1.10.0
Installing ri documentation for i18n-1.10.0
Parsing documentation for activesupport-7.0.2.2
Installing ri documentation for activesupport-7.0.2.2
Parsing documentation for nokogiri-1.13.3-x86_64-linux
Installing ri documentation for nokogiri-1.13.3-x86_64-linux
Parsing documentation for crass-1.0.6
Installing ri documentation for crass-1.0.6
Parsing documentation for loofah-2.14.0
Installing ri documentation for loofah-2.14.0
Parsing documentation for rails-html-sanitizer-1.4.2
Installing ri documentation for rails-html-sanitizer-1.4.2
Parsing documentation for rails-dom-testing-2.0.3
Installing ri documentation for rails-dom-testing-2.0.3
Parsing documentation for rack-2.2.3
Installing ri documentation for rack-2.2.3
Parsing documentation for rack-test-1.1.0
Installing ri documentation for rack-test-1.1.0
Parsing documentation for erubi-1.10.0
Installing ri documentation for erubi-1.10.0
Parsing documentation for builder-3.2.4
Installing ri documentation for builder-3.2.4
Parsing documentation for actionview-7.0.2.2
Installing ri documentation for actionview-7.0.2.2
Parsing documentation for actionpack-7.0.2.2
Installing ri documentation for actionpack-7.0.2.2
Parsing documentation for railties-7.0.2.2
Installing ri documentation for railties-7.0.2.2
Parsing documentation for mini_mime-1.1.2
Installing ri documentation for mini_mime-1.1.2
Parsing documentation for marcel-1.0.2
Installing ri documentation for marcel-1.0.2
Parsing documentation for activemodel-7.0.2.2
Installing ri documentation for activemodel-7.0.2.2
Parsing documentation for activerecord-7.0.2.2
Installing ri documentation for activerecord-7.0.2.2
Parsing documentation for globalid-1.0.0
Installing ri documentation for globalid-1.0.0
Parsing documentation for activejob-7.0.2.2
Installing ri documentation for activejob-7.0.2.2
Parsing documentation for activestorage-7.0.2.2
Installing ri documentation for activestorage-7.0.2.2
Parsing documentation for actiontext-7.0.2.2
Installing ri documentation for actiontext-7.0.2.2
Parsing documentation for mail-2.7.1
Installing ri documentation for mail-2.7.1
Parsing documentation for actionmailer-7.0.2.2
Installing ri documentation for actionmailer-7.0.2.2
Parsing documentation for actionmailbox-7.0.2.2
Installing ri documentation for actionmailbox-7.0.2.2
Parsing documentation for websocket-extensions-0.1.5
Installing ri documentation for websocket-extensions-0.1.5
Parsing documentation for websocket-driver-0.7.5
Installing ri documentation for websocket-driver-0.7.5
Parsing documentation for nio4r-2.5.8
Installing ri documentation for nio4r-2.5.8
Parsing documentation for actioncable-7.0.2.2
Installing ri documentation for actioncable-7.0.2.2
Parsing documentation for rails-7.0.2.2
Installing ri documentation for rails-7.0.2.2
Done installing documentation for zeitwerk, thor, method_source, concurrent-ruby, tzinfo, i18n, activesupport, nokogiri, crass, loofah, rails-html-sanitizer, rails-dom-testing, rack, rack-test, erubi, builder, actionview, actionpack, railties, mini_mime, marcel, activemodel, activerecord, globalid, activejob, activestorage, actiontext, mail, actionmailer, actionmailbox, websocket-extensions, websocket-driver, nio4r, actioncable, rails after 61 seconds
35 gems installed
ubuntu@ubuntufla:~$ rails --version
Rails 7.0.2.2
ubuntu@ubuntufla:~$ 
```

L'ambiente Ruby on Rails è pronto ma prima di creare la nostra applicazione installiamo il database PostgreSQL. Questo lo facciamo nel prossimo capitolo.


---
[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/03_00-implement_ide.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/05_00-install_postgresql.md)
