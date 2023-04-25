# <a name="top"></a> Cap 1.1b - Aggiorniamo il sistema operativo

La nuova macchina virtuale ha un sistema operativo che non ha gli ultimi aggiornamenti. Se aspettiamo qualche ora spegnendo e riaccendendo la macchina (multipass stop / start) vedremo che ci saranno presentati aggiornamenti da fare.



## Risorse esterne

- [Dal sito di ubuntu al -> sito multipass](https://multipass.run/docs/installing-on-macos)
- https://multipass.run/docs
- https://ubuntu.com/server/docs/virtualization-multipass



## Aggiorniamo il sistema operativo

Per mantenere il sistema operativo aggiornato eseguiamo:

```bash
$ sudo apt update
$ sudo apt upgrade
```

Poi uscire e riavviare la macchina.

> prima di dare `shell` assicurarsi che la macchina sia "running" con `list`

```bash
$ exit
$ multipass stop ub22fla
$ multipass start ub22fla
$ multipass list
$ multipass shell ub22fla
```


Esempio:

```bash
ubuntu@primary:~$ sudo apt update
Hit:1 http://security.ubuntu.com/ubuntu jammy-security InRelease
Hit:2 http://archive.ubuntu.com/ubuntu jammy InRelease
Hit:3 http://archive.ubuntu.com/ubuntu jammy-updates InRelease
Hit:4 http://archive.ubuntu.com/ubuntu jammy-backports InRelease
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
14 packages can be upgraded. Run 'apt list --upgradable' to see them.
ubuntu@primary:~$ sudo apt upgrade
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Calculating upgrade... Done
The following NEW packages will be installed:
  linux-headers-5.15.0-70 linux-headers-5.15.0-70-generic linux-image-5.15.0-70-generic linux-modules-5.15.0-70-generic
The following packages have been kept back:
  apt apt-utils libapt-pkg6.0
The following packages will be upgraded:
  libxml2 linux-headers-generic linux-headers-virtual linux-image-virtual linux-virtual ubuntu-advantage-tools vim vim-common vim-runtime vim-tiny xxd
11 upgraded, 4 newly installed, 0 to remove and 3 not upgraded.
10 standard LTS security updates
Need to get 171 kB/60.3 MB of archives.
After this operation, 241 MB of additional disk space will be used.
Do you want to continue? [Y/n] Y
Get:1 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 ubuntu-advantage-tools amd64 27.14.4~22.04 [171 kB]
Fetched 171 kB in 0s (733 kB/s)             
Preconfiguring packages ...
(Reading database ... 64204 files and directories currently installed.)
Preparing to unpack .../00-libxml2_2.9.13+dfsg-1ubuntu0.3_amd64.deb ...
Unpacking libxml2:amd64 (2.9.13+dfsg-1ubuntu0.3) over (2.9.13+dfsg-1ubuntu0.2) ...
Preparing to unpack .../01-ubuntu-advantage-tools_27.14.4~22.04_amd64.deb ...
Unpacking ubuntu-advantage-tools (27.14.4~22.04) over (27.13.6~22.04.1) ...
Preparing to unpack .../02-vim_2%3a8.2.3995-1ubuntu2.7_amd64.deb ...
Unpacking vim (2:8.2.3995-1ubuntu2.7) over (2:8.2.3995-1ubuntu2.5) ...
Preparing to unpack .../03-vim-tiny_2%3a8.2.3995-1ubuntu2.7_amd64.deb ...
Unpacking vim-tiny (2:8.2.3995-1ubuntu2.7) over (2:8.2.3995-1ubuntu2.5) ...
Preparing to unpack .../04-vim-runtime_2%3a8.2.3995-1ubuntu2.7_all.deb ...
Unpacking vim-runtime (2:8.2.3995-1ubuntu2.7) over (2:8.2.3995-1ubuntu2.5) ...
Preparing to unpack .../05-xxd_2%3a8.2.3995-1ubuntu2.7_amd64.deb ...
Unpacking xxd (2:8.2.3995-1ubuntu2.7) over (2:8.2.3995-1ubuntu2.5) ...
Preparing to unpack .../06-vim-common_2%3a8.2.3995-1ubuntu2.7_all.deb ...
Unpacking vim-common (2:8.2.3995-1ubuntu2.7) over (2:8.2.3995-1ubuntu2.5) ...
Selecting previously unselected package linux-headers-5.15.0-70.
Preparing to unpack .../07-linux-headers-5.15.0-70_5.15.0-70.77_all.deb ...
Unpacking linux-headers-5.15.0-70 (5.15.0-70.77) ...
Selecting previously unselected package linux-headers-5.15.0-70-generic.
Preparing to unpack .../08-linux-headers-5.15.0-70-generic_5.15.0-70.77_amd64.deb ...
Unpacking linux-headers-5.15.0-70-generic (5.15.0-70.77) ...
Selecting previously unselected package linux-modules-5.15.0-70-generic.
Preparing to unpack .../09-linux-modules-5.15.0-70-generic_5.15.0-70.77_amd64.deb ...
Unpacking linux-modules-5.15.0-70-generic (5.15.0-70.77) ...
Selecting previously unselected package linux-image-5.15.0-70-generic.
Preparing to unpack .../10-linux-image-5.15.0-70-generic_5.15.0-70.77_amd64.deb ...
Unpacking linux-image-5.15.0-70-generic (5.15.0-70.77) ...
Preparing to unpack .../11-linux-virtual_5.15.0.70.68_amd64.deb ...
Unpacking linux-virtual (5.15.0.70.68) over (5.15.0.69.67) ...
Preparing to unpack .../12-linux-image-virtual_5.15.0.70.68_amd64.deb ...
Unpacking linux-image-virtual (5.15.0.70.68) over (5.15.0.69.67) ...
Preparing to unpack .../13-linux-headers-virtual_5.15.0.70.68_amd64.deb ...
Unpacking linux-headers-virtual (5.15.0.70.68) over (5.15.0.69.67) ...
Preparing to unpack .../14-linux-headers-generic_5.15.0.70.68_amd64.deb ...
Unpacking linux-headers-generic (5.15.0.70.68) over (5.15.0.69.67) ...
Setting up linux-headers-5.15.0-70 (5.15.0-70.77) ...
Setting up xxd (2:8.2.3995-1ubuntu2.7) ...
Setting up linux-headers-5.15.0-70-generic (5.15.0-70.77) ...
Setting up vim-common (2:8.2.3995-1ubuntu2.7) ...
Setting up ubuntu-advantage-tools (27.14.4~22.04) ...
Installing new version of config file /etc/apt/apt.conf.d/20apt-esm-hook.conf ...
Installing new version of config file /etc/ubuntu-advantage/uaclient.conf ...
Installing new version of config file /etc/update-motd.d/91-contract-ua-esm-status ...
Removing obsolete conffile /etc/update-motd.d/88-esm-announce ...
Setting up vim-runtime (2:8.2.3995-1ubuntu2.7) ...
Setting up libxml2:amd64 (2.9.13+dfsg-1ubuntu0.3) ...
Setting up vim (2:8.2.3995-1ubuntu2.7) ...
Setting up linux-headers-generic (5.15.0.70.68) ...
Setting up vim-tiny (2:8.2.3995-1ubuntu2.7) ...
Setting up linux-headers-virtual (5.15.0.70.68) ...
Setting up linux-image-5.15.0-70-generic (5.15.0-70.77) ...
I: /boot/vmlinuz is now a symlink to vmlinuz-5.15.0-70-generic
I: /boot/initrd.img is now a symlink to initrd.img-5.15.0-70-generic
Setting up linux-image-virtual (5.15.0.70.68) ...
Setting up linux-modules-5.15.0-70-generic (5.15.0-70.77) ...
Setting up linux-virtual (5.15.0.70.68) ...
Processing triggers for libc-bin (2.35-0ubuntu3.1) ...
Processing triggers for man-db (2.10.2-1) ...
Processing triggers for linux-image-5.15.0-70-generic (5.15.0-70.77) ...
/etc/kernel/postinst.d/initramfs-tools:
update-initramfs: Generating /boot/initrd.img-5.15.0-70-generic
/etc/kernel/postinst.d/zz-update-grub:
Sourcing file `/etc/default/grub'
Sourcing file `/etc/default/grub.d/50-cloudimg-settings.cfg'
Sourcing file `/etc/default/grub.d/init-select.cfg'
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-5.15.0-70-generic
Found initrd image: /boot/initrd.img-5.15.0-70-generic
Found linux image: /boot/vmlinuz-5.15.0-69-generic
Found initrd image: /boot/initrd.img-5.15.0-69-generic
Warning: os-prober will not be executed to detect other bootable partitions.
Systems on them will not be added to the GRUB boot configuration.
Check GRUB_DISABLE_OS_PROBER documentation entry.
done
Scanning processes...                                                                                                                                                   
Scanning candidates...                                                                                                                                                  
Scanning linux images...                                                                                                                                                

Restarting services...
 systemctl restart packagekit.service

No containers need to be restarted.

No user sessions are running outdated binaries.

No VM guests are running outdated hypervisor (qemu) binaries on this host.
ubuntu@primary:~$ 


ubuntu@primary:~$ exit
logout
MacBook-Pro-di-Flavio:Downloads FB$ multipass list
Name                    State             IPv4             Image
primary                 Running           192.168.64.5     Ubuntu 22.04 LTS
ub22fla                 Stopped           --               Ubuntu 22.04 LTS
ubuntufla               Stopped           --               Ubuntu 20.04 LTS
MacBook-Pro-di-Flavio:Downloads FB$ multipass stop primary
MacBook-Pro-di-Flavio:Downloads FB$ multipass list                      
Name                    State             IPv4             Image
primary                 Stopped           --               Ubuntu 22.04 LTS
ub22fla                 Stopped           --               Ubuntu 22.04 LTS
ubuntufla               Stopped           --               Ubuntu 20.04 LTS
MacBook-Pro-di-Flavio:Downloads FB$ multipass start primary
MacBook-Pro-di-Flavio:Downloads FB$ multipass list
Name                    State             IPv4             Image
primary                 Running           192.168.64.5     Ubuntu 22.04 LTS
ub22fla                 Stopped           --               Ubuntu 22.04 LTS
ubuntufla               Stopped           --               Ubuntu 20.04 LTS
MacBook-Pro-di-Flavio:Downloads FB$ multipass shell primary
Welcome to Ubuntu 22.04.2 LTS (GNU/Linux 5.15.0-69-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Thu Apr 20 12:35:40 CEST 2023

  System load:  0.13671875        Processes:               108
  Usage of /:   43.6% of 4.67GB   Users logged in:         0
  Memory usage: 18%               IPv4 address for enp0s2: 192.168.64.5
  Swap usage:   0%


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


Last login: Thu Apr 20 12:24:34 2023 from 192.168.64.1
ubuntu@primary:~$ 
```



---
[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/00-frontmatter/03-introduction.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/02_00-install_ssh_server.md)
