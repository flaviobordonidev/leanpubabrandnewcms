# <a name="top"></a> Cap 2.1 - Selezione delle pagine

In questi capitoli creeremo i mockups della nostra app. Ossia delle pagine statiche con i dati inseriti direttamente nel codice, i "segnaposto", per definire la grafica della nostra app.

Quindi modifichiamo e rielaboriamo le pagine html del tema eduport adattandole alle nostre esigenze.


## La struttura della nostra applicazione

Di seguito, in ordine alfabetico, le varie pagine della nostra applicazione `ubuntudream`.

Nome pagina   | Descrizione
| :--         | :--
homepage      | la pagina iniziale che presenta le prossime lezioni per ogni tipologia
lessons_index | l'elenco di tutte le alule (che non è la homepage).
lessons_show  | la presentazione della lezione <br/> (ho scelto una lezione e mi si presenta una pagina prima dei vari *steps*)
lessons_show_end  | pagina per il completamento dell'esercizio
lessons_stesps_show | i vari video della lezione con seguente modulo per la risposta. <br/> Per esecuzione esercizio.
login         | per mettere utente e password ed accedere all'applicazione.
sign_up       | per registrarsi come nuovo utente
users_show    | per account utente
AUTHOR        | per costruire il corso




## Selezioniamo le pagine dal tema edu

Ad ogni pagina della nosta applicazione affianchiamo le pagine del tema `Eduport` che più si avvicinano.

Nome pagina   | Descrizione
| :--         | :--
homepage      | eduport_v1.2.0/template/student_bookmark.html<br/> eduport_v1.2.0/template/faq.html
lessons_index | eduport_v1.2.0/template/index.html<br/> eduport_v1.2.0/template/course-list.html<br/> eduport_v1.2.0/template/course-grid.html
lessons_show  | eduport_v1.2.0/template/course-detail-min.html<br/> eduport_v1.2.0/template/course-detail.html<br/> eduport_v1.2.0/template/course-detail-adv.html<br/> eduport_v1.2.0/template/admin-course-detail.html
lessons_stesps_show | eduport_v1.2.0/template/course-video-player.html
lessons_show_end    | eduport_v1.2.0/template/course-added.html
login               | eduport_v1.2.0/template/sign-in.html
sign_up             | eduport_v1.2.0/template/sign-up.html
users_show          | eduport_v1.2.0/template/instructor-edit-profile.html
AUTHOR              | eduport_v1.2.0/template/admin-edit-course-detail.html<br/> eduport_v1.2.0/template/instructor-create-course.html<br/> eduport_v1.2.0/template/instructor-quiz.html

