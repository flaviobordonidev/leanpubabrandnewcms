# <a name="top"></a> Cap 2.3 - Elenco di tutte le lezioni

Questo elenco è per tutte le lezioni con i dipinti (paintings). Le lezioni che seguono un percorso sono su un altro elenco che non ha filtri perché il percorso è obbligatorio e va fatto in sequenza.

Prendiamo la pagina *course-list* già importata su Rails del tema Eduport.



## Risorse interne

- [15-theme-edu/04-course-list]()


## Pagine dal tema

Per la nostra homepage ci rifacciamo alle seguenti pagine del tema Eduport:

Pagina tema                         | Uso nella nostra app
| :--                               | :--
eduport_v1.2.0/template/course-list.html 	| Struttura iniziale 



## Mockups *lessons_index*

Questo mockups è fatto a partire dalla pagina *course-list* di Eduport.
Vediamo la prima modifica.

***code 01 - .../db/migrate/xxx_create_lessons.rb - line:1***

```html+erb

```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/01_01-db-migrate-xxx_create_lessons.rb)





Alla riga 321 metto l'icona con il simbolo del *play* al posto del carrello sull'hover.

***code 01 - .../app/views/mockups/lessons_index.html.erb - line:321***

```html+erb
									<%# <i class="fas fa-shopping-cart text-danger"></i> %>
									<i class="fa-solid fa-play"></i>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/02-mokups/02_01-views-mockups-edu_ud_list.html.erb)


Questa pagina ha l'elenco di tutte le lezioni che possiamo ricercare con il find.

Ci dobbiamo tornare su per lavorarci ancora ma la struttura è presente.