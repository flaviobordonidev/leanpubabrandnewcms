# <a name="top"></a> Cap 1.4 - Più spazio disco su sessione c9

Lo spazio disco allocato inizialmente è poco per avere un ambiente di sviluppo locale Rails.
Quindi lo aumentiamo.



## Risorse interne

- [99-rails_references / 015-aws_cloud9 / 03-running_out_of_space]
- [99-rails_references / 015-aws_cloud9 / 04-disk_resize]



## Risorse esterne

- [Amazon: environment size](https://docs.aws.amazon.com/cloud9/latest/user-guide/move-environment.html#move-environment-resize)
- [Amazon: aftere resize expand the file system](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/recognize-expanded-volume-linux.html)
- [linux check disk space](https://www.cyberciti.biz/faq/linux-check-disk-space-command/)



## Verifichiamo quanto spazio abbiamo
I comandi principali da terminale/console di ubuntu per vedere lo spazio disco sono:

- df command – Shows the amount of disk space used and available on Linux file systems.
- du command – Display the amount of disk space used by the specified files and for each subdirectory.
- btrfs fi df /device/ – Show disk space usage information for a btrfs based mount point/file system.

Usiamo il comando df con opzione -h (human readable) e -T (che mostra il tipo di partizione).

```bash
$ df -hT /dev/xvda1
```

Esempio:

```bash
user_fb:~/environment $ df -hT
Filesystem     Type      Size  Used Avail Use% Mounted on
udev           devtmpfs  473M     0  473M   0% /dev
tmpfs          tmpfs      98M  812K   97M   1% /run
/dev/xvda1     ext4      9.7G  8.5G  1.2G  88% /
tmpfs          tmpfs     488M     0  488M   0% /dev/shm
tmpfs          tmpfs     5.0M     0  5.0M   0% /run/lock
tmpfs          tmpfs     488M     0  488M   0% /sys/fs/cgroup
/dev/loop0     squashfs  100M  100M     0 100% /snap/core/11993
/dev/loop1     squashfs   56M   56M     0 100% /snap/core18/2253
/dev/loop2     squashfs   44M   44M     0 100% /snap/snapd/14295
/dev/loop3     squashfs   25M   25M     0 100% /snap/amazon-ssm-agent/4046
tmpfs          tmpfs      98M     0   98M   0% /run/user/1000
user_fb:~/environment $ df -hT /dev/xvda1
Filesystem     Type  Size  Used Avail Use% Mounted on
/dev/xvda1     ext4  9.7G  8.5G  1.2G  88% /
user_fb:~/environment $ 
```

Dei **10GB** di volume totale abbiamo **9.7GB** nella partizione *root* ossia quella *Mounted on* **/**.

E ci restano **1.2GB** di spazio disponibile (colonna *Avail*).

Sono pochi perché installeremo diverse applicazioni per preparare il nostro ambiente di sviluppo.
Quindi ingrandiamo il nostro volume portandolo a 12GB.



## Errore di spazio disco

Se non aumentiamo lo spazio disco arriveremo al seguente messaggio di avvertimento che stiamo per terminare lo spazio disponibile.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/04_fig01-aws_c9_running_out_of_space.png)

Se non interveniamo **SUBITO** rischiamo di arrivare a non avere più spazio disponibile.
E quando non abbiamo più spazio la procedura di aumentare il volume rischia di non andare a buon fine.

> Siccome mi è successo ho deciso di inserire sin da subito l'aumento dello spazio disco. ^_^



## Aumentiamo lo spazio da 10GB a 12GB

Dalla sessione aws c9 che stiamo usando (bl7-0), facciamo clic sulla *U* in alto a destra e clic su *Manage EC2 Istances*.

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/04_fig02-aws_c9_manage_ec2.png)

Siamo portati direttamente su: ***Services -> EC2 -> Instances -> Instances***

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/04_fig03-aws_ec2_instances.png)

Ed abbiamo già filtrata dall'elenco la sola *macchina virtuale* aws EC2 su cui sta girando la sessione *aws cloud9* che stiamo usando (**bl7-0**). 

Nella colonna ***name*** identifichiamo l'istanza EC2 (la *macchina virtuale*) relativa alla nostra istanza *aws cloud9*.

Tutti i nomi delle istanze cloud9 hanno la struttura: ***aws-cloud9-[nome istanza cloud9]-[resto del codice univoco]***

Esempio: ***aws-cloud9-bl7-0-9ddf2588f4aa43569b656b87dd5ff771***

Nella colonna ***Instance ID*** abbiamo il suo **identificativo di istanza**.

Esempio: **i-01e49aba1661a2ef4**



## Troviamo il volume da ingrandire

Facciamo clic sul tab **STORAGE** e scendiamo fino al **Volume ID**.

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/04_fig04-aws_ec2_instances_storage1.png)

![fig05](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/04_fig05-aws_ec2_instances_storage2.png)

Facciamo clic sul link del **Volume ID**.

Siamo portati direttamente su: ***Services -> EC2 -> ELASTIC BLOCK STORE -> Volumes***

Ed abbiamo già filtrata dall'elenco la nostra **Instance ID**.

Esempio: ***vol-0e3c9591fece92f81***

![fig06](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/04_fig06-aws_ec2_elastic_block_store_volumes.png)

> Possiamo vedere in basso a destra che questo volume è effettivamente associato alla nostra istanza di aws cloud9.

Sul volume trovato eseguiamo:

***Action -> Modify Volume***

E cambiamo la dimensione da "10" a "12". In questo modo ampliamo dai 10G di default a 12G.

![fig07](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/04_fig07-aws_ec2_resize_volume.png)

> Attenzione:
> Questa procedura a volte richiede del tempo prima che le modifiche diventino effettive e questo può trarre in inganno e far pensare che non abbia funzionato. 
> Se ci riproviamo riceviamo un messaggio di errore che ci depista e ci fa pensare che non sia possibile fare in questo modo. 
> Ma se si ha la pazienza di aspettare, a volte anche parecchi minuti, allora si vedrà che funziona.



## Verifichiamo le nuove dimensioni dall'istanza c9

Se torniamo alla nostra istanza cloud9 non vediamo da subito il volume più grande. Dobbiamo chiudere la sezione e stoppare la relativa istanza EC2.

- Torniamo su: ***Services -> EC2 -> Instances -> Instances***
- Chiudiamo il tab del browser con l'istanza aws cloud9 attiva. (facoltativo)
- Selezioniamo la nostra istanza EC2 e la stoppiamo dal menu: ***Instance state -> Stop instance***
- Aspettiamo che sia effettivamente stoppata
- Torniamo su aws cloud9 e facciamo ripartire l'istanza **bl7-0**
- Alla ripartenza avremo lo spazio disco aumentato a 12GB


Esempio:

```bash
user_fb:~/environment $ df -hT /dev/xvda1
Filesystem     Type  Size  Used Avail Use% Mounted on
/dev/xvda1     ext4   12G  8.6G  3.1G  74% /
user_fb:~/environment $ 
```

Adesso il disco è di 12G ed è usato al 74% (abbiamo 3.1GB liberi).



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/08-gemfile_ruby_version)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/02-git/01-git_story.md)
