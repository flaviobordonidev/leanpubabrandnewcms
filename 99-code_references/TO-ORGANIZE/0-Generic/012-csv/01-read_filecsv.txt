# Leggiamo file csv

Preparo una nuova applicazione "Rails References CSV" che legge dei file di testo separati dal punto e virgola ";"
E' quasi un file CSV (Comma Separated Values) solo che ho ";" invece di ","




## Creiamo nuova applicazione

vedi new_app_c9

{title="riassumendo", lang=bash, line-numbers=off}
~~~~~~~~
# c9-workspace "blank" 
$ gem install rails -v 5.0.0.1
$ rails _5.0.0.1_ new rr_csv
$ cd rr_csv
$ git init
$ git add -A
$ git commit -m "new rails app"
~~~~~~~~




## Attivo libreria ruby CSV

Per poter lavorare su file di testo di tipo CSV usiamo la libreria di ruby CSV. Per attivarla la richiediamo sul file  di configurazione a livello di applicazione.

[codice: config 01](#code-csv-01-config-01)

{title="config/application.rb", lang=ruby, line-numbers=on, starting-line-number=3}
~~~~~~~~
require 'csv'
~~~~~~~~


Copiamo il files transactions.txt su tmp. 

I> Attenzione! Su heroku i files tmp sono eliminati periodicamente (flush) quindi può accadere che una lettura non vada a buon fine perché il file è cancellato mentre lo si sta leggendo.
I>
I> Comunque questo è temporaneo perché poi andremo a leggere sul server ftp o su Amazon S3.

Leggiamo i files direttamente dalla console di rails

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails c

>> CSV.foreach("tmp/transactions.txt") do |row|
>* puts row
>> end
~~~~~~~~

Funziona! Riesco a leggere i files riga per riga

!(rails c)[images/csv/01/csv_foreach.png]