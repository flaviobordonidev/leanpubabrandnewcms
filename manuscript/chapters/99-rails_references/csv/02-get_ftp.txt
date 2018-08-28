# Leggiamo da un server FTP

Non facciamo la lettura direttamente sul server FTP ma ci scarichiamo il file in locale e poi lo leggiamo.

* http://ruby-doc.org/stdlib-1.9.3/libdoc/net/ftp/rdoc/Net/FTP.html#method-i-ls




## Carichiamo manualmente il file sul server FTP

Carichiamo manualmente il file transaction.txt su un server FTP usando un client FTP (es: fire-ftp).

!(rails c)[images/csv/02/fireftp.png]

Su fireFTP impostiamo

host: myhostname.com
login: myuser
password: ***

Con i valori inviati dal nostro web-host (es: Site5)

FTP Information
This login information can be used to connect to your account using your FTP app.

Domain Name: myhostname.com
Account IP: 134.104.52.8
Username: myuser
Password: mypassword




## Scarichiamo il file dal server FTP

Per scaricare i files da un server FTP usiamo la libreria di ruby net/ftp. Per attivarla la richiediamo sul file di configurazione a livello di applicazione.


[codice: config](#code-csv-02-config-01)

{title="config/application.rb", lang=ruby, line-numbers=on, starting-line-number=3}
~~~~~~~~
require 'net/ftp'
~~~~~~~~


Apriamo la console di rails e scarichiamo il file

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails c

> ftp = Net::FTP.new
> ftp.connect("myhostname.com",21)
> ftp.login("myuser","mypassword")
> ftp.chdir("/mydirectory")
> ftp.passive = true
> ftp.getbinaryfile("mysourcefile", "mydestfile")
> ftp.close
~~~~~~~~

oppure

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails c

> Net::FTP.open('myhostname.com') do |ftp|
>   ftp.login("myuser","mypassword")
>   ftp.chdir('/mydirectory')
>   ftp.getbinaryfile("mysourcefile", "mydestfile")
> end
~~~~~~~~




> ftp.connect("boutiquecampodifiori.com",21)
> ftp.login("boutiqu1","nSz0Yae46G")
> ftp.chdir("/tmp")
> ftp.passive = true
> ftp.getbinaryfile("transactions.txt", "public/transactions.txt")

!(rails c)[images/csv/02/ftp-getfile.png]

!(rails c)[images/csv/02/public-transactions.png]

mydirectory = tmp
mysourcefile = transactions.txt
mydestfile = public/transactions.txt


I> Su heroku è permesso scrivere nella directory /tmp/ ma tutte le volte che un dyno viene riavviato la cartella tmp/ viene cancellata.
I> questo vuol dire che c'è il rischio che il file venga cancellato mentre lo stiamo leggendo.
I>
I> su public non avviene il flush ma il file è visibile a tutto il web


* https://github.com/cburnette/boxr/issues/8
* https://www.quora.com/What-are-the-potential-downsides-of-using-Heroku




## Scarichiamo e leggiamo il file csv

dalla console di rails, scarichiamo e leggiamo il file

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails c

> ftp = Net::FTP.new
> ftp.connect("myhostname.com",21)
> ftp.login("myuser","mypassword")
> ftp.chdir("/tmp")
> ftp.passive = true
> ftp.getbinaryfile("transactions.txt", "public/transactions.txt")

> CSV.foreach("public/transactions.txt") do |row|
> puts row
> end
~~~~~~~~







## Carichiamo via Rails il file sul server FTP

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails c

> ftp = Net::FTP.new
> ftp.connect("myhostname.com",21)
> ftp.login("myuser","mypassword")
> ftp.chdir("/tmp")
> ftp.passive = true

> ftp.putbinaryfile("public/transactions.txt", "transactions2.txt")
~~~~~~~~
