# Superuser su aws cloud9

Risorse web

* https://aws.amazon.com/it/premiumsupport/knowledge-center/set-change-root-linux/


## Diventare superuser

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo su

cloud9:~/environment/rigenerabatterie (au) $ sudo su
[root@ip-172-31-7-7 rigenerabatterie]# 
[root@ip-172-31-7-7 rigenerabatterie]# exit
exit
~~~~~~~~




## Creiamo password temporanea per superuser

Create a password for the root user by running the following command:

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo su
# passwd root
~~~~~~~~

When prompted, enter your temporary root password, and then enter it again to confirm it.
Note: You must run this command as the root user.

After you complete the task, delete the root password by running the following command:


{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo su
# passwd –d root
~~~~~~~~
