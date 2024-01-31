# <a name="top"></a> Cap multipass_ubuntu.88 - Multipass Error recover

Ripristiniamo una sessione bloccata di multipass



## Risorse esterne

- [How to recover from Multipass Instance stopped while starting error](https://blog.mutantmahe.sh/2021-05-09-how-to-recover-from-multipass-instance-stopped-while-starting-error/)



## How to recover from Multipass Instance stopped while starting error

If you are not able to start the multipass instance either because of your **system crashed** or due to **power failure** and you are not able to get much detail about the error with the *-vvvv* verbose option.

You may be getting the output like this:

```bash
$ multipass start <INSTANCE-NAME> -vvvv
start failed: The following errors occurred:
Instance stopped while starting
Try getting the PID of multipassd and kill that process:
```

Try getting the `PID` of `multipassd` and **kill** that process:

```bash
$ ps aux | grep multipass
user            5792   1.0  0.0  4286756    764 s004  S+    8:26PM   0:00.00 grep multipass
user             725   0.0  0.2  4524668  28044   ??  S     1:32PM   0:01.04 multipass.gui --autostarting
root               141   0.0  0.1  4498516  19276   ??  Ss    1:32PM   0:00.90 /Library/Application Support/com.canonical.multipass/bin/multipassd --verbosity debug
```

Kill the process with the `PID` mentioned on above output.
Quello relativo a `multipassd` normalmente eseguito come `root`. Nel nostro caso è **141**.

> Nota:</br>
> La riga con pid 141 va a capo. La parola `multipassd` è nella seconda parte.</br>
> `/Library/Application Support/com.canonical.multipass/bin/multipassd`


```bash
$ sudo kill -9 <PID>
```

Now try running the multipass instance.

```bash
$ multipass start <INSTANCE-NAME> -vvvv
```

The above command should start the stuck multipass instance.


Esempio:

```bash
MacBook-Pro-di-Flavio:~ FB$ ps aux | grep multipass
FB                4089   0.0  0.0  4268424    724 s002  S+   12:29PM   0:00.00 grep multipass
root               103   0.0  0.3  4487284  43832   ??  Ss    9:39AM   0:05.53 /Library/Application Support/com.canonical.multipass/bin/multipassd --verbosity debug
FB                4074   0.0  0.2  4702116  34680   ??  S    12:28PM   0:00.36 multipass.gui --autostarting

MacBook-Pro-di-Flavio:~ FB$ sudo kill -9 103

MacBook-Pro-di-Flavio:~ FB$ multipass list
Name                    State             IPv4             Image
ubuntufla               Stopped           --               Ubuntu 20.04 LTS
 
MacBook-Pro-di-Flavio:~ FB$ multipass start ubuntufla
MacBook-Pro-di-Flavio:~ FB$ multipass list
Name                    State             IPv4             Image
ubuntufla               Running           192.168.64.3     Ubuntu 20.04 LTS
MacBook-Pro-di-Flavio:~ FB$ 
MacBook-Pro-di-Flavio:~ FB$ multipass shell ubuntufla
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.4.0-99-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Tue May 10 12:32:10 CEST 2022

  System load:  0.76               Processes:               134
  Usage of /:   34.7% of 19.21GB   Users logged in:         0
  Memory usage: 5%                 IPv4 address for enp0s2: 192.168.64.3
  Swap usage:   0%


0 updates can be applied immediately.


Last login: Tue May 10 12:19:42 2022 from 192.168.64.1
ubuntu@ubuntufla:~ $
```
