# Dynamic Finders Methods

Risorse web:

* [14 Dynamic Finders](http://guides.rubyonrails.org/active_record_querying.html)





Railcasts 415-upgrading-to-rails-4
Models: EpisodesController
  @episodes = Episode.published.find_all_by_pro(false) # DEPRECATED!
  -->
  @episodes = Episode.published.where(pro: false)




## Domanda su Stackoverflow

I have a database that has stored information of some users. I know for example: User.find(1) will return the user with id:1
What should I call to find a user by email? I searched a lot but could not find anything. I also tried User.find(:email => "xyz@abc.com") but it doesn't work.

Use

~~~~~~~~
User.find_by_email("abc@xyz.com")
~~~~~~~~

Oppure si può usare

~~~~~~~~
User.where(email: "abc@xyz.com").first
~~~~~~~~




## Esempio 1 - Donamat. Fare le somme dei pagamenti corretti divisi per contanti e pos

~~~~~~~~
     kiosk.tot_cash_cents = kiosk.transactions.where(payment_check: "PAYMENT_OK", cash_pos: "CASH").sum(:cents)
      kiosk.tot_pos_cents = kiosk.transactions.where(payment_check: "PAYMENT_OK", cash_pos: "POS").sum(:cents)
      #kiosk.tot_donations = kiosk.transactions.where(payment_check: "PAYMENT_OK").count
      kiosk.tot_donations = kiosk.transactions.where(payment_check: "PAYMENT_OK").size
~~~~~~~~

Per contare tutti i records è preferibile usare ".size" 