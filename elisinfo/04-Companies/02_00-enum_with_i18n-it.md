# <a name="top"></a> Cap 4.2 - Enum

Nella generazione della tabella abbiamo indicato i campi :client_type e :supplier_type per la scelta di "cosa" forniamo o ci forniscono; se è un prodotto, un servizio, entrambi o nessuno.
Li abbiamo definiti semplicemente come :integer perché li avremmo poi trattati con ENUM.
In questo capitolo implementiamo il tutto fino a visualizzare il menu a cascata (drop-down list) nella view di modifica dell'articolo.
Ed in fine rendiamo il menu a cascada multilingua (Enum with i18n)



## Risorse esterne

- [Easily make enum compatible with i18n without gem in Rails](https://qiita.com/daichirata/items/9495e2548417a4507fec)
- [Rails i18n - How to translate enum of a model](https://stackoverflow.com/questions/43116134/rails-i18n-how-to-translate-enum-of-a-model/43156292)
- [Guida Rails per i18n](http://guides.rubyonrails.org/i18n.html)



## Gestione ELENCO per ENUM -- OLD

PARAGRAFO DA VERIFICARE ED ELIMINARE
useremo:

http://www.austinstory.com/rails-select-tag-and-options-for-select-explained/
<%= select_tag(:status, options_for_select([['cliente', 1], ['fornitore', 2], ['cliente e fornitore', 3], ['cliente e fornitore (potenziale)', 4], ['fornitore e cliente (potenziale)', 5], ['cliente (potenziale) e fornitore (potenziale)', 6]]))%>

http://stackoverflow.com/questions/5200213/rails-3-f-select-options-for-select

Non uso una tabella status (che ha anche il plurale irregolare) con relazione 1-a-molti perché ho solo 6 records. Non uso questo:

https://www.youtube.com/watch?v=rf6B9oo1zPY 07:50
<%= f.collection_select :state_id, State.order(:name), :id, :name, include_blank: true %>

https://rubyplus.com/articles/3691-Dynamic-Select-Menus-in-Rails-5

Mi resta da risolvere il problema dell'internazionalizzazione ma lo risolvo in maniera statica con locale/en e locale/it. 



## Apriamo il branch "Type Enum I18n"

```bash
$ git checkout -b tei
```



## Implementiamo nel Model

Attiviamo i campi ENUM nel Model Company per i campi :client_type e :supplier_type
Nel model nella sezione " # == Attributes "

***code 01 - .../app/models/company.rb - line:13***

```ruby
  enum client_type: {c_none: 0, c_goods: 1, c_services: 2, c_goods_and_services: 3}
  enum supplier_type: {s_none: 0, s_goods: 1, s_services: 2, s_goods_and_services: 3}
```

[tutto il codice](#01-08-01_01all)

Abbiamo messo i prefissi "c_" e "s_" perché i nomi degli indici non possono essere gli stessi nei due enum.



## Aggiorniamo il Controller

I campi `client_type` e `supplier_type` sono già presenti nella whitelist del controller perché li abbiamo inseriti durante il `generate scaffold`.



## Miglioriamo le colonne :client_type e :supplier_type per ENUM

Nel migrate iniziale non abbiamo impostato al meglio le colonne :client_type e :supplier_type per ENUM. Recuperiamo.
Creiamo un migrate di modifica per mettere un valore di "default" ed un indice per velocizzare queries che usano :client_type e :supplier_type.

```bash
$ rails g migration ChangeClientSupplierTypeAndAddIndexToCompanies
```

aggiorniamo il migrate

***code 02 - .../db/migrate/xxx_change_client_supplier_type_and_add_index_to_companies.rb - line:01***

```
class ChangeClientSupplierTypeAndAddIndexToCompanies < ActiveRecord::Migration[6.0]
  def change
    change_column :companies, :client_type, :integer, default: 0
    change_column :companies, :supplier_type, :integer, default: 0
    add_index :companies, :client_type, unique: false
    add_index :companies, :supplier_type, unique: false
  end
end
```

[tutto il codice](#01-08-01_01all)


eseguiamo il migrate

```bash
$ rails db:migrate


user_fb:~/environment/elisinfo (tei) $ rails db:migrate
== 20200824103529 ChangeClientSupplierTypeAndAddIndexToCompanies: migrating ===
-- change_column(:companies, :client_type, :integer, {:default=>0})
   -> 0.0038s
-- change_column(:companies, :supplier_type, :integer, {:default=>0})
   -> 0.0014s
-- add_index(:companies, :client_type, {:unique=>false})
   -> 0.0077s
-- add_index(:companies, :supplier_type, {:unique=>false})
   -> 0.0064s
== 20200824103529 ChangeClientSupplierTypeAndAddIndexToCompanies: migrated (0.0224s)
```



## Verifichiamo lo schema del database

Lo schema del nostro database passa da 

***code 03 - .../db/schema.rb - line:49***

```ruby
  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "building"
    t.string "address"
    t.integer "client_type"
    t.integer "client_rate"
    t.integer "supplier_type"
    t.integer "supplier_rate"
    t.string "tax_number_1"
    t.string "tax_number_2"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end
```

a

***code 04 - .../db/schema.rb - line:49***

```ruby
  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "building"
    t.string "address"
    t.integer "client_type", default: 0
    t.integer "client_rate"
    t.integer "supplier_type", default: 0
    t.integer "supplier_rate"
    t.string "tax_number_1"
    t.string "tax_number_2"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_type"], name: "index_companies_on_client_type"
    t.index ["supplier_type"], name: "index_companies_on_supplier_type"
  end
```




## Aggiorniamo la view

Implementiamo il menu a cascata

***code 05 - .../app/views/companies/_form.html.erb - line:01***

```html+erb
  <div class="field">    
    <%= form.label :client_type %>
    <%= form.select(:client_type, Company.client_types.keys.map {|client_type| [client_type.titleize,client_type]}) %>
  </div>

  <div class="field">    
    <%= form.label :supplier_type %>
    <%= form.select(:supplier_type, Company.supplier_types.keys.map {|supplier_type| [supplier_type.titleize,supplier_type]}) %>
  </div>
```

[tutto il codice](#01-03-01_01all)

I nomi visualizzati in elenco li miglioriamo nei prossimi capitoli con l'internazionalizzazione.



## Rendiamo il menu a cascada multilingua (Enum with i18n)

Per impostare la lingua italiana lavoriamo nei files yaml. Istintivamente ci verrebbe da inserirli in questo modo:

***code 06 - .../config/locales/it.yml - line:01***

```yaml
  activerecord:
    models:
      company: "azienda"
    attributes:
      company:
        client_type:
          c_none: "nessuno" 
          c_goods: "beni" 
          c_services: "servizi"
          c_goods_and_services: "beni e servizi"
        supplier_type:
          s_none: "nessuno" 
          s_goods: "beni" 
          s_services: "servizi"
          s_goods_and_services: "beni e servizi"
```

Invece dobbiamo definirli nella stessa gerarchia del modello nella seguente forma:

***code 06 - continua - line:100***

```yaml
  activerecord:
    models:
      company: "azienda"
    attributes:
      company:
        client_type: "tipologia cliente"
        supplier_type: "tipologia fornitore"
      company/client_type:
        c_none: "nessuno" 
        c_goods: "beni" 
        c_services: "servizi"
        c_goods_and_services: "beni e servizi"
      company/supplier_type:
        s_none: "nessuno" 
        s_goods: "beni" 
        s_services: "servizi"
        s_goods_and_services: "beni e servizi"
```

[tutto il codice](#01-03-01_06all)



## Completiamo la traduzione anche in inglese

Per completezza manteniamo allineato anche il file per la traduzione in inglese.

***code 07 - .../config/locales/en.yml - line:01***

```yaml
  activerecord:
    models:
      company: "company"
    attributes:
      company:
        client_type: "client's typology"
        supplier_type: "supplier typology"
      company/client_type:
        c_none: "none" 
        c_goods: "goods" 
        c_services: "services"
        c_goods_and_services: "goods and services"
      company/supplier_type:
        s_none: "none" 
        s_goods: "goods" 
        s_services: "services"
        s_goods_and_services: "goods and services"
```

[tutto il codice](#01-03-01_07all)



## Creiamo i metodi da usare nelle view

Con questa struttura possiamo usare i metodi:

- Model.model_name.human 
- Model.human_attribute_name("attribute")
- Model.human_attribute_name("attribute.nested_attribute")

per cercare in modo trasparente le traduzioni per il modello e i nomi degli attributi. Nel caso in cui sia necessario accedere ad attributi nidificati all'interno di un determinato modello, è necessario nidificarli sotto modello / attributo a livello di modello nel file di traduzione (locales/xx.yml).

```bash
$ rails c
> Company.model_name.human
> Company.human_attribute_name("client_type")
> Company.human_attribute_name("client_type.c_goods")
> Company.human_attribute_name("client_type.c_services")
> Company.human_attribute_name("supplier_type")
> Company.human_attribute_name("supplier_type.s_goods")
> Company.human_attribute_name("supplier_type.s_services")
```

Esempio:

```bash
user_fb:~/environment/elisinfo (tei) $ rails c
Running via Spring preloader in process 16390
Loading development environment (Rails 6.0.0)
2.6.3 :001 > Company.model_name.human
 => "azienda" 
2.6.3 :002 > Company.human_attribute_name("client_type")
 => "tipologia cliente" 
2.6.3 :003 > Company.human_attribute_name("client_type.c_goods")
 => "beni" 
2.6.3 :004 > Company.human_attribute_name("client_type.c_services")
 => "servizi" 
2.6.3 :005 > Company.human_attribute_name("supplier_type")
 => "tipologia fornitore" 
2.6.3 :006 > Company.human_attribute_name("supplier_type.s_goods")
 => "beni" 
2.6.3 :007 > Company.human_attribute_name("supplier_type.s_services")
 => "servizi" 
2.6.3 :008 > 
```



## Vediamo come gestire la traduzione

```bash
$ rails c
> Company.client_types
> Company.client_types.map
> Company.client_types.map{ |k,v| [k, Company.human_attribute_name("client_type.#{k}")]}
> Company.client_types.map{ |k,v| [k, Company.human_attribute_name("client_type.#{k}")]}.to_h

> Company.supplier_types
> Company.supplier_types.map
> Company.supplier_types.map{ |k,v| [k, Company.human_attribute_name("supplier_type.#{k}")]}
> Company.supplier_types.map{ |k,v| [k, Company.human_attribute_name("supplier_type.#{k}")]}.to_h
```

Esempio:

```bash
2.6.3 :009 > 
2.6.3 :010 > Company.client_types
 => {"c_no"=>0, "c_goods"=>1, "c_services"=>2, "c_goods_and_services"=>3} 
2.6.3 :011 > Company.client_types.map
 => #<Enumerator: {"c_no"=>0, "c_goods"=>1, "c_services"=>2, "c_goods_and_services"=>3}:map> 
2.6.3 :012 > Company.client_types.map{ |k,v| [k, Company.human_attribute_name("client_type.#{k}")]}
 => [["c_no", "C no"], ["c_goods", "beni"], ["c_services", "servizi"], ["c_goods_and_services", "beni e servizi"]] 
2.6.3 :013 > Company.client_types.map{ |k,v| [k, Company.human_attribute_name("client_type.#{k}")]}.to_h
 => {"c_no"=>"C no", "c_goods"=>"beni", "c_services"=>"servizi", "c_goods_and_services"=>"beni e servizi"} 
2.6.3 :014 > 
2.6.3 :015 > Company.supplier_types
 => {"s_no"=>0, "s_goods"=>1, "s_services"=>2, "s_goods_and_services"=>3} 
2.6.3 :016 > Company.supplier_types.map
 => #<Enumerator: {"s_no"=>0, "s_goods"=>1, "s_services"=>2, "s_goods_and_services"=>3}:map> 
2.6.3 :017 > Company.supplier_types.map{ |k,v| [k, Company.human_attribute_name("supplier_type.#{k}")]}
 => [["s_no", "S no"], ["s_goods", "beni"], ["s_services", "servizi"], ["s_goods_and_services", "beni e servizi"]] 
2.6.3 :018 > Company.supplier_types.map{ |k,v| [k, Company.human_attribute_name("supplier_type.#{k}")]}.to_h
 => {"s_no"=>"S no", "s_goods"=>"beni", "s_services"=>"servizi", "s_goods_and_services"=>"beni e servizi"} 
2.6.3 :019 > 
```

> al posto di xxx.to_h si poteva usare Hash[xxx] <br/>
> Quindi avremmo avuto: `Hash[Post.content_types.map{ |k,v| [k, Post.human_attribute_name("content_type.#{k}")]}]`



## Inseriamo la traduzione nel view

Ora che conosciamo la definizione e come accedervi possiamo inserirli nel view (da -> a).

- da <%= form.select(:client_type, Company.client_types.keys.map {|client_type| [client_type.titleize, client_type]}) %>
- a  <%= form.select(:client_type, Company.client_types.keys.map {|client_type| [Company.human_attribute_name("client_type.#{client_type}"), client_type]}) %>

Aggiorniamo la view.

***code 05 - .../app/views/companies/_form.html.erb - line:01***

```html+erb
  <div class="field">    
    <%= form.label :client_type %>
    <%#= form.select(:client_type, Company.client_types.keys.map {|client_type| [client_type.titleize,client_type]}) %>
    <%= form.select(:client_type, Company.client_types.keys.map {|client_type| [Company.human_attribute_name("client_type.#{client_type}"), client_type]}) %>
  </div>

  <div class="field">    
    <%= form.label :supplier_type %>
    <%= form.select(:supplier_type, Company.supplier_types.keys.map {|supplier_type| [Company.human_attribute_name("supplier_type.#{supplier_type}"), supplier_type]}) %>
  </div>
```

[tutto il codice](#01-03-01_01all)




## Possibile visualizzazione come radio_buttons

Volendo possiamo anche visualizzarli come radio_buttons

***code n/a - .../app/views/companies/_form.html.erb - line:01***

```html+erb
    <%= form.collection_radio_buttons :supplier_type, Hash[Company.supplier_types.map { |k,v| [k, Company.human_attribute_name("supplier_type.#{k}")] }], :first, :second %>
```



## Per una view più asciutta possiamo creare un helper

volendo si può creare un helper

***code n/a - .../app/helpers/companies_helper.rb - line:01***

```ruby
module CompaniesHelper
  def h_human_attribute_supplier_types
    Hash[Company.supplier_types.map { |k,v| [k, Company.human_attribute_name("supplier_type.#{k}")] }]
  end
end
```

in modo da avere un view più "dry"

***code n/a - .../app/views/companies/_form.html.erb - line:01***

```html+erb
    <%= form.collection_radio_buttons :supplier_type, h_human_attribute_supplier_types, :first, :second %>
```

Un altro modo è quello di creare una variabile virtuale nel Model.



## Implementiamo virtual variable nel Model

***code n/a - .../app/models/post.rb - line:13***

```ruby
(vedi virtual attribute con get_read, get_write ....)

  Post.content_types.map{ |k,v| [k, Post.human_attribute_name("content_type.#{k}")]}.to_h
```

[tutto il codice](#01-08-01_01all)

```ruby
  # def self.human_attribute_enum_value(attr_name, value)
  #   human_attribute_name("#{attr_name}.#{value}")
  # end

  # def human_attribute_enum(attr_name)
  #   self.class.human_attribute_enum_value(attr_name, self[attr_name])
  # end
```
