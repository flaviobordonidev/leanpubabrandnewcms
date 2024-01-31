# <a name="top"></a> Cap multipass_ubuntu.2 - Aggiorniamo la distribuzione di Ubuntu

Manteniamo aggiornata la versione di Ubuntu sulla VM.



## Mantenere la distribuzione aggiornata

```bash
$ sudo apt update
$ sudo apt upgrade
```



## Passare ad una nuova distribuzione

```bash
$ sudo apt update
$ sudo apt upgrade
$ do-release-upgrade
```

Esempio:

> New release '22.04.2 LTS' available.
> Run 'do-release-upgrade' to upgrade to it.

```bash
MacBook-Pro-di-Flavio:~ FB$ multipass shell ubuntufla
Welcome to Ubuntu 20.04.5 LTS (GNU/Linux 5.4.0-99-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Tue Mar  7 12:29:18 CET 2023

  System load:  0.37               Processes:               129
  Usage of /:   41.9% of 19.21GB   Users logged in:         0
  Memory usage: 6%                 IPv4 address for enp0s2: 192.168.64.3
  Swap usage:   0%

 * Strictly confined Kubernetes makes edge and IoT secure. Learn how MicroK8s
   just raised the bar for easy, resilient and secure K8s cluster deployment.

   https://ubuntu.com/engage/secure-kubernetes-at-the-edge

 * Introducing Expanded Security Maintenance for Applications.
   Receive updates to over 25,000 software packages with your
   Ubuntu Pro subscription. Free for personal use.

     https://ubuntu.com/pro

Expanded Security Maintenance for Applications is not enabled.

10 updates can be applied immediately.
To see these additional updates run: apt list --upgradable

11 additional security updates can be applied with ESM Apps.
Learn more about enabling ESM Apps service at https://ubuntu.com/esm

New release '22.04.2 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


Last login: Sun Feb 19 18:20:33 2023 from 192.168.64.1
ubuntu@ubuntufla:~ $ do-release-upgrade

Checking for a new Ubuntu release
Please install all available updates for your release before upgrading.
...
Reading cache
Checking package manager
Continue running under SSH? 
This session appears to be running under ssh. It is not recommended 
to perform a upgrade over ssh currently because in case of failure it 
is harder to recover. 

If you continue, an additional ssh daemon will be started at port 
'1022'. 
Do you want to continue? 

Continue [yN] n
=== Command detached from window (Tue Mar  7 12:53:57 2023) ====

[CTRL+c --> x]

ubuntu@ubuntufla:~ $ do-release-upgrade
Checking for a new Ubuntu release
Get:1 Upgrade tool signature [819 B]                                           
Get:2 Upgrade tool [1266 kB]                                                   
Fetched 1267 kB in 0s (0 B/s)                                                  
authenticate 'jammy.tar.gz' against 'jammy.tar.gz.gpg' 
extracting 'jammy.tar.gz'
[screen is terminating]
ubuntu@ubuntufla:~ $
```

> Non ho fatto l'upgrade di release ubuntu per evitare incasinamenti!!!
