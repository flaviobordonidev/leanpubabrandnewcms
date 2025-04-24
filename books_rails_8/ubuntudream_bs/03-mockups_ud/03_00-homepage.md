# <a name="top"></a> Cap 2.2 - Mockup homepage

Qui visualizziamo la lezione delle 3 cose per cui sei grato, che cambia ogni giorno.
Inoltre l'ultima lezione dove eri arrivato per continuare il tuo percorso.

Abbiamo anche i due pulsanti delle lezioni *favorite* e di quelle *più recenti*.



## Pagina iniziale (homepage)

vediamo uno sketch della nostra homepage.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-mockups/03_fig01-home_sketch.png)


Elaboriamo il nostro mockup a partire dalle pagine di Eduport ...



## Pagine dal tema

Per la nostra homepage ci rifacciamo a due pagine del tema Eduport:

Pagina tema   | Uso nella nostra app
| :--         | :--
eduport_v1.2.0/template/student_bookmark.html 	| Struttura iniziale 
eduport_v1.2.0/template/faq.html 								| Prendiamo solo i pulsanti "User Guide", "Assistance", ...<br/> li facciamo diventare i due pulsanti "Favorites" e "Recent".



## Prepariamo la struttura iniziale



## Pagina di login

Questa è la pagina con il mockup del login.

***code 01 - .../app/views/mockups/login.html.erb - line:321***

```html+erb

```







Alla riga 321 metto l'icona con il simbolo del *play* al posto del carrello sull'hover.

***code 01 - .../app/views/mockups/homepage.html.erb - line:321***

```html+erb
									<%# <i class="fas fa-shopping-cart text-danger"></i> %>
									<i class="fa-solid fa-play"></i>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/02-mokups/02_01-views-mockups-edu_ud_list.html.erb)




## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Mockup homepage"
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-mockups/02_00-login-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-mockups/04_00-lessons_show-it.md)
