# <a name="top"></a> Cap active_record-find.01b - Ordinamento

Ci sono due tipi di ordinamento:

- ASC  : ascendent (ascendente, ordine alfabetico crescente 0...A...Z)
- DESC : descendent (discendente, ordine alfabetico decrescente Z...A...0)



## Esempio tratto da steps_controller#index

```ruby
    @steps = @lesson.steps.order(id: "ASC")
```



## Esempio tratto da companies_controller#index

```ruby
   @pagy, @companies = pagy(Company.search(params[:search_master]).order(created_at: "DESC"), page_param: :page_master, items: 2)
```
