Creazione Nuove Utente 

L'inserimento di un nuovo utente va effettuato tramite rails console con i comandi che effettuarenno l'append del nuovo record direttamente sulla tabella users. Si possono usare entrambi i metodi portati ad esempio qui di seguito: 

$ sudo service postgresql start

$ rails c 

Metodo 1
> User.new({email: 'donazioni@duomomilano.it', password: 'D*****@2017', password_confirmation: 'D*****@2017'}).save

Metodo 2
> u = User.new({email: 'donazioni@duomomilano.it', password: 'D*****@2017', password_confirmation: 'D*****@2017'})
> u.save

Una volta creato il nuovo record, per aggiungerlo nel menù a cascata dell'home page e permettere all'amministratore di vedere tutti i kiosk inseriti, e filtrare le transazioni relative, bisogna inserire il seguente blocco comandi nel file homepage_controller.rb, come di seguito mostrato:

# Save the Children: 2
    when "user@mail.com"
      @company_name = "Save the Children"
      @kiosks = Company.find(2).kiosks
      
Come dopo ogni aggiunta o cambio di codice, dobbiamo caricare le modifiche su Git e poi inviarle in produzione su Heroku.      
