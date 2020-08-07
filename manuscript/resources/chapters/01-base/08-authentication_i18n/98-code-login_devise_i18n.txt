# login_authentication login_devise_i18n



#### 01 {#code-login_authentication-login_devise_i18n-01}

{title=".../config/locale/devise.it.yml", lang=yaml, line-numbers=on, starting-line-number=1}
~~~~~~~~
# Italian translation for Devise 4.2
# Date: 2017-04-05
# Authors: epistrephein, iwan, tagliala
# Note: Thanks to xpepper (https://gist.github.com/xpepper/8052632)
# Additional translations at https://github.com/plataformatec/devise/wiki/I18n

it:
  devise:
    confirmations:
      confirmed: "Il tuo account è stato correttamente confermato."
      send_instructions: "Entro qualche minuto riceverai un messaggio email con le istruzioni per confermare il tuo account."
      send_paranoid_instructions: "Se il tuo indirizzo email esiste nel nostro database, entro qualche minuto riceverai un messaggio email con le istruzioni per confermare il tuo account."
    failure:
      already_authenticated: "Hai già effettuato l'accesso."
      inactive: "Il tuo account non è ancora stato attivato."
      invalid: "%{authentication_keys} o password non validi."
      locked: "Il tuo account è bloccato."
      last_attempt: "Hai un altro tentativo prima che il tuo account venga bloccato."
      not_found_in_database: "%{authentication_keys} o password non validi."
      timeout: "La tua sessione è scaduta, accedi nuovamente per continuare."
      unauthenticated: "Devi accedere o registrarti per continuare."
      unconfirmed: "Devi confermare il tuo indirizzo email per continuare."
    mailer:
      confirmation_instructions:
        subject: "Istruzioni per la conferma"
      reset_password_instructions:
        subject: "Istruzioni per reimpostare la password"
      unlock_instructions:
        subject: "Istruzioni per sbloccare l'account"
      email_changed:
        subject: "Email reimpostata"
      password_change:
        subject: "Password reimpostata"
    omniauth_callbacks:
      failure: 'Non è stato possibile autenticarti come %{kind} perché "%{reason}".'
      success: "Autenticato con successo dall'account %{kind}."
    passwords:
      no_token: "Non è possibile accedere a questa pagina se non provieni da una e-mail di ripristino della password. Se provieni da una e-mail di ripristino della password, assicurarti di utilizzare l'URL completo."
      send_instructions: "Entro qualche minuto riceverai un messaggio email con le istruzioni per reimpostare la tua password."
      send_paranoid_instructions: "Se il tuo indirizzo email esiste nel nostro database, entro qualche minuto riceverai un messaggio email con le istruzioni per ripristinare la password."
      updated: "La tua password è stata cambiata correttamente. Ora sei collegato."
      updated_not_active: "La tua password è stata cambiata correttamente."
    registrations:
      destroyed: "Arrivederci! Il tuo account è stato cancellato. Speriamo di rivederti presto."
      signed_up: "Benvenuto! Ti sei registrato correttamente."
      signed_up_but_inactive: "Ti sei registrato correttamente. Tuttavia non puoi effettuare l'accesso perché il tuo account non è stato ancora attivato."
      signed_up_but_locked: "Ti sei registrato correttamente. Tuttavia non puoi effettuare l'accesso perché il tuo account è bloccato."
      signed_up_but_unconfirmed: "Ti sei registrato correttamente. Un messaggio con il link per confermare il tuo account è stato inviato al tuo indirizzo email."
      update_needs_confirmation: "Il tuo account è stato aggiornato, tuttavia è necessario verificare il tuo nuovo indirizzo email. Entro qualche minuto riceverai un messaggio email con le istruzioni per confermare il tuo nuovo indirizzo email."
      updated: "Il tuo account è stato aggiornato."
    sessions:
      signed_in: "Accesso effettuato con successo."
      signed_out: "Sei uscito correttamente."
      already_signed_out: "Sei uscito correttamente."
    unlocks:
      send_instructions: "Entro qualche minuto riceverai un messaggio email con le istruzioni per sbloccare il tuo account."
      send_paranoid_instructions: "Se il tuo indirizzo email esiste nel nostro database, entro qualche minuto riceverai un messaggio email con le istruzioni per sbloccare il tuo account."
      unlocked: "Il tuo account è stato correttamente sbloccato. Accedi per continuare."
  errors:
    messages:
      already_confirmed: "è stato già confermato, prova ad effettuare un nuovo accesso"
      confirmation_period_expired: "deve essere confermato entro %{period}, si prega di richiederne uno nuovo"
      expired: "è scaduto, si prega di richiederne uno nuovo"
      not_found: "non trovato"
      not_locked: "non era bloccato"
      not_saved:
        one: "Un errore ha impedito di salvare questo %{resource}:"
        other: "%{count} errori hanno impedito di salvare questo %{resource}:"
~~~~~~~~




#### 02 {#code-login_authentication-login_devise_i18n-02}

{title=".../app/views/homepage/index.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
~~~~~~~~
<div id="front_mode" class="container-fluid front_mode">

  <div class="row">
    <div class="col-xs-10 col-sm-11 col-lg-11">
      <%= render 'mockup_homepage/index/breadcrumbs' %>
    </div> <!-- /col -->
    <div class="col-xs-2 col-sm-1 col-lg-1">
      <%= render 'homepage/button_global_settings' %>
    </div> <!-- /col -->
  </div> <!-- /row -->

  <div class="row">
    <div class="col-xs-12">
      <%= current_user.email if current_user.present? == true %>
      <%= render 'mockup_homepage/index/main_media_object' %>
    </div> <!-- /col -->
  </div> <!-- /row -->

  <div class="row">
    <div class="col-xs-10 col-sm-11 col-lg-11">
      <%= render 'mockup_homepage/index/related_form_search' %>
    </div> <!-- /col -->
    <div class="col-xs-2 col-sm-1 col-lg-1">
      <%= render 'mockup_homepage/index/button_new' %>
    </div> <!-- /col -->
  </div> <!-- /row -->


  <div class="row">
    <div class="col-xs-12">
      <%= render 'mockup_homepage/index/related_list_group' %>
    </div> <!-- /col -->
  </div> <!-- /row -->

  <div class="row">
    <div class="col-xs-12">
      <div class="text-center">
        <%= render 'mockup_homepage/index/related_pagination' %>
      </div>
    </div> <!-- /col -->
  </div> <!-- /row -->

</div> <!-- /front_mode -->
~~~~~~~~
