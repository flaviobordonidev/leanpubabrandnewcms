# <a name="top"></a> Cap 1.2 - Installiamo Rails sul server Ubuntu

Per installare Rails installiamo prima i programmi necessari a sostenerlo.



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





