# <a name="top"></a> Vol. 0 Cap 15.4 - Più spazio disco su sessione c9 - Resize disk space (storage size)



## Capitoli dei libri dove è usato

- [01-base / 01-new-app / 09-aws_c9_more_disk_space ](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/09-aws_c9_more_disk_space.md)



## Risorse web

- [how-to-increase-the-size-of-an-aws](https://n2ws.com/blog/how-to-guides/how-to-increase-the-size-of-an-aws-ebs-cloud-volume-attached-to-a-linux-machine)
- [move-environment-resize](https://docs.aws.amazon.com/cloud9/latest/user-guide/move-environment.html#move-environment-resize)



## How to Increase the Size of an EBS Volume Attached to a Linux Machine

Amazon Elastic Block Store (Amazon EBS) offers persistent storage for Amazon EC2 instances by means of block-level storage volumes. These volumes provide a scalable plug and play storage service, that persists independently of an instance’s life cycle. An EBS volume is cost-effective, scalable, and comes with three options:

General Purpose (SSD)
Provisioned IOPS (SSD)
Magnetic (the old standard)

An EBS volume can be attached as a root partition to an EBS-backed AMI instance or as a detachable device to any AWS EC2 instance. When a user creates an EBS volume, AWS provisions an appropriate amount of space to the user’s AWS account according to the size of the requested EBS volume. In the future, the user may need to increase the size of the EBS volume in order to accommodate a larger amount of data.




## I tipi di istanze di cloud9

in fase di creazione abbiamo 

* t2 nano
* t2 micro (la scelta di default)
* t2 small
* ...

Queste istanze cambiano la RAM e le CPU a disposizione ma hanno tutte 10GB di spazio iniziale e scegliendo linux ubuntu 8GB li prende il sistema operativo. Quindi ci restano solo 2GB disponibili.

Non serve aumentare la tipologia di istanza ma dobbiamo passare per i volumi associati per aumentare lo spazio disco.
Vediamo come fare.




## Verifichiamo quanto spazio abbiamo

- [linux check disk space](https://www.cyberciti.biz/faq/linux-check-disk-space-command/)

I comandi principali da terminale/console di ubuntu per vedere lo spazio disco sono:

- df command – Shows the amount of disk space used and available on Linux file systems.
- du command – Display the amount of disk space used by the specified files and for each subdirectory.
- btrfs fi df /device/ – Show disk space usage information for a btrfs based mount point/file system.


Vediamo un esempio di "df" con l'opzione "-h" che rappresenta i valori in un modo facile da capire (human readable).

```bash
$ df -h

Esempio:

```bash

user_fb:~/environment/elisinfo (ci) $ df -h
Filesystem      Size  Used Avail Use% Mounted on
udev            476M     0  476M   0% /dev
tmpfs            98M  848K   98M   1% /run
/dev/xvda1      9.7G  9.6G   81M 100% /
tmpfs           490M  8.0K  490M   1% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs           490M     0  490M   0% /sys/fs/cgroup
/dev/loop0       29M   29M     0 100% /snap/amazon-ssm-agent/2012
/dev/loop2       13M   13M     0 100% /snap/amazon-ssm-agent/495
/dev/loop1       97M   97M     0 100% /snap/core/9804
/dev/loop3       98M   98M     0 100% /snap/core/9993
tmpfs            98M     0   98M   0% /run/user/1000
```

In questo esempio vediamo che abbiamo il disco praticamente pieno:

```bash
Filesystem      Size  Used Avail Use% Mounted on
/dev/xvda1      9.7G  9.6G   81M 100% /
```

Ci restano 81M liberi. Ed infatti la EC2 su Cloud9 ci da il messaggio di disco pieno!




## Ampliamo dai 10G di default a 12G - Metodo facile

Questa procedura è la più semplice ed immediata ma richiede del tempo prima che le modifiche diventino effettive e questo può trarre in inganno e far pensare che non abbia funzionato. 
Se ci riproviamo riceviamo un messaggio di errore che ci depista e ci fa pensare che non sia possibile fare in questo modo. 
Ma se si ha la pazienza di aspettare, a volte anche qualche ora, allora si vedrà che funziona.

Andiamo su services -> EC2 -> INSTANCES -> instances

Tramite la colonna "name" identifichiamo l'istanza EC2 relativa alla nostra istanza Cloud9.

Tutti i nomi delle istanze cloud9 hanno la struttura: ***aws-cloud9-***+***<nome istanza cloud9>***+***<id>***

Ad esempio: ***aws-cloud9-bl6-0-344675c50cee4a70168f22b38a509d5c***

Trovata la "riga" che ci interessa copiamoci il suo **instance id**, normalmente è la colonna a fianco.

Ad esempio: **i-0746cbf70a73f6db0**


Andiamo su service -> EC2 -> ELASTIC BLOCK STORE -> Volumes

Nel campo di ricerca inseriamo l'"instance id" e sul volume trovato eseguiamo:

Action -> Modify Volume

E cambiamo la dimensione da "10" a "12".




## Esempio

Uso il comando df con opzione -h (human readable) e -T (che mostra il tipo di partizione)

{title="terminal", lang=bash, line-numbers=off}
```
$ df -hT


user_fb:~/environment $ df -hT
Filesystem     Type      Size  Used Avail Use% Mounted on
udev           devtmpfs  476M     0  476M   0% /dev
tmpfs          tmpfs      98M  852K   98M   1% /run
/dev/xvda1     ext4      9.7G  9.6G   80M 100% /
tmpfs          tmpfs     490M  8.0K  490M   1% /dev/shm
tmpfs          tmpfs     5.0M     0  5.0M   0% /run/lock
tmpfs          tmpfs     490M     0  490M   0% /sys/fs/cgroup
/dev/loop0     squashfs   97M   97M     0 100% /snap/core/9804
/dev/loop1     squashfs   13M   13M     0 100% /snap/amazon-ssm-agent/495
/dev/loop2     squashfs   29M   29M     0 100% /snap/amazon-ssm-agent/2012
/dev/loop3     squashfs   98M   98M     0 100% /snap/core/9993
tmpfs          tmpfs      98M     0   98M   0% /run/user/1000
```

Vediamo che il disco è di 10G ed è usato al 100% (abbiamo solo 80M liberi):

```
/dev/xvda1     ext4      9.7G  9.6G   80M 100% /
```

* Effettuiamo l'azione di ingrandimento da 10G a 12G.
* Stoppiamo la macchina EC2 
* Riavviamo la sessione cloud9

Adesso il disco è di 12G ed è usato al 83% (abbiamo 2.1G liberi):

```
/dev/xvda1     ext4       12G  9.6G  2.1G  83% /
```


{title="terminal", lang=bash, line-numbers=off}
```
$ df -hT


user_fb:~/environment $ df -hT
Filesystem     Type      Size  Used Avail Use% Mounted on
udev           devtmpfs  476M     0  476M   0% /dev
tmpfs          tmpfs      98M  808K   98M   1% /run
/dev/xvda1     ext4       12G  9.6G  2.1G  83% /
tmpfs          tmpfs     490M  8.0K  490M   1% /dev/shm
tmpfs          tmpfs     5.0M     0  5.0M   0% /run/lock
tmpfs          tmpfs     490M     0  490M   0% /sys/fs/cgroup
/dev/loop0     squashfs   98M   98M     0 100% /snap/core/9993
/dev/loop1     squashfs   13M   13M     0 100% /snap/amazon-ssm-agent/495
/dev/loop2     squashfs   97M   97M     0 100% /snap/core/9804
/dev/loop3     squashfs   29M   29M     0 100% /snap/amazon-ssm-agent/2012
tmpfs          tmpfs      98M     0   98M   0% /run/user/1000
```








## Ampliamo dai 10G di default a 16G - Metodo con snapshot

Aumentiamo il "volume EBS principale" (root EBS volume) dai 10GB di default a 16GB.

- Partiamo da un'istanza EC2 basata su Linux Ubuntu.
- Aumentiamo le dimensioni del nostro volume EBS usando gli "snapshot".
- Sganciamo il volume dalla nostra istanza Cloud9
- Facciamo lo snapshot del volume.
- Creiamo un nuovo volume più grande 




## Lanciamo un'istanza aws cloud9

Per prima cosa lanciamo un'istanza di cloud9, che a sua volta avvierà un'istanza EC2 con un volume EBS collegato come "root". 
Il volume EBS radice (root EBS volume) viene utilizzato come riferimento, quindi è possibile seguire lo stesso passaggio per tutti i volumi.

Eseguiamo da console il comando "df -h" per mostrare i dettagli del disco prima del ridimensionamento.


```
$ df -hT /dev/xvda1

user_fb:~/environment $ df -hT /dev/xvda1
Filesystem     Type  Size  Used Avail Use% Mounted on
/dev/xvda1     ext4  9.7G  7.7G  2.0G  80% /
user_fb:~/environment $ 

dopo qualche mese:

user_fb:~/environment/elisinfo (ci) $ df -hT /dev/xvda1
Filesystem     Type  Size  Used Avail Use% Mounted on
/dev/xvda1     ext4  9.7G  9.6G   81M 100% /
```




## Stop the istance

To increase the size of the root volume, since this is an EBS-backed instance, first stop the instance temporarily.




Blablabla da fa




## Riapriamo l'istanza con cloud9 

e vediamo che adesso lo spazio è aumentato

```
$ df -hT /dev/xvda1

user_fb:~/environment $ df -hT /dev/xvda1
Filesystem     Type  Size  Used Avail Use% Mounted on
/dev/xvda1     ext4   16G  7.7G  7.8G  50% /
```

