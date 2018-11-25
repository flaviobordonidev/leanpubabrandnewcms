# I campi che posso usare nel form



## per il testo generico

form.text_field




## per emails
Questo campo è utile nei cellulari (mobiles) perché attiva una tastiera pensata per inserimento di emails

form.email_field




## per telefoni
Questo campo è utile nei cellulari (mobiles) perché attiva una tastiera pensata per inserimento di telefoni

form.phone_field




## per siti web
Questo campo è utile nei cellulari (mobiles) perché attiva una tastiera pensata per inserimento di siti web

form.web_field




## per passwords
Nel campo si vedono asterischi mentre si digita e non il testo in chiaro

form.password_field




## per testo esteso

form.text_area




## Checkbox

form.check_box

      <%= f.check_box :remove_logo, "data-size" => "medium", "data-on-color" => "primary", "data-on-text" => "SI", "data-off-color" => "default", "data-off-text" => "NO" %>




## Menu a discesa (drop box)

      <%= f.select :status, h_options_for_status, {}, prompt: 'Select One', class: 'form-control' %>
