
## I passaggi per importare il tema

Importiamo una pagina del tema ed implementiamo tutto lo stile ed il codice javascript per visualizzarla correttamente.

I passaggi per importare il tema Eduport sulla nostra app Rails:

1. Scegliamo una pagina html da importare. Ad esempio: *index.html*
2. Usiamo un nuovo layout che chiamiamo "edu_demo" e copiamo tutto il contenuto del layout di default "application".
3. Importiamo sul layout *edu_demo* le linee di codice tra i tags <head>...</head> che non sono già presenti ed adattiamo i "puntamenti" per richiamare stylesheets e javascripts
4. Importiamo tutto il codice tra i tags <body>...</body> su *mockups/edu_index.html.erb*
5. Aggiorniamo controllers/mockups_controller.rb e config/routes.rb
6. Nel preview vediamo il testo senza stylesheets, images e javascripts
7. copiamo i files stylesheets (css, scss) su "assets/stylesheets/edu"
8. copiamo le immagini (png, jpg) su "assets/images/edu"
9. copiamo i files javascripts (js) su "assets/javascripts/edu"
10. su *mockups/edu_index.html.erb* aggiustiamo i "puntamenti" per richiamare stylesheets, images e javascripts
