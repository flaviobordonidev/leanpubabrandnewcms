# <a name="top"></a> Cap 4.6 - Table polymorphic

Rendiamo polimorfica la tabella "telephone".



## Branch

continuiamo con il branch aperto precedentemente



## Cos'è la tabella polimorfica e che vantaggi da

Il termine di "tabella polimorfica" è improprio. Si dovrebbe parlare di tabella con relazione polimorfica.
La tabella con relazione polimorfica è una tabella che "adatta" la sua relazione uno-a-molti in modo da andar bene per varie tabelle collegate.

- "poli"    : molte
- "morphos" : cambia forma, si adatta

La tabella polimorfica è una struttura implementata in Rails che tiene in automatico traccia delle chiavi esterne alle varie tabelle attraverso la definizione nel Model.
La tabella polimorfica ci permette di essere usata con relazioni uno-a-molti da molte altre tabelle senza dover aggiungere ogni volta una nuova chiave esterna e ci evita di avere una tabella piena di campi vuoti.

Per capire meglio i vantaggi della tabella polimorfica facciamo un esempio.

La tabella "telephone" con relazioni uno-a-molit ad Aziende, Persone, Offerte, Ordini e Banche

Nome        | numero        | company_id | person_id | offer_id | order_id | bank_id
| :--       | :--           | :--        | :--       | :--      | :--      | :--
centralino  | 06123456789   | 4156       |           |          |          |      
cellulare   | 34976337652   |            | 7346      |          |          |      
ufficio     | 02976337652   |            | 9374      |          |          |      
ufficio     | 02976337652   |            |           | 3918     |          |      
ufficio     | 02976337652   |            |           |          |          | 1517 
ufficio     | 02976337652   |            |           |          | 5182     |      
ufficio     | 02976337652   | 7283       |           |          |          |      



La tabella "telephone" con relazione polimorfica ad Aziende, Persone, Offerte, Ordini e Banche

Nome        | numero        | record_id | table_name
| :--       | :--           | :--        | :--
centralino  | 06123456789   | 4156      | company
cellulare   | 34976337652   | 7346      | person
ufficio     | 02976337652   | 9374      | person
ufficio     | 02976337652   | 3918      | offer 
ufficio     | 02976337652   | 1517      | bank  
ufficio     | 02976337652   | 5182      | order 
ufficio     | 02976337652   | 7283      | company


Come si può vedere da queste due tabelle, la relazione polimorfica ci evita di dover aggiungere una nuova colonna con chiave esterna per ogni nuova tabella uno-a-molti che aggiungiamo. Inoltre le colonne delle chiavi esterne della tabella senza relazione polimorfica, sono tutte riempite parzialmente. Questo lo evitiamo con la relazione polimorfica.




## Svuotiamo la tabelle telephone

Cancelliamo i records che abbiamo inserito precedentemente.

```ruby
$ rails console
> Telephone.destroy_all
```


> Nota: `.destroy_all` checks dependencies and callbacks, and takes a little longer. <br/>
> Per saltare i controlli e le dipendenze si può usare `.delete_all` che è una *straight SQL query* più veloce ma più "rischiosa".

Questa soluzione resetta l'intera tabella (resets the table entries), ma non resetta al *primary key*.
Se vogliamo che la *primary key* ricominci di nuovo da 1 dobbiamo aggiungere il comando:

```ruby
> ActiveRecord::Base.connection.reset_pk_sequence!('telephones')
```

> In alternativa si poteva usare `> Telephone.connection.execute('delete from telephones')`.


Per verificare possiamo vedere tutti i records e crearne uno nuovo per vedere che "id" è assegnato.

```ruby
$ rails console
> Telephone.all
> Telephone.new(company_id: 1, number: "unoduetre").save
> Telephone.all
```



## Rendiamo polimorfica la tabella telephones

Eliminiamo la colonna della chiave esterna ed aggiungiamo i due campi per il polimorfismo:

Colonna name:type         | Descrizione
| :--                     | :--
telephoneable_id:integer  | per la chiave esterna (lato molti della relazione uno-a-molti)
telephoneable_type:string | per identificare la tabella esterna 

Nota: per i nomi delle due colonne polimorfiche si può usare qualsiasi nome ma è un *"best-practise"* (quasi una **convenzione**) aggiungere il suffisso `"able"` al nome della tabella al singolare (ossia al ***nome del Model**).


Generiamo il migrate per eliminare la colonna della chiave esterna 

```bash
$ rails g migration RemoveCompanyIdFieldFromTelephones company_id:integer
```

vediamo il migrate generato

***code 01 - .../db/migrate/xxx_remove_company_id_field_from_telephones.rb - line:01***

```ruby
class RemoveCompanyIdFieldFromTelephones < ActiveRecord::Migration[6.0]
  def change

    remove_column :telephones, :company_id, :integer
  end
end
```

[tutto il codice](#01-08-01_01all)

eseguiamo il migrate

```bash
$ sudo service postgresql start
$ rails db:migrate
```

Come possiamo vedere nel db/schema.rb è stato rimosso anche l'indice.


Generiamo il migrate per aggiungere le due colonne per il polimorfismo

```bash
$ rails g migration AddPolimorphicColumnsToTelephones telephoneable_id:integer telephoneable_type:string
```

vediamo il migrate generato

***code 02 - .../db/migrate/xxx_add_polimorphic_columns_to_telephones.rb - line:01***

```ruby
class AddPolimorphicColumnsToTelephones < ActiveRecord::Migration[6.0]
  def change
    add_column :telephones, :telephoneable_id, :integer
    add_column :telephones, :telephoneable_type, :string
  end
end
```

[tutto il codice](#01-08-01_01all)


******************************************************************
NOTA / APPUNTO / TODO: Verifichiamo se è bene aggiungere un index 
******************************************************************


eseguiamo il migrate

```bash
$ sudo service postgresql start
$ rails db:migrate
```



## Creiamo le associazioni polimorfiche ed aggiungiamo il nested models per i forms annidati

Nel model `Telephone` su *# == Relationships*, togliamo la relazione `belongs_to :company` ed aggiungiamo la relazione polimorfica.

***code 03 - .../app/models/telephone.rb - line:13***

```ruby
  ## polymorphic
  belongs_to :telephoneable, polymorphic: true
```

[tutto il codice](#01-08-01_01all)


Nel model `Company` su *# == Relationships*, togliamo la relazione diretta a `telephones` ed aggiungiamo la relazione polimorfica.

La relazione polimorfica semplice sarebbe

***code n/a - .../app/models/company.rb - line:13***

```ruby
  ## polymorphic
  has_many :telephones, as: :telephoneable
```

Rispetto alla relazione uno-a-molti semplice aggiungiamo il parametro `, as: :telephoneable`.

Siccome noi abbiamo una relazione per nested forms la relazione diventa

***code 04 - .../app/models/company.rb - line:13***

```ruby
  ## nested-forms + polymorphic
  has_many :telephones, dependent: :destroy, as: :telephoneable
  accepts_nested_attributes_for :telephones, allow_destroy: true, reject_if: proc{ |attr| attr['number'].blank? }
```



## Proviamo l'associazione polimorfica

Usiamo la tabella telephones per dare due numeri di telefono alla prima azienda. 

- Inseriamo il centralino 023459876 alla prima azienda.
- Inseriamo il fax 023459871 alla prima azienda.

```ruby
$ rails c
> c = Company.first
> Telephone.all
> c.telephones.new(name: "centralino", number: "023459876").save
> c.telephones
> Telephone.all
> ct1 = c.telephones.last
> ct2 = c.telephones.new(name: "fax", number: "023459871")
> c.telephones
> Telephone.all
> ct2.save
> c.telephones
> Telephone.all
```

Per vedere l'altro lato dell'associazione non possiamo chiamare "ct1.company" perché sono creati dinamicamente a partire dalla stessa tabella polimorfica "telephonable". Invece possiamo chiamare:

```ruby
> ct1.company --> ERROR
> ct1.telephoneable
> ct2.telephoneable
```

Dal punto di vista del polimorfismo abbiamo finito.



## Aggiorniamo Controller

non c'è necessità di nessun aggiornamento.



## Aggiorniamo le Views

non c'è necessità di nessun aggiornamento



## Verifichiamo preview

Vediamo la nostra applicazione rails funzionante. Attiviamo il webserver

```bash
$ sudo service postgresql start
$ rails s
```

e vediamo sul nostro browser:

- https://mycloud9path.amazonaws.com
- https://mycloud9path.amazonaws.com/companies

Andiamo su edit dell'azienda con id 1 e vediamo che ha i due numeri di telefono. Possiamo inserirne di nuovi e cancellarne di esistenti.
Funziona tutto.



## Salviamo su Git

```bash
$ git add -A
$ git commit -m "Implement polymorphic telephonable"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku tei:master
$ heroku run rails db:migrate
```



## Chiudiamo il branch

Se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout master
$ git merge tei
$ git branch -d tei
```



## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin master
```
