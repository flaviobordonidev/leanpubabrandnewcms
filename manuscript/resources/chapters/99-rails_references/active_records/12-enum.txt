# Enum


Risorse interne:

* vedi 01-base/10-roles/03-roles-enum
* vedi 52-rebisworld/04-post_paragraphs-nested_forms/04-enum_paragraph_style
* vedi 99-rails_references/views/data_types/select-collection_select


Risorse web:

* [ActiveRecord::Enum](https://api.rubyonrails.org/v5.2.3/classes/ActiveRecord/Enum.html)
* [Enums with Rails & ActiveRecord: an improved way](https://sipsandbits.com/2018/04/30/using-database-native-enums-with-rails/)
* [QUERIES ON RAILS - SHOWCASING ACTIVE RECORD AND AREL](https://www.imaginarycloud.com/blog/queries-on-rails/)




## Esempi di query sfruttando enums


$ rails c
-> User.where(role: :admin)
-> User.admin
-> User.first.admin?

-> User.where(role: :author)
-> User.author
-> User.first.author?

-> User.where(role: [:admin, :author])
-> User.where(role: [:admin, :author]).order(:name)


Spieghiamo:

Le seguenti due query sono identiche e selezionano tutti gli utenti con ruolo di amministratori:

-> User.where(role: :admin)
-> User.admin

La seguente query verifica se il primo utente è un amministratore

-> User.first.admin?

La seguente query seleziona tutti gli utenti con ruolo di amministratore o di autore:

-> User.where(role: [:admin, :author])

Stessa cosa ma in ordine alfabetico di nome utente

-> User.where(role: [:admin, :author]).order(:name)



## Vecchio esempio di STATUS per COMPANIES


status:integer   -> (lista ENUM)

Per il campo stauts abbiamo

- cliente
- fornitore
- cliente e fornitore
- cliente e fornitore (potenziale)
- fornitore e cliente (potenziale)
- cliente (potenziale) e fornitore (potenziale)

useremo:

http://www.austinstory.com/rails-select-tag-and-options-for-select-explained/
<%= select_tag(:status, options_for_select([['cliente', 1], ['fornitore', 2], ['cliente e fornitore', 3], ['cliente e fornitore (potenziale)', 4], ['fornitore e cliente (potenziale)', 5], ['cliente (potenziale) e fornitore (potenziale)', 6]]))%>

http://stackoverflow.com/questions/5200213/rails-3-f-select-options-for-select

Non uso una tabella status (che ha anche il plurale irregolare) con relazione 1-a-molti perché ho solo 6 records. Non uso questo:

https://www.youtube.com/watch?v=rf6B9oo1zPY 07:50
<%= f.collection_select :state_id, State.order(:name), :id, :name, include_blank: true %>

https://rubyplus.com/articles/3691-Dynamic-Select-Menus-in-Rails-5

Mi resta da risolvere il problema dell'internazionalizzazione ma lo risolvo in maniera statica con locale/en e locale/it.


