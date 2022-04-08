# Rake db:migrate -- Rake db:rollback 



## Per eseguire tutti i migrations

Risorse sul web:
  * http://stackoverflow.com/questions/23278880/would-i-need-to-undo-a-rails-generate-scaffold-after-i-undo-a-dbmigrate


title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rake db:migrate
~~~~~~~~




# Per tornare indietro dell'ultimo migration:

title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rake db:rollback
~~~~~~~~

per tornare indietro di tre migrations basta eseguire tre rollbacks:

title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rake db:rollback
$ rake db:rollback
$ rake db:rollback
~~~~~~~~

si possono poi cancellare gli ultimi 3 file di migrations.


Se si era usato lo scaffold

title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails g scaffold Company name:string sector:string status:string memo:text
~~~~~~~~

Si può effettuare l'undo dell'intero scaffold

title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails destroy scaffold Company name:string sector:string status:string memo:text
~~~~~~~~

o più semplicemente

title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails destroy scaffold Company
~~~~~~~~