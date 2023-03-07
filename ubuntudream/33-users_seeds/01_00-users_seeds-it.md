# <a name="top"></a> Cap 33.1 - Users seeds

Popoliamo la tabella `users` tramite seeds.
La tabella `users` ha una difficoltà nell'essere popolata che è quella del campo `password` perché viene archiviato criptato.



## Risorse interne

- [code_references/active_record-seeds]()



## Risorse esterne

- []()





## Aggiungiamo un utente da console

Aggiungiamo un utente usando la `$ rails console`.

> Impostiamo la modalità con *skipp* della `confirmation` in modo da avere dei seeds che vanno bene sia se nel **model** l'opzione `:confirmable` è disattivata, sia se è attivata. 


```ruby
$ rails c
> u = User.new(username: 'Ann', email: 'ann@test.abc', password: 'passworda', password_confirmation: 'passworda')
> u.skip_confirmation!
> u.save
```


## Aggiungiamo un utente da migration

> si può fare un migration ed immettere le righe sopra
> Non mi piace come approccio essendoci i seeds che sono dedicati a popolare le tabelle


## Aggiungiamo un utente da seeds

To add initial data after a database is created, Rails has a built-in 'seeds' feature that speeds up the process. This is especially useful when reloading the database frequently in development and test environments. To get started with this feature, fill up `db/seeds.rb` with some Ruby code, and run `bin/rails db:seed`.

In pratica possiamo considerare il file `db/seeds.rb` come un elenco di comandi di console eseguiti uno di seguito all'altro. quindi basta ripetere la stessa sequenza di comandi fatta a console.

***Codice 01 - .../db/seeds.rb - linea:1***

```ruby
#User.destroy_all
#puts "setting the User data with I18n :it, :en, :pt"
puts "Zack user with 'bio' I18n :it, :en, :pt"
I18n.locale = :it
u = User.new(username: 'Zack', email: 'zack@test.abc', password: 'passwordz', password_confirmation: 'passwordz', bio: 'Questa è la mia biografia in italiano.')
u.skip_confirmation!
u.save
I18n.locale = :en
User.where(username: 'Zack').update(bio: 'This is my biography in english.')
I18n.locale = :pt
User.where(username: 'Zack').update(bio: 'Esta é a minha biografia em português.')
```


Adesso da terminale esegui il comando:

```bash
$ rails db:seed
```




## Initial seed

```ruby
User.find_or_create_by!(email: 'admin@example.com') do |user|
  user.password = "12345678"
  user.password_confirmation = "12345678"
end if Rails.env.development?
```
