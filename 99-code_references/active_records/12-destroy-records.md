# Eliminiamo i records

Preferisco usare "destroy" a "delete" perché lavora a livello di Model e fa le chiamate alle callbacks :before_destroy and :after_destroy. Dalla sua, "delete" è più veloce.




## Eliminare un singolo record

~~~~~~~~
u = User.where(email: "abc@xyz.com").first
u.destroy
~~~~~~~~



## Eliminare più records

~~~~~~~~
user.destroy #won't work if User model has no primary key 
User.find(15).destroy
User.destroy(15)
User.where(age: 20).destroy_all
User.destroy_all(age: 20) #deprecated in Rails 5.1
~~~~~~~~

destroy_all with conditions has been deprecated in Rails 5.1 




## Esempio 1 - Donamat. Eliminiamo transazioni con errori

Eliminiamo tutti i records che hanno una transazione con errore di pagamento da tutta la tabella

~~~~~~~~
$ rails c
-> Transaction.where(payment_check: "PAYMENT_ERROR").size
-> Transaction.where(payment_check: "PAYMENT_ERROR").destroy_all
~~~~~~~~

Eliminiamo tutti i records che hanno una transazione con errore di pagamento per uno specifico kiosk

~~~~~~~~
$ rails c
-> k = Kiosk.first
-> k.transactions.where(payment_check: "PAYMENT_ERROR").destroy_all
~~~~~~~~
