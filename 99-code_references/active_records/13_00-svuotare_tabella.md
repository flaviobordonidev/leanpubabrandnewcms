
## Svuotiamo la tabella

Cancelliamo i records che abbiamo inserito precedentemente.

---
$ rails console
> ModelName.delete_all

or

> ModelName.destroy_all
---

destroy_all checks dependencies and callbacks, and takes a little longer. delete_all is a straight SQL query.

Attenzione: This solution resets the table entries, but not the primary key.


Se vogliamo che la "primary key" ricominci di nuovo da 1 dobbiamo:

---
$ rails console
> ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'yourtablename'")


taking inspiration from your answer... 
> Person.connection.execute('delete from people' ) Person.connection.execute("update sqlite_sequence set seq = 0 where name = 'People'" ) 


In case anyone tried this and got an error, I did 
ActiveRecord::Base.connection.execute("DELETE from 'yourtablename'") 
and it worked because it would give me an error that said sqlite_sequence where name = 'yourtablename' is not a valid table name or something like that. 
---


In alternativa

---
> ModelName.delete_all
> ActiveRecord::Base.connection.reset_pk_sequence!('plural_model_name')
---

This worked really well for me, but a small detail is that your model_name in the reset command needs to plural, like the actual name of the table NOT the singular name of the model.
Also works with the symbolic version: ActiveRecord::Base.connection.reset_pk_sequence!(:plural_model_name).


