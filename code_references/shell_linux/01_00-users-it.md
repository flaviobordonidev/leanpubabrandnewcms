# <a name="top"></a> Cap console_commands_linux.01 - Aggiungiamo e togliamo utenti

Gestione base degli utenti.



## Risorse interne

- [code_references/postgresql/04_00-backup_and_restore_database_render-it.md]()



## Risorse esterne

- [Linux Crash Course - Managing Users](https://www.youtube.com/watch?v=19WOD84JFxA&list=PLT98CRl2KxKHKd_tH3ssq0HPrThx2hESW&index=16)
- [Linux Crash Course - Managing Groups](https://www.youtube.com/watch?v=GnlgAD8-GhE&list=PLT98CRl2KxKHKd_tH3ssq0HPrThx2hESW&index=14)
- [Linux Crash Course - usermod](https://www.youtube.com/watch?v=p8QOnty6rSU&list=PLT98CRl2KxKHKd_tH3ssq0HPrThx2hESW&index=1)
- [Linux Crash Course - User Account & Password Expiration](https://www.youtube.com/watch?v=UYBPpaWUT64&list=PLT98CRl2KxKHKd_tH3ssq0HPrThx2hESW&index=7)

- [how-to-manage-system-users-in-linux](https://codedamn.com/news/linux/how-to-manage-system-users-in-linux)
- [Create user account and manage access permission to specific folders on Linux](https://yenthanh.medium.com/ubuntu-create-new-user-and-manage-permission-to-specific-folders-4e2761f7733)



## Understanding Linux Users

Every Linux System has an entity called User which performs a range of system management tasks.
In Linux, every process and task is executed under a specific user. These users determine the rights and permissions for processes and files.

Linux differentiates its users into two primary categories:

- **Regular Users** (aka **Normal Users** or **Common Users** or **Unprivileged Users**): These are the typical users who interact with the system. They can log in, have a home directory, and execute tasks as per their permissions. The **regular user** has limited rights to perform operation on their owned files and directory. **Regular users** can be given different level of privileges or complete root privilege totally based on the need and requirement.

- **System Users** (aka **Service Users**): These are internal Linux users, usually created during system setup. They are reserved for running system tasks and services, and typically, they do not have a login shell. System Users mostly run system services and processes in the background also known as non-interactive processes. Examples include "nobody", "daemon", or users specific to certain services like "mysql" or "apache".

The **Regular User** is the default one created with the command `useradd username`.
The **System User** is created adding an option to the command `useradd --system username`.



## In what condition, should I create a system user instead of a normal user?

From the `adduser` command, I saw the option `--system` to create a system user. A **system user** will use `/bin/false` and by default belong to `nogroup`. It also won't copy the `/etc/skel` to the home directory. (questo comportamento può variare da una distribuzione linux ad un'altra.)

In which condition would I prefer to create a **system user**?

When you are creating an account to run a **daemon**, **service**, or other **system software**, rather than an account for interactive use.

> By software accounts (system users), I mean those like ***www-data**, **ftp**, **ntp**, **postgres**, **postfix**, **mysql**, **odoo**,...
> Those accounts in my system are mainly setup by software itself. Is there conditions I need to setup such accounts manually? 
> Probably not terribly often, no. But if you were compiling the software from scratch yourself, it's easy to imagine a need as part of make install...
> Un esempio che mi è capitato è l'installazione di odoo che compilata da sorgente non crea in automatico l'account.

Technically, it makes no difference, but in the real world it turns out there are long term benefits in keeping user and software accounts in separate parts of the numeric space.
That is not a technical difference but an organizational decision. E.g. it makes sense to show normal users in a login dialog (so that you can click them instead of having to type the user name) but it wouldn't to show system accounts (the UIDs under which **daemons** and other **automatic processes** run).

Mostly, it makes it easy to tell what the account is, and if a human should be able to log in.



## The Root User

There is also **one** special user that is the **Root user**.
The **Root user** (aka **superuser**) has all the privileges and has all the control to do anything on the system.

The **Regular Users** and the **Root user** are included in a category called **Human Users**.


### The Concept of sudo
`sudo` (superuser do) allows permitted users to execute a command as the superuser or another user. It provides a controlled way to grant elevated permissions without always logging in as the root.



## The /etc/passwd, /etc/shadow, and /etc/group Files

These files are pivotal to user management in Linux:

- **/etc/passwd** : Lists all users along with their information like UID, GID, home directory, and shell.
- **/etc/shadow** : Contains encrypted passwords of users. It ensures that user passwords aren’t openly accessible.
- **/etc/group** : Lists all groups, their GIDs, and the users who are members of each group.

We can find all the created users details in /etc/passwd file and all active groups details in /etc/group file.


### User IDs (UIDs) and Group IDs (GIDs)

In Linux, users are identified by their User IDs (UID) and groups by Group IDs (GID). The root user always has a UID of 0. UIDs and GIDs help Linux in distinguishing and managing access rights for users and groups.

Each user will have a unique ID called UID(User ID) and GID(Group ID). Similarly, there is another entity available called groups which is nothing but collection of users has its own role to play. User Management and Groups is an integral part of Linux System Administration which needs to be understood in detail. Here we will look into different types of users in detail with examples.

Each user has unique UID(User ID) and GID(Group ID). Whenever a user is created, it owns a home directory where all personal files and folders can be stored.

Example:
Switch to home directory. Then create a new user. We will notice that whenever a new user is created, its home directory also gets created.


## La lista degli utenti `/etc/passwd`

Vedere gli utenti presenti sul sistema:

```bash
$ cat /etc/passwd
$ cat /etc/passwd | wc -l
```

- `wc -l` = words count and show how many lines there are



## The comands to manage users

- `useradd` -> to create a new user. [man: useradd](https://man7.org/linux/man-pages/man8/useradd.8.html)
- `userdel` -> to delete an existing user.
- `groupadd` -> to create a new group.
- `groupdel` -> to delete an existing group.
- `usermod` -> make changes to existing users. 
- `passwd` -> create or change password for any user.


### useradd

```bash
$ useradd [options] username
```

When creating users, you can specify:
- Home Directory: A personal space for user files.
- Shell : The default command-line interpreter for the user.
- /etc/skel : The /etc/skel directory contains files and directories that are automatically copied over to a new user’s home directory. It’s beneficial to set up default user environments.


Example `useradd`:

```bash
$ sudo useradd cyberithub
$ grep cyberithub /etc/passwd
cyberithub:x:1003:1003::/home/ cyberithub:/bin/bash
```

```bash
$ sudo useradd --home=/home/micasa/ --shell=/bin/bash cyberithub2
$ grep cyberithub2 /etc/passwd
cyberithub2:x:1004:1004::/home/micasa/cyberithub2:/bin/bash
```

```bash
$ sudo adduser --system --group --home=/opt/odoo17 --shell=/bin/bash bot_odoo17
```

- `--system` : crea un **utente di sistema** (che ha differenza dell'utente normale, che di solito è una persona, non ha il login ed il suo UID è minore di 1000 e la sua "home" non non è su "home/username". Possiamo pensare all'utente di sistema come ad un "bot".)
- `--group` : gli aggiunge anche il gruppo (con lo stesso nome dell'utente)
- `--home=/opt/odoo16` : crea la nuova cartella `odoo16` su cui copieremo poi tutto il sorgente tramite git
- `--shell=/bin/bash` : assegna esplicitamente la sua shell di lavoro (quasi sempre di default è comunque /bin/bash)
- `odoo16` : è il nome che diamo al nuovo utente di sistema


```bash
$ sudo adduser -r -U -m -d /opt/odoo17 -s /bin/bash odoo17
```

- `-r` (`--system`) = system account
- `-U` (`--group`) = crea un "group" con lo stesso nome dell'utente (user)
- `-m` = aggiunge la "home" directory all'utente
- `-d` = definisce il percorso per la "home" directory
- `-s` (`--shell`) = definisce il percorso e nome della shell

> le opzioni `-m -d /opt/odo` sono uguali a `--home=/opt/odoo`? Devo verificarlo.


### userdel

When users no longer need access, it’s essential to safely remove them.
Syntax:

```bash
$ userdel [options] username
```

[man: userdel](https://man7.org/linux/man-pages/man8/userdel.8.html)

When deleting, always ensure you don’t unintentionally erase critical data.

Example `userdel`:

```bash
$ sudo userdel cyberithub
```


### usermod

There are many operations that can be performed once the user is created like adding the comment, changing the password, changing the home dir etc. One such example is given below. We are changing the home directory of user cyberithub from /home/cyberithub to /home/gpuser.

Sintassi:

```bash
$ usermod [options] username
```

[man: usermod](https://man7.org/linux/man-pages/man8/usermod.8.html)

Example `usermod`:

```bash
[root@cyberithub home]# grep cyberithub /etc/passwd
cyberithub:x:1003:1003::/home/ cyberithub:/bin/bash   
[root@cyberithub home]# usermod -d /home/gpuser cyberithub
[root@cyberithub home]# grep cyberithub /etc/passwd
cyberithub:x:1003:1003::/home/gpuser:/bin/bash
```

### groupadd

User groups are essential in Linux as they allow system administrators to set permissions for multiple users simultaneously, making the management process more efficient.

```bash
$ groupadd [options] groupname
```

Example `groupadd`:

```bash
$ sudo groupadd cyberithub
$ grep cyberithub /etc/group
cyberithub:x:1003:
```

This creates a group named “cyberithub”.


### groupdel

If a group is no longer needed, it can be deleted using groupdel:
Sintassi:

```bash
$ groupdel [options] groupname
```

Example `groupdel`:

```bash
$ sudo groupdel cyberithub
```


### groupmod

If you need to rename or modify a group, the groupmod command is the solution. 
Sintassi:

```bash
$ groupmod [options] groupname
```

For example, to rename the “developers” group to “devs”:

```bash
$ sudo groupmod -n devs developers
```


### passwd

```bash
$ passwd [options] username
```

The passwd command is the go-to utility for managing user passwords. At its simplest, running passwd without any arguments will prompt you to change your password. For system administrators, the passwd utility can also be used to reset or modify any user’s password. For example, to change the password for the user john, you would use:

```bash
$ sudo passwd john
```

This command will prompt you for a new password for the user.


Example `passwd`:

```bash
[root@cyberithub home]# passwd cyberithub
Changing password for user cyberithub.
New password:
Retype new password:
passwd: all authentication tokens updated successfully.
```


## Password Policies
Ensuring strong password practices is vital for system security. You can enforce policies like minimum password length, password complexity, and password expiration. This is typically done using Pluggable Authentication Modules (PAM) in Linux. The configuration for password policies is typically located in `/etc/security/pwquality.conf` or in PAM’s password-related files.

The `/etc/login.defs` File
This file is a configuration tool for setting the system-wide defaults on a Linux system. Parameters in `/etc/login.defs` allow system administrators to control aspects like password expiration, password length, and more. Regularly review and appropriately configure this file to enhance security.





## How to Find UID and GID of a user


- `id` -> to view the UID and GID of current user
- `id user_name` -> to view UID and GID of a particular user



Example `id`:

```bash
[root@cyberithub home]# id
uid=0(root) gid=0(root) groups=0(root) context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
```

Example `id user_name`:

```bash
[root@cyberithub home]# id cyberithub
uid=1003(cyberithub) gid=1003(cyberithub) groups=1003(cyberithub)
```



## Create System User

System users can also be created using useradd command but with some extra flags in the command. Below we are creating a system user called ‘cyberuser’ where

- `r` (or `--system`) -> create a system user with a real ID in the correct numerical range for system users
- `s` -> specifies the login shell
- `/bin/false` -> dummy command that prevents the user from logging into the system.

```bash
[root@cyberithub home]# useradd -rs /bin/false cyberuser
[root@cyberithub home]# grep cyberuser /etc/passwd
cyberuser:x:997:993::/home/cyberuser:/bin/false
```

> NOTE:
> Please note that here home directory for system users doesn’t get created automatically.



## Create System group

System group can be created using the same command but with `-r` flag.

```bash
[root@cyberithub home]# groupadd -r cyberuser
[root@cyberithub home]# grep cyberuser /etc/group
cyberuser:x:993:
```



## Good To Know
Human users differ from Group users in terms of UID and GID range that are assigned to them. This setting can be found in /etc/login.defs file. Notice the below section of the file where UID and GID range is different for system and human users.

```bash
[root@cyberithub home]# view /etc/login.defs
# Min/max values for automatic uid selection in useradd
#
UID_MIN                  1000
UID_MAX                 60000
# System accounts
SYS_UID_MIN               201
SYS_UID_MAX               999
#
# Min/max values for automatic gid selection in groupadd
#
GID_MIN                  1000
GID_MAX                 60000
# System accounts
SYS_GID_MIN               201
SYS_GID_MAX               999
#
```



## User Session Management

Monitoring who is logged into the system and managing their sessions can be essential, especially on shared systems or servers.

Understanding `who`, `w`, and `last` Commands
These commands help monitor user sessions:

- `who`  : Shows who is currently logged in.
- `w`    : Gives detailed information about each user’s session.
- `last` : Displays a list of the last logged in users.

Killing Sessions with `pkill` and `kill`
If you need to end a user’s session, use the `pkill` or `kill` command with the user’s process ID. Always be cautious when using these commands, as you might unintentionally terminate important processes.



## Configuring User Permissions & Access

Rights management is at the heart of Linux security.

### Basics of Linux File Permissions
Every file and directory in Linux has associated access permissions. They determine who can read (r), write (w), or execute (x) a file. These permissions are set for the file’s owner, the group associated with the file, and everyone else.

Commands: `chmod`, `chown`, `chgrp`

- `chmod` : Modifies file permissions. 
- `chown` : Changes file owner. 
- `chgrp` : Changes the group ownership of a file.


Esempio chmod:

```bash
$ chmod 755 filename
```

Sets the following permission to the file "filename":
- (7) read, write, and execute permissions for the owner 
- (5) read and execute permissions for the group
- (5) read and execute permissions for the  others

Esempio chown:

```bash
$ chown john:developers filename 
```
 
changes the file’s owner to “john” and its group to “developers.”


### Understanding umask
The `umask` command determines the default file and directory permissions for new files. A typical umask value might be **022**, which means new files will have 755 permissions by default.



## User Permission Issues
When users can’t access a file or service, it’s often due to incorrect permissions or ownership. 
Use `ls -l` to check and `chmod` or `chown` to rectify.

