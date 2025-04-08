# <a name="top"></a> Cap 6.1 - Table likes polymorphic

Tratto da mix_and_go. Un clone di instagram.
Esercizio di likes polimorfico per articoli e commenti.



## Risorse interne

- [code_references/active_record-associations/09-polymorphic]()



## Risorse esterne

- [Esercizio di mixandgo](https://school.mixandgo.com/targets/262)



## Polimorphic liking

rendiamo polimorfica la tabella "likes".

La tabella "likes" con relazioni uno-a-molit ad articoli (posts) e commenti (comments).

Nome        | numero        | post_id    | comment_id
| :--       | :--           | :--        | :--
centralino  | 06123456789   | 4156       |          
cellulare   | 34976337652   |            | 7346     
ufficio     | 02976337652   |            | 9374     
ufficio     | 02976337652   | 5472       |          
ufficio     | 02976337652   |            | 9471         
ufficio     | 02976337652   |            | 9473     
ufficio     | 02976337652   | 7283       |          


La tabella "likes" con relazione polimorfica ad articoli (posts) e commenti (comments).

Nome        | numero        | record_id | table_name
| :--       | :--           | :--       | :--
centralino  | 06123456789   | 4156      | posts
cellulare   | 34976337652   | 7346      | comments
ufficio     | 02976337652   | 9374      | comments
ufficio     | 02976337652   | 5472      | posts
ufficio     | 02976337652   | 9471      | comments
ufficio     | 02976337652   | 9473      | comments
ufficio     | 02976337652   | 7283      | posts



## Svuotiamo la tabella likes

Cancelliamo i records che abbiamo inserito precedentemente.

```ruby
$ rails console
> Like.destroy_all
```

> Nota: `.destroy_all` checks dependencies and callbacks, and takes a little longer. <br/>
> Per saltare i controlli e le dipendenze si può usare `.delete_all` che è una *straight SQL query* più veloce ma più "rischiosa".


Se vogliamo che la *"primary key"* ricominci di nuovo da 1 dobbiamo:

```ruby
> ActiveRecord::Base.connection.reset_pk_sequence!('likes')
```

> In alternativa si poteva usare `> Like.connection.execute('delete from likes')`.



## Rendiamo polimorfica la tabella likes

Eliminiamo la colonna della chiave esterna ed aggiungiamo i due campi per il polimorfismo:

Colonna name:type     | Descrizione
| :--                 | :--
likeable_id:integer   | per la chiave esterna (lato molti della relazione uno-a-molti)
likeable_type:string  | per identificare la tabella esterna 

Nota: per i nomi delle due colonne polimorfiche si può usare qualsiasi nome ma è un *"best-practise"* (quasi una **convenzione**) aggiungere il suffisso `"able"` al nome della tabella al singolare (ossia al ***nome del Model**).


Generiamo il migrate per eliminare la colonna della chiave esterna 

```bash
$ rails g migration RemovePostIdFieldFromLikes post_id:integer
```

vediamo il migrate generato

***code 01 - .../db/migrate/xxx_remove_post_id_field_from_likes.rb - line:01***

```ruby
class RemovePostIdFieldFromLikes < ActiveRecord::Migration[7.0]
  def change
    remove_column :likes, :post_id, :integer
  end
end
```

[tutto il codice](#01-08-01_01all)

eseguiamo il migrate

```bash
$ rails db:migrate
```

Come possiamo vedere nel db/schema.rb è stato rimosso anche l'indice.


Generiamo il migrate per aggiungere le due colonne per il polimorfismo

```bash
$ rails g migration AddPolymorphicColumnsToLikes likeable_id:integer likeable_type:string
```

vediamo il migrate generato

***code 02 - .../db/migrate/xxx_add_polimorphic_columns_to_telephones.rb - line:01***

```ruby
class AddPolymorphicColumnsToLikes < ActiveRecord::Migration[7.0]
  def change
    add_column :likes, :likeable_id, :integer
    add_column :likes, :likeable_type, :string
  end
end
```

[tutto il codice](#01-08-01_01all)


******************************************************************
NOTA / APPUNTO / TODO: Verifichiamo se è bene aggiungere un index 
******************************************************************


eseguiamo il migrate

```bash
$ rails db:migrate
```



## Creiamo le associazioni polimorfiche

Nel model `Like` su *# == Relationships*, togliamo la relazione `belongs_to :post` ed aggiungiamo la relazione polimorfica.

***code 03 - .../app/models/like.rb - line:13***

```ruby
  ## polymorphic
  belongs_to :likeable, polymorphic: true
```

[tutto il codice](#01-08-01_01all)


Nel model `Post` su *# == Relationships*, togliamo la relazione diretta a `likes` ed aggiungiamo la relazione polimorfica.

La relazione polimorfica semplice sarebbe

***code n/a - .../app/models/post.rb - line:13***

```ruby
  ## polymorphic
  has_many :likes, as: :likeable
```

Rispetto alla relazione uno-a-molti semplice aggiungiamo il parametro `, as: :likeable`.

Siccome noi abbiamo una relazione per nested forms la relazione diventa

***code 04 - .../app/models/post.rb - line:13***

```ruby
  ## polymorphic + nested-forms
  has_many :likes, dependent: :destroy, as: :likeable
  #accepts_nested_attributes_for :likes, allow_destroy: true, reject_if: proc{ |attr| attr['number'].blank? }
```



## Proviamo l'associazione polimorfica

Usiamo la tabella `likes` per dare due likes al primo post e al primo commento. 

```ruby
$ rails c
> p1 = Post.first
> p1.likes
> p1.likes.create #oppure p1.likes.new.save
> p1.likes

> c1 = p1.comments.first #perché Comment è annidato a Post
> c1.likes
> c1.likes.create
> c1.likes

# mettiamo il primo like del commento su una variabile e navighiamo al contrario
> like_c1 = c1.likes.first
> like_c1.comment #=> ERROR
> like_c1.likeable #=> il commento su cui ho creato il like
> like_c1.likeable.post #=> il post a cui appartiene il commento
> like_p1 = p1.likes.first
> like_p1.post #=> ERROR
> like_p1.likeable #=> il post su cui ho creato il like
> like_p1.likeable.comments #=> tutti i commenti di quel post
```

> Per vedere l'altro lato dell'associazione **non** possiamo chiamare `like_c1.comment` perché i likes sono nelle due *"colonne polimorfiche"* della tabella `likes` e queste possono riferirsi a diverse tabelle.Invece possiamo chiamare `like_c1.likeable` che ci restituisce l'altro lato dell'associazione. Nel nostro caso ci restituisce il `comment` su cui abbiamo creato il like.


Esempio

```ruby
3.1.1 :003 > p1 = Post.first
  Post Load (0.2ms)  SELECT "posts".* FROM "posts" ORDER BY "posts"."id" ASC LIMIT ?  [["LIMIT", 1]]
 => #<Post:0x00007fa5bb9d9618 id: 38, title: "Primo post", created_at: Sun, 11 Sep 2022 20:57:14.474264000 UTC +00:00, updated_at: Sun, 02 Oct 2022 19:59:54.515777000 UTC +00:00, user_id: 2> 
3.1.1 :004 > p1.likes
  Like Load (0.3ms)  SELECT "likes".* FROM "likes" WHERE "likes"."likeable_id" = ? AND "likes"."likeable_type" = ?  [["likeable_id", 38], ["likeable_type", "Post"]]
 => []                                                           
3.1.1 :005 > p1.likes.create
 => #<Like:0x00007fa5bb7a0c20 user_id: nil, likeable_id: 38, likeable_type: "Post"> 
3.1.1 :006 > p1.likes
 => [#<Like:0x00007fa5bb7a0c20 user_id: nil, likeable_id: 38, likeable_type: "Post">] 
3.1.1 :007 > 


3.1.1 :013 > c1 = p1.comments.first
 => 
#<Comment:0x00007fa5bb891be8                                                      
...                                                                               
3.1.1 :014 > c1
 => 
#<Comment:0x00007fa5bb891be8                                                      
 id: 2,                                     
 body: "This is my first comment",          
 user_id: 2,                                
 post_id: 38,                               
 created_at: Sun, 11 Sep 2022 21:03:01.086451000 UTC +00:00,
 updated_at: Sun, 11 Sep 2022 21:03:01.086451000 UTC +00:00> 
3.1.1 :015 > c1.likes
  Like Load (0.1ms)  SELECT "likes".* FROM "likes" WHERE "likes"."likeable_id" = ? AND "likes"."likeable_type" = ?  [["likeable_id", 2], ["likeable_type", "Comment"]]
 => []                                                    
3.1.1 :016 > c1.likes.create
 => #<Like:0x00007fa5bb781960 user_id: nil, likeable_id: 2, likeable_type: "Comment"> 
3.1.1 :017 > c1.likes
 => [#<Like:0x00007fa5bb781960 user_id: nil, likeable_id: 2, likeable_type: "Comment">] 
3.1.1 :018 > 

3.1.1 :021 > like_c1 = c1.likes.first
 => #<Like:0x00007fa5bb781960 user_id: nil, likeable_id: 2, likeable_type: "Comment"> 
3.1.1 :022 > like_c1.comment
/home/ubuntu/.rvm/gems/ruby-3.1.1/gems/activemodel-7.0.3.1/lib/active_model/attribute_methods.rb:458:in 'method_missing': undefined method 'comment' for #<Like user_id: nil, likeable_id: 2, likeable_type: "Comment"> (NoMethodError)
Did you mean?  committed!                                                      
3.1.1 :023 > like_c1.likeable
 => 
#<Comment:0x00007fa5bb891be8                                                   
 id: 2,                                                        
 body: "This is my first comment",                             
 user_id: 2,                                                   
 post_id: 38,                                                  
 created_at: Sun, 11 Sep 2022 21:03:01.086451000 UTC +00:00,   
 updated_at: Sun, 11 Sep 2022 21:03:01.086451000 UTC +00:00>   
3.1.1 :024 > like_c1.likeable.post
 => #<Post:0x00007fa5bb9d9618 id: 38, title: "Primo post", created_at: Sun, 11 Sep 2022 20:57:14.474264000 UTC +00:00, updated_at: Sun, 02 Oct 2022 19:59:54.515777000 UTC +00:00, user_id: 2> 
3.1.1 :025 > 
3.1.1 :026 > 
3.1.1 :027 > like_p1 = p1.likes.first
 => #<Like:0x00007fa5bb7a0c20 user_id: nil, likeable_id: 38, likeable_type: "Post"> 
3.1.1 :028 > like_p1.post
/home/ubuntu/.rvm/gems/ruby-3.1.1/gems/activemodel-7.0.3.1/lib/active_model/attribute_methods.rb:458:in 'method_missing': undefined method 'post' for #<Like user_id: nil, likeable_id: 38, likeable_type: "Post"> (NoMethodError)                                                           
3.1.1 :029 > like_p1.likeable
 => #<Post:0x00007fa5bb9d9618 id: 38, title: "Primo post", created_at: Sun, 11 Sep 2022 20:57:14.474264000 UTC +00:00, updated_at: Sun, 02 Oct 2022 19:59:54.515777000 UTC +00:00, user_id: 2> 
3.1.1 :030 > like_p1.likeable.comments
 => 
[#<Comment:0x00007fa5bb891be8                                                          
  id: 2,                                                                               
  body: "This is my first comment",                                                    
  user_id: 2,                                          
  post_id: 38,                                         
  created_at: Sun, 11 Sep 2022 21:03:01.086451000 UTC +00:00,
  updated_at: Sun, 11 Sep 2022 21:03:01.086451000 UTC +00:00>] 
3.1.1 :031 > 
```

Lato console abbiamo visto che la nostra associazione polimorfica funziona.
Nei prossimi capitoli la implementiamo nell'interfaccia grafica (views, controller e metodi).
