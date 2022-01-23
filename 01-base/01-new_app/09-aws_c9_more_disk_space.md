# <a name="top"></a> Cap 1.8 - Più spazio disco su sessione c9

Lo spazio disco allocato inizialmente è poco per avere un ambiente di sviluppo locale Rails.
Quindi lo aumentiamo.



## Risorse interne

- [99-rails_references / 015-aws_cloud9 / 03-running_out_of_space]
- [99-rails_references / 015-aws_cloud9 / 04-disk_resize]



## Risorse esterne

- [Amazon: environment size](https://docs.aws.amazon.com/cloud9/latest/user-guide/move-environment.html#move-environment-resize)



## Errore di spazio disco

Dall'interfaccia aws cloud9 riceviamo il messaggio di avviso che stiamo per terminare lo spazio disponibile.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/09_fig01-aws_c9_running_out_of_space.png)


## Verifichiamo quanto spazio abbiamo

Possiamo anche saltare questo paragrafo.
A titolo di curiosità vediamo quanto spazio abbiamo.

- [linux check disk space](https://www.cyberciti.biz/faq/linux-check-disk-space-command/)

I comandi principali da terminale/console di ubuntu per vedere lo spazio disco sono:

- df command – Shows the amount of disk space used and available on Linux file systems.
- du command – Display the amount of disk space used by the specified files and for each subdirectory.
- btrfs fi df /device/ – Show disk space usage information for a btrfs based mount point/file system.


Vediamo un esempio di "df" con l'opzione "-h" che rappresenta i valori in un modo facile da capire (human readable).

Usiamo il comando df con opzione -h (human readable) e -T (che mostra il tipo di partizione)

```bash
$ df -hT
```

Esempio:
  
```bash
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

Vediamo che il disco è di 10G ed è usato al 100%. è praticamente pieno (abbiamo solo 80M liberi):

```bash
/dev/xvda1     ext4      9.7G  9.6G   80M 100% /
```

Ed infatti la EC2 su Cloud9 ci da il messaggio di disco pieno!



## Stop the istance

To increase the size of the root volume, first stop the instance.

Vediamo qual è la *macchina virtuale* aws EC2 su cui sta girando la sessione *aws cloud9* che stiamo usando per **bl7-0**. 

Andiamo su services -> EC2 -> INSTANCES -> instances

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/09_fig02-aws_EC2_instance.png)

Selezioniamo la nostra istanza

Tramite la colonna "name" identifichiamo l'istanza EC2 relativa alla nostra istanza Cloud9.

Tutti i nomi delle istanze cloud9 hanno la struttura: ***aws-cloud9-***+***<nome istanza cloud9>***+***<id>***

Ad esempio: ***aws-cloud9-bl7-0-9ddf2588f4aa43569b656b87dd5ff771***

Trovata la "riga" che ci interessa copiamoci il suo **instance id**, normalmente è la colonna a fianco.

Ad esempio: **i-01e49aba1661a2ef4**

Dal menu *Instance State* selezioniamo la voce *Stop istance*


## Troviamo il volume da ingrandire


Andiamo su service -> EC2 -> ELASTIC BLOCK STORE -> Volumes

Nel campo di ricerca inseriamo l'*instance id* 

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/09_fig03-aws_EC2_elastic_block_store_volumes.png)

Sul volume trovato eseguiamo:

Action -> Modify Volume

E cambiamo la dimensione da "10" a "12". In questo modo ampliamo dai 10G di default a 12G.

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/09_fig04-aws_EC2_resize_volume.png)

> Attenzione:
> Questa procedura a volte richiede del tempo prima che le modifiche diventino effettive e questo può trarre in inganno e far pensare che non abbia funzionato. 
> Se ci riproviamo riceviamo un messaggio di errore che ci depista e ci fa pensare che non sia possibile fare in questo modo. 
> Ma se si ha la pazienza di aspettare, a volte anche parecchi minuti, allora si vedrà che funziona.






## Esempio

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





---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/08-gemfile_ruby_version)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/02-git/01-git_story.md)
