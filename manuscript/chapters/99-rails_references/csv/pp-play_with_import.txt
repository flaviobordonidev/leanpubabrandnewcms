# Analizziamo alcuni modi di importare il file CSV sul database


{title="models/transaction.rb", lang=ruby, line-numbers=on, starting-line-number=3}
~~~~~~~~
# setter method (serve self perché va a scrivere nel db)(non creo il getter method)
def self.import
  CSV.foreach("public/transactions.txt", col_sep: ';') do |row|
    p = Transaction.new
    p.timestamp = row[0]
    p.id_check = row[1]
    p.var1 = row[2]
    p.var2 = row[3]
    p.kind = row[4]
    p.verify = row[5]
    p.cents = row[6]
    p.people_name = row[7]
    p.people_email = row[8]
    p.var3 = row[9]
    p.save
  end
end
~~~~~~~~

Questo funziona! se premiamo il link "Import" vediamo popolarsi la tabella con i dati presenti nel file transactions.txt ma c'è un problema. Non controlla gli "id" e quindi se premo di nuovo il link "Import" tutti i records mi vengono duplicati ed accodati in tabella.




## Controllo dei records

aggiorniamo il codice in modo da:
1. creare un nuovo record se l'"id" non è presente
2. aggiornare il record esistente se l'"id" è presente.

In questa prima soluzione creiamo un if che verifica id_check perché l'id sarà diverso se ho cancellato dei records visto che cresce sempre. Se non trovo un record che ha l'id_check allora lavoro come fatto nel paragrafo precedente.
Se invece trovo un record con id_check allora faccio un update. Siccome id_check non ha la proprietà che deve essere un file unico il risultato di Payment.where(...) mi da un array di records, che nel nostro caso ha un solo elemento. Quindi per settare i valori sono costretto a selezionare il primo elemento dell'array (che in realtà è anche l'unico) con p[0].

{title="models/payment.rb", lang=ruby, line-numbers=on, starting-line-number=3}
~~~~~~~~
def self.import
  CSV.foreach("lib/tasks/transactions.txt", col_sep: ';') do |row|
    if Payment.where(id_check: row[1].to_i).blank?
      p = Payment.new
      p.id = row[1]
      p.timestamp = row[0]
      p.id_check = row[1]
      p.var1 = row[2]
      p.var2 = row[3]
      p.kind = row[4]
      p.verify = row[5]
      p.cents = row[6]
      p.people_name = row[7]
      p.people_email = row[8]
      p.var3 = row[9]
      p.save
    else
      p = Payment.where(id_check: row[1].to_i)
      p[0].timestamp = row[0]
      p[0].id_check = row[1]
      p[0].var1 = row[2]
      p[0].var2 = row[3]
      p[0].kind = row[4]
      p[0].verify = row[5]
      p[0].cents = row[6]
      p[0].people_name = row[7]
      p[0].people_email = row[8]
      p[0].var3 = row[9]
      p[0].save
    end
  end
end
~~~~~~~~

Potrei dare il valore di unicità al database ad id_check facendo un migration di modifica ma preferisco una soluzione differente. 
Chi l'ha detto che id è intoccabile?
La soluzione è semplice come l'uovo di Colombo. 
Invece di lasciare assegnare l'id dei records in automatico dal contatore di rails setto il valore dell'id con quello di id_check. 
L'unico rischio è quello di generare un'errore se il mio file txt ha due id_check identici.

{title="models/payment.rb", lang=ruby, line-numbers=on, starting-line-number=3}
~~~~~~~~
# setter method (serve self perché va a scrivere nel db)(non creo il getter method)
def self.import
  CSV.foreach("lib/tasks/transactions.txt", col_sep: ';') do |row|
    p = Payment.where(id: row[1].to_i).blank? ? Payment.new : Payment.find(row[1].to_i)
    p.id = row[1]
    p.timestamp = row[0]
    p.id_check = row[1]
    p.var1 = row[2]
    p.var2 = row[3]
    p.kind = row[4]
    p.verify = row[5]
    p.cents = row[6]
    p.people_name = row[7]
    p.people_email = row[8]
    p.var3 = row[9]
    p.save
  end
end
~~~~~~~~

Invece dell'if esplicito uso l'operatore ternario (value = condition ? true : false) perché non ho più necessità di fare due associazioni differenti. Non devo più usare p[0] per l'update perché "id" tratta solo valori univoci e quindi il Payment.where(...) mi da come risultato un solo record e non un'array.

Siccome usiamo l'"id" perché non abbiamo usato Payment.find(...).blank? ?
Non lo ho usato perché se il .find non trova un record mi genera un'errore invece il .where mi da False e lo posso usare come condizione nell'operatore ternario. Il Payment.find(...) l'ho usato quando ho la certezza che c'è un record perché Payment.where(...).blank = False. 



# Dopo l'uovo di colombo...

Se voglio importare più files CSV nella stessa tabella l'uovo di colombo visto sopra va a farsi friggere ^_^
Riprendiamo quindi l'esempio prima dell'uovo e facciamo una piccola modifica

{title="models/payment.rb", lang=ruby, line-numbers=on, starting-line-number=3}
~~~~~~~~
def self.import(filecsvname)

  CSV.foreach("lib/tasks/filecsvname", col_sep: ';') do |row|
    
    # se nel mio database non ho ancora mai importato questo file CSV
    if Payment.where(kioskfilecsvname: filecsvname).blank?
      
      #
      #vda sviluppare
      #
    
      if Payment.where(id_check: row[1].to_i).blank?
        p = Payment.new
        p.id = row[1]
        p.timestamp = row[0]
        p.id_check = row[1]
        p.var1 = row[2]
        p.var2 = row[3]
        p.kind = row[4]
        p.verify = row[5]
        p.cents = row[6]
        p.people_name = row[7]
        p.people_email = row[8]
        p.var3 = row[9]
        p.save
      else
        p = Payment.where(id_check: row[1].to_i)
        p[0].timestamp = row[0]
        p[0].id_check = row[1]
        p[0].var1 = row[2]
        p[0].var2 = row[3]
        p[0].kind = row[4]
        p[0].verify = row[5]
        p[0].cents = row[6]
        p[0].people_name = row[7]
        p[0].people_email = row[8]
        p[0].var3 = row[9]
        p[0].save
      end
    end
      
  end
end
~~~~~~~~








# Controlliamo eventuali errori

Adesso implementiamo anche due controlli su eventuali errori nel file txt che viene passato.
1. Se le righe non hanno un check_id che cresce linearmente alzo un'errore (raise ...) (Nell'applicativo reale andrebbe gestito l'errore) (Questo controllo mi verifica anche l'id_check duplicato)
2. Se ho più record nel database delle righe nel file txt alzo un'errore


{title="models/payment.rb", lang=ruby, line-numbers=on, starting-line-number=3}
~~~~~~~~
# setter method (serve self perché va a scrivere nel db)(non creo il getter method)
def self.import
  i = 0
  CSV.foreach("lib/tasks/transactions.txt", col_sep: ';') do |row|
    i = i+1

    if i != row[1].to_i
      raise "c'è un salto nel file txt"
    end

    p = Payment.where(id: row[1].to_i).blank? ? Payment.new : Payment.find(row[1].to_i)
    p.id = row[1]
    p.timestamp = row[0]
    p.id_check = row[1]
    p.var1 = row[2]
    p.var2 = row[3]
    p.kind = row[4]
    p.verify = row[5]
    p.cents = row[6]
    p.people_name = row[7]
    p.people_email = row[8]
    p.var3 = row[9]
    p.save
  end

  if i != Payment.all.size
    raise "nel database ci sono più record che nel file txt"
  end

end
~~~~~~~~

Per il momento è tutto! Alla prossima.
