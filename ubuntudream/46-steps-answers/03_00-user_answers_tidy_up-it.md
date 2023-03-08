# <a name="top"></a> Cap 16.3 - Facciamo ordine nelle risposte

Riordiniamo la gestione delle risposte (answers) nei vari passi (steps) della lezione (lesson).

Al momento abbiamo un doppio form nella stessa view *steps/show* (lessons/:id/steps/:id).

- Un primo form che aggiorna la risposta nella tabella steps.
- Un secondo form che aggiunge una nuova risposta nella tabella answers.

La colonna "answers" nella tabella `steps` nella nostra app ubuntudream non serve.

> Se fosse l'esempio di un esame scolastico: negli steps avremmo le domande prepararate dal professore e la risposta che il professore giudica quella corretta.

La colonna "content" nella tabella `answers` è quella che ci interessa perché racchiude la risposta dell'utente.

> Se fosse l'esempio di un esame scolastico: nelle answers avremmo le risposte date dagli alunni.



## Apriamo il branch "Users Answers Tidy Up"

```bash
$ git checkout -b uatp
```



## Togliamo steps->answer

In seguito toglieremo nel database la colonna "answer" dalla tabella `steps`.
Per adesso la togliamo dalle views e dal controller.

Rimuovo dal partial `_step` e riadatto il codice restante.

***Codice 01 - .../views/steps/_step.html.erb - linea:07***

```diff
-  <p>
-    <strong>Answer:</strong>
-    <%= step.answer %>
-  </p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/03_01-views-steps-_step.html.erb)


Rimuovo il form da `show` e riadatto il codice restante.

***Codice 02 - .../views/steps/show.html.erb - linea:00***

```diff
- <br/>---------------<br/>
- 
- <%= form_with(model: [@lesson, @step]) do |form| %>
-   <% if @step.errors.any? %>
-     <div style="color: red">
-       <h2><%= pluralize(@step.errors.count, "error") %> prohibited this step from being saved:</h2>
- 
-       <ul>
-         <% @step.errors.each do |error| %>
-           <li><%= error.full_message %></li>
-         <% end %>
-       </ul>
-     </div>
-   <% end %>
- 
-   <div>
-     <%= form.label :answer, style: "display: block" %>
-     <%= form.text_area :answer %>
-   </div>
- 
-   <div>
-     <%= form.submit %>
-   </div>
- <% end %>
- 
- <br/>---------------<br/>
- ---------------<br/>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/03_02-views-steps-show.html.erb)


Rimuovo da `edit e new --> _form`.

***Codice 03 - .../views/steps/_form_.html.erb - linea:00***

```diff
-  <div>
-    <%= form.label :answer, style: "display: block" %>
-    <%= form.text_area :answer %>
-  </div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/03_02-views-steps-show.html.erb)


Rimuovo `:answer,` dalla "white list" del controller.

***Codice 04 - .../controllers/steps_controller.rb - linea:00***

```ruby
    # Only allow a list of trusted parameters through.
    def step_params
      params.require(:step).permit(:question, :lesson_id, answers_attributes: [:_destroy, :id, :content, :user_id])
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/03_02-views-steps-show.html.erb)

> la colonna `answers` della tabella `steps` è stata esclusa dall'interfaccia grafica. <br/>
> più avanti la elimineremo anche lato database.



## Mostriamo le risposte dei soli utenti loggati

Adesso filtriamo le risposte e visualizziamo solo quelle dell'utente loggato.
è sufficiente aggiungere la condizione `.where(user_id: current_user.id)` al nostro elenco di risposte.

***Codice 05 - .../views/steps/show.html.erb - linea:06***

```html+erb
  <strong>Answers of logged User</strong>
  <ul>
    <% @step.answers.where(user_id: current_user.id).each do |answer| %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/03_05-views-steps-show.html.erb)




## Eliminiamo controlli superflui

Togliamo le condizioni che gestiscono la view nel caso in cui non ci sia un utente loggato.
Perché vogliamo che acceda a questa pagina solo un utente loggato.
il controllo della presenza di `current_user`

```diff
-    <% if current_user %>
+        <%= form.hidden_field :user_id, required: true, class: 'form-control', value:current_user.id  %>
-    <% else %>
-        <strong>ERRORE! Non c'è utente loggato!!!</strong>
-        <%= form.label :user_id, style: "display: block" %>
-        <%= form.text_field :user_id, required: true, class: 'form-control', value:1 %>
-    <% end %>
```

Invece quello che è utile fare è inserire subito il controllo degli accessi con pundit ed il reinstradamento al login con devise.
Questo lo vediamo nei prossimi capitoli.

