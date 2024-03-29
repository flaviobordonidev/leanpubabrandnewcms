# <a name="top"></a> Cap 1.3 - Git clone

Importiamo il repository "bl6_0" che abbiamo sul nostro GitHub. 

Se è sul GitHub di un altro utente dobbiamo fare prima il fork per averne una copia sul nostro GitHub?
NO. non serve fare il fork. Possiamo anche fare il clone dal repository di un'altro utente.
(per approfondimenti vedi: 99-code_references/git_github/12_00-connect_a_cloned_app-it)



## Riferimenti interni:

- [99-rails_references/git_github/git-ssh-keys.txt]()



## Colleghiamoci a GitHub

Per lanciare git clone dobbiamo prima collegarci a gitHub. Per prima cosa logghiamoci su Github (www.github.com).



### Verifichiamo la chiave pubblica

Per far comunicare Github con aws Cloud9 dobbiamo fargli condividere la chiave pubblica.
Andiamo sul terminale di aws Cloud9 e visualizziamo e copiamoci la chiave pubblica (public key) di aws Cloud9.

```bash
$ cat ~/.ssh/id_rsa.pub


ubuntu:~/environment $ cat ~/.ssh/id_rsa.pub
cat: /home/ubuntu/.ssh/id_rsa.pub: No such file or directory
ubuntu:~/environment $ 
```

Non abbiamo chiave pubblica



### Generiamo la chiave pubblica

Se non è già presente possiamo crearla.
Quando richiesto premiamo [ENTER] senza inserire nessun valore; questo prende i valori di default. 

```bash
$ ssh-keygen -t rsa -b 4096 -C "flavio.bordoni.dev@gmail.com"
-> [ENTER]
-> [ENTER]
-> [ENTER]

user_fb:~/environment $ ssh-keygen -t rsa -b 4096 -C "flavio.bordoni.dev@gmail.com"
Generating public/private rsa key pair.
Enter file in which to save the key (/home/ubuntu/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/ubuntu/.ssh/id_rsa.
Your public key has been saved in /home/ubuntu/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:k6vKvlCb/+NHuIEgWIWhdGs6giIl6NrNy7bjLD+Nx4M flavio.bordoni.dev@gmail.com
The key's randomart image is:
+---[RSA 4096]----+
| ..=.            |
|o.+ .            |
|+o.o             |
|+o+ .    .       |
|=+ ... .S.       |
|=..+ o. oo.      |
|. o ==  .+       |
|  .=Eo=.o .      |
|   *%Bo+oo       |
+----[SHA256]-----+
user_fb:~/environment $
```



### Passiamo la chiave pubblica da environment awsC9 a gitHub

Per far comunicare Github con aws Cloud9 dobbiamo fargli condividere la chiave pubblica.
Andiamo sul terminale di aws Cloud9 e visualizziamo e copiamoci la chiave pubblica (public key) di aws Cloud9.

```bash
$ cat ~/.ssh/id_rsa.pub


ubuntu:~/environment $ cat ~/.ssh/id_rsa.pub
ssh-rsa AAAAB3...[...]...xhUwU/K0waOEnEE9YRSEQ== flavio.bordoni.dev@gmail.com
```

Copiamo tutta la chiave pubblica, compreso 'ssh-rsa', e passiamola su Github -> Settings -> SSH and GPG keys.

Title   : awsC9-angletheme
Key     : ssh-rsa AAAAB3...[...]...xhUwU/K0waOEnEE9YRSEQ== flavio.bordoni.dev@gmail.com



## Cloniamo il repository

Adesso che siamo collegati con GitHub possiamo clonare uno dei nostri repository.

Prendiamo il riferimento del nostro repository "bl6_0" cliccando sul bottone "Clone or Download"

```bash
git@github.com:flaviobordonidev/bl6_0.git
```

e lo usiamo sul nostro terminale di awsC9

```bash
$ git clone git@github.com:flaviobordonidev/bl6_0.git
-> yes

user_fb:~/environment $ git clone git@github.com:flaviobordonidev/bl6_0.git
Cloning into 'bl6_0'...
The authenticity of host 'github.com (140.82.113.3)' cannot be established.
RSA key fingerprint is SHA256:nGhbs6kYUpJRGl7E3IGODspIntTxdDAVDviKw6E5SY8.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'github.com,140.82.113.3' (RSA) to the list of known hosts.
remote: Enumerating objects: 929, done.
remote: Counting objects: 100% (929/929), done.
remote: Compressing objects: 100% (556/556), done.
remote: Total 929 (delta 563), reused 692 (delta 331), pack-reused 0
Receiving objects: 100% (929/929), 258.87 KiB | 9.59 MiB/s, done.
Resolving deltas: 100% (563/563), done.
user_fb:~/environment $ 
```

Non è necessario usare "ssh://" perché di default GitHub usa ssh. Se volevamo usarlo il comando sarebbe stato "$ git clone ssh://git@github.com:flaviobordonidev/bl6_0.git"



## Entriamo nel repository clonato

```bash
$ cd bl6_0
```

Abbiamo tutto il codice dell'applicazione ma non abbiamo tutto l'ambiente pronto. Verifichiamo provando a lanciare il web server:

```bash
$ rails s


user_fb:~/environment/bl6_0 (master) $ rails s
Could not find proper version of railties (6.0.0) in any of the sources
Run `bundle install` to install missing gems.
user_fb:~/environment/bl6_0 (master) $ 
```

Nei prossimi capitoli ripristiniamo l'ambiente (come ad esempio postgreSQL, minimagic, i dati nel database,...).
