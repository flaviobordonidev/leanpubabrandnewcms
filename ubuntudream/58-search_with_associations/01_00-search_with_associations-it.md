
# <a name="top"></a> search_with_associations - Cap.1 - Ricerche tra tabelle associate

Implementiamo delle ricerche tra tabelle con relazioni 1-a-molti, molti-a-molti o polimorfiche.



## Risorse interne



## Risorse esterne

-[Avoid Ransack's N+1 Pitfall!](https://dev.to/husteadrobert/avoid-ransacks-n1-pitfall-33of)



# L'errore N+1

**"what if you have another model associated?"**
Questo errore si ha quando abbiamo tabelle associate. Non è un vero e proprio errore di codice ma è di prestazione perché invece di fare 1 o due queries otteniamo una marea di queries (una per ogni riga della tabelle principale + la query che raggruppa il tutto).
Questo vuol dire che con delle tabelle con meno di 100 records quasi non si percepisce la differenza ma se ho tabelle da più di 1000 records allora aspetto minuti invece di secondi.

We can usually solve it with eager loading and using `includes(:model_name)`. But where do we put it? Easy, in the Controller of course!

***Codice 01 - .../controllers/services_controller.rb - linea:1***

```ruby
def index
  @q = Service.includes(:provider).ransack(params[:q])
  @services = @q.result(distinct: true)
end
```
