# <a name="top"></a> Cap console_commands_linux.02 - Limitiamo gli utenti

Chroot jail e rbash sono una forma di limitare l'utente.

Similar to the sudo command, the chroot command changes the environment of the following command. In other words, it will change you to the newroot directory, and also makes that directory the "working" directory. The command then executes in that location, which is useful for things like rescuing a system that won’t boot. Unlike sudo, you will be "in" the directory.

The other common use of chroot is to restrict a service or user by using a wrapper to hide the rest of the filesystem, therefore restricting a remote user’s view of other users’ data. A popular implementation using this approach SFTP.



## Risorse interne

- [code_references/postgresql/04_00-backup_and_restore_database_render-it.md]()


## Risorse esterne

- [redhat: chroot jail](https://www.redhat.com/sysadmin/set-linux-chroot-jails)
- [redhat: deeper chroot jails](https://www.redhat.com/sysadmin/deeper-linux-chroot-jails)
- [chroot-jail](https://phoenixnap.com/kb/chroot-jail)


## Non è buono per odoo

L'uso di chroot jail non mi sembra una buona scelta per odoo perché restringe l'accesso a tutti gli altri programmi come ad esempio postgreesql. Dovremmo praticamente ricreare tutto dentro la sua directory "cella" (chroot jail).

Visto che siamo già su una macchina virtuale (VM) dedicata solo ad odoo, mi sembra molto più appropriato l'utente "di sistema" chiamato "odoo16" (per la versione 16 di odoo) che è ristretto alla sua directory home.

Esempio

```bash
$ sudo adduser --system --group --home=/opt/odoo16 --shell=/bin/bash odoo16
```



## Esempio di chroot jail

1.Create the restricted shell.

```bash
cp /bin/bash /bin/rbash
```

Modify the target user for the shell as restricted shell
While creating user:

```bash
# useradd -s /bin/rbash localuser
```

For existing user:

```bash
# usermod -s /bin/rbash localuser
```

For more detailed information on this, please check the KBase Article 8349

Then the user localuser is **chrooted** and can't access the links outside his *home directory* `/home/localuser`

Create a directory under `/home/localuser/`, e.g. programs

```bash
mkdir /home/localuser/programs
```

Now if you check, the user localuser can access all commands which he has allowed to execute. These commands are taken from the environmental PATH variable which is set in `/home/localuser/.bash_profile`. Modify it as follows.

```bash
cat /home/localuser/.bash_profile
```

***Codice 01 - /home/localuser/.bash_profile - linea:1***

```bash
Get the aliases and functions
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
User specific environment and startup programs
PATH=$HOME/programs
export PATH
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/migrate/06_01-db-migrate-xxx_add_price_to_eg_posts.rb)


Here the `PATH` variable is set to `~/programs` directory, as `/usr/local/bin` is binded to `/home/username/bin` and `/bin` is binded to `/home/username/bin` so replacing that.

Now after logging with the username `localuser`, user cant run a simple command too. The output will be like this,

```bash
[localuser@example ~]$ ls
-rbash: ls: command not found
[localuser@example ~]$ less file1
-rbash: less: command not found
[localuser@example ~]$ clear
-rbash: clear: command not found
[localuser@example ~]$ date
-rbash: date: command not found
[localuser@example ~]$ ping redhat.com
-rbash: ping: command not found
```

Now create the **softlinks** of commands which are required for user `localuser` to execute in the directory `/home/localuser/programs`

```bash
ln -s /bin/date /home/localuser/programs/
ln -s /bin/ls /home/localuser/programs/
ll /home/localuser/programs/
total 8
lrwxrwxrwx 1 root root 9 Oct 17 15:53 date -> /bin/date
lrwxrwxrwx 1 root root 7 Oct 17 15:43 ls -> /bin/ls
```

Here examples of `date` and `ls` commands has been taken

Again login with user `localuser` and try to execute the commands.

```bash
[localuser@example ~]$ date
Mon Oct 17 15:55:45 IST 2011
[localuser@example ~]$ ls
file1 file10 file2 file3 file4 file5 file6 file7 file8 file9 programs
[localuser@example ~]$ clear
-rbash: clear: command not found
```

One more step can be added to restrict the user for making any modifications in their `.bash_profile`, as users can change it.

Run the following command to make the user `localuser`'s `.bash_profile` file as immutable so that `root/localuser` can't modify it until root removes immutable permission from it.

```bash
# chattr +i /home/localuser/.bash_profile
```

To remove immutable tag,

```bash
# chattr -i /home/localuser/.bash_profile
```

Make file `.bash_profile` as immutable so that user localuser can't change the environmental paths.


