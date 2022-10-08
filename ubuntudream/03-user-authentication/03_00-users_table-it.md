# <a name="top"></a> Cap 8.2 - Users table

Vediamo tutte le colonne presenti nella tabella ed anche quelle virtuali presenti nel Model.



## Risorse interne

- [01-base/09-manage_users/02_00-users_protected-it.md - Working Around Rails 7’s Turbo]()
- [01-base/18-activestorage-filesupload/02_00-activestorage-install-it.md - Attiviamo upload immagine per il model eg_post]()
- [01-base/02-bootstrap/03-users_layout/03_00-users_add_fields_round_image-it.md - Aggiungiamo i campi Immagine e Bio agli utenti]()



## Aggiorniamo il Controller e le views

Avendo modificato ed aggiunto delle nuove colonne alla tabella users andiamo ad aggiornare il codice nel controller e nelle views.

***code 03 - .../app/controllers/users_controller.rb - line:85***

```ruby
    # Only allow a list of trusted parameters through.
    def user_params
      if params[:user][:password].blank?
        params.require(:user).permit(:username, :email, :language, :role, :profile_image, :first_name, :last_name, :location, :bio, :phone_number)
      else
        params.require(:user).permit(:username, :email, :password, :password_confirmation, :language, :role, :profile_image, :first_name, :last_name, :location, :bio, :phone_number)
      end
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/08-user/02_03-controllers-users_controller.rb)



[DAFA]



## I semi (*seeds*)

Prepariamo i "semi" per un inserimento dei records in automatico.

***code 05 - .../db/seeds.rb - line:29***

```ruby
puts "setting the first User data"
User.new(name: "View of mount Vermon", duration: 90).save
Lesson.last.steps.build(name: "Domanda1").save
Lesson.last.steps.build(name: "Domanda2").save

puts "setting the second Lesson and Steps data"
Lesson.new(name: "The island of death", duration: 90).save
Lesson.last.steps.build(name: "Domanda1").save
Lesson.last.steps.build(name: "Domanda2").save
```

Nel database di sviluppo (*development*) i records li inseriamo manualmente nel prossimo paragrafo.

> Per inserire i semi il comando è `$ rails db:seed`. Questo aggiunge i nuovi records dei *seeds* a quelli attualmente presenti in tabella.

> Nota: il comando `$ rails db:setup` svuota tutta la tabella prima di inserire i records dei *seeds*.



## Popoliamo manualmente le tabella del database di sviluppo

Usiamo la console di rails per popolare la tabella del database di sviluppo (*development*).

```bash
$ sudo service postgresql start
$ rails c

> Lesson.new(name: "View of mount Vermon", duration: 90).save
> Lesson.last.steps.new(question: "Domanda1", answer: "Risposta1").save
> Lesson.last.steps.new(question: "Domanda2", answer: "Risposta2").save

> Lesson.new(name: "The island of death", duration: 90).save
> Lesson.last.steps.new(question: "Come ti chiami?", answer: "Risposta1").save
> Lesson.last.steps.new(question: "Domanda2").save

> Lesson.all
> Step.all
> Lesson.first.steps
> Lesson.second.steps

> exit
```

Potreste trovare anche l'uso di `build` al posto di `new` nel creare collections. Questo aveva senso prima di Rails 3 ma da Rails 4 in poi è superato.

Esempio con uso di `build`

```bash
> Lesson.new(name: "The island of death", duration: 90).save
> Lesson.last.steps.build(question: "Domanda1").save
> Lesson.last.steps.build(question: "Domanda2").save
```


> Il metodo `build` è disponibile grazie all'associazione `has_many` che abbiamo definito nel modello *Lesson*. Questo ci consente di creare una *collection* di oggetti *steps* associati ad una specifica istanza di *lesson*, utilizzando la chiave esterna `lesson_id` che esiste nella tabella *steps*.

> `build` and `new` are **aliases** as defined in **ActiveRecord::Relation**.
> 
> So if class Foo has_many Bars, the following have identical effects: <br/>
> `foo.bars.new` <=> `foo.bars.build` <br/>
> `Bar.where(:foo_id=>foo.id).new` <=> `Bar.where(:foo_id=>foo.id).build` <br/>
> And `if !foo.new_record?` <br/>
> `foo.bars.new` <=> `Bar.where(:foo_id=>foo.id).new`
