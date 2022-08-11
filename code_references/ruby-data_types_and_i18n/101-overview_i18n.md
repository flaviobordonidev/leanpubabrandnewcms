# Gestire l'internazionalizzazione

Risorse interne:

* 01-base/05-mockups_i18n


Risorse web:

* [Rails Internationalization guide](https://guides.rubyonrails.org/i18n.html)
* [Set-up for Using Locales from URL Params and Basic I18n Usage](https://dev.to/morinoko/setting-up-i18n-for-rails-with-locales-from-url-params-38pg)
* [Rails internationalisation (i18n) cheatsheet](https://mikerogers.io/2016/01/10/i18n-rails-internationalisation-i18n-cheatsheet.html)
* [ActionView::Helpers::FormHelper.label documentation](http://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html#method-i-label)
* https://guides.rubyonrails.org/i18n.html#setting-the-locale-from-the-client-supplied-information
* https://stackoverflow.com/questions/7113736/detect-browser-language-in-rails/36028149
* https://stackoverflow.com/questions/55860171/protect-from-forgery-in-rails-6
* https://phrase.com/blog/posts/rails-i18n-guide/
* i18n-debug gem




## Implementiamo internazionalizzazione

usiamo questo articolo * [Set-up for Using Locales from URL Params and Basic I18n Usage](https://dev.to/morinoko/setting-up-i18n-for-rails-with-locales-from-url-params-38pg)
#TODO




## I formati di default

Nella guida ufficiale di Rails https://guides.rubyonrails.org/i18n.html (questo link è anche indicato nel file iniziale locale/en.yml) al Capitolo "9 Contributing to Rails I18n" si rimanda al seguente link:

* https://github.com/svenfuchs/rails-i18n/tree/master/rails/locale

Qui ci sono già tante traduzioni in moltissime lingue.

Nella nostra applicazione partiamo dai seguenti formati:

* 01_01-config-locale-en-base.yml
* 01_02-config-locale-it-base.yml
  a cui abbiamo aggiunto le seguenti due linee che erano presenti solo in inglese:
  126 --> model_invalid: 'Validazione fallita: %{errors}'
  193 --> eb: EB




## Input Placeholders

You can tell Rails to use the i18n placeholder by passing " placeholder: true " into the inputs options.

{title=".../app/views/messages/_form.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=56}
~~~~~~~~
<%= form_for :message do "f| %>
  <%= f.input :name, placeholder: true %>
<% end %>
~~~~~~~~

{id="01-05-01_01all", title=".../config/locales/en.yml", lang=yaml, line-numbers=on, starting-line-number=1}
~~~~~~~~
en:
  helpers:
    placeholder:
      message:
        name: "Your placeholder text here"
~~~~~~~~




## Labels

{title=".../app/views/messages/_form.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=56}
~~~~~~~~
<%= form_for :message do "f| %>
  <%= f.label :name %>
<% end %>
~~~~~~~~

{id="01-05-01_01all", title=".../config/locales/en.yml", lang=yaml, line-numbers=on, starting-line-number=1}
~~~~~~~~
en:
  helpers:
    label:
      message:
        name: "Name label"
  activerecord:
    attributes:
      message:
        name: "Name attribute (fallback for when label is nil)"
~~~~~~~~

altro esempio:

~~~~~~~~
<% form_for @post do |f| %>
  <%= f.label :title %>
  <%= f.text_field :title %>
  <%= f.submit %>
<% end %>
~~~~~~~~

~~~~~~~~
en:
  helpers:
    label:
      post:
        title: 'Customized title'
~~~~~~~~

If the helpers: path is not available, i18n will fallback to the activerecord: path. Very clear when using the excellent i18n-debug gem.





## Submit buttons

You can change the value of your create and update submit buttons:

{title=".../app/views/messages/_form.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=56}
~~~~~~~~
<%= form_for :message do "f| %>
  <%= f.submit %>
<% end %>
~~~~~~~~

{id="01-05-01_01all", title=".../config/locales/en.yml", lang=yaml, line-numbers=on, starting-line-number=1}
~~~~~~~~
en:
  helpers:
    submit:
      message:
        create: "Create a new %{model}"
        update: "Save changes to %{model}"
~~~~~~~~


However you can also specify the create/update terms one level up the tree to have this effect every model in your app by default:

{id="01-05-01_01all", title=".../config/locales/en.yml", lang=yaml, line-numbers=on, starting-line-number=1}
~~~~~~~~
en:
  helpers:
    submit:
      create: "Create a new %{model}"
      update: "Save changes to %{model}"
~~~~~~~~




## Model names

In the previous example I used the %{model} argument in the i18n. You can easily change the name of a model in the locale file like this:

{id="01-05-01_01all", title=".../config/locales/en.yml", lang=yaml, line-numbers=on, starting-line-number=1}
~~~~~~~~
en:
  activerecord:
    models:
      messages: "Queries"
~~~~~~~~




## Adhocly in controllers

One of my favourite places to use the i18n is in my controller for the notices and alerts:

{title=".../app/controllers/messages_controller.rb", lang=ruby, line-numbers=on, starting-line-number=79}
~~~~~~~~
MessagesController < BaseController
  def update
    # Some business logic

    return redirect_to:index, notice: t(".notice") if @resource.save
    render :edit, alert: t(".alert")
  end
end
~~~~~~~~

{id="01-05-01_01all", title=".../config/locales/en.yml", lang=yaml, line-numbers=on, starting-line-number=1}
~~~~~~~~
en:
  messages:
    update:
      notice: "Message was successfully updated."
      alert: "Unable to update message."
~~~~~~~~




## Adhocly in views (With arguments)

You can also pass arguments into the i18n translate method, like so:

{title=".../app/views/messages/_sidebar.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=56}
~~~~~~~~
<%= t ".pricing_information", price: number_to_currency(200, precision: 2) %>
~~~~~~~~

{id="01-05-01_01all", title=".../config/locales/en.yml", lang=yaml, line-numbers=on, starting-line-number=1}
~~~~~~~~
en:
  messages:
    sidebar:
      pricing_information: "That'll cost %{price}"
~~~~~~~~

This would return the text:

That'll cost $200.00

Alternatively if you start without a dot, it'll look from the start of the i18n tree, for example:

{title=".../app/views/messages/_sidebar.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=56}
~~~~~~~~
<%= t "pricing_information", price: number_to_currency(200, precision: 2) %>
~~~~~~~~

{id="01-05-01_01all", title=".../config/locales/en.yml", lang=yaml, line-numbers=on, starting-line-number=1}
~~~~~~~~
en:
  pricing_information: "That'll cost %{price}"
~~~~~~~~



---
---


---
i18n statica con "locales"

# app/views/messages/_form.html.erb
-----------------------------------
<%= form_for :message do "f| %>
  <%= f.label :title %>
  <%= f.text_field :title %>
  <%= f.label :name %>
  <%= f.input :name, placeholder: true %>
  <%= f.submit %>
<% end %>


# app/views/posts/_form.html.erb
-----------------------------------
<%= form_for :post do "f| %>
  <%= f.label :title %>
  <%= f.text_field :title %>
  <%= f.label :name %>
  <%= f.input :name, placeholder: true %>
  <%= f.submit %>
<% end %>

en:
  helpers:
    label:
      message:
        name: "Name label"
      post:
        name: "Name label of post"
    placeholder:
      message:
        name: "Your placeholder text here"
      post:
        name: "Your placeholder text here"
    submit:
      message:
        create: "Create a new great messagge!"
        update: "Save changes to this message."
      post:
        create: "Create a new lovelly post!"
        update: "Yes, save changes to this post."  
  messages:
    update:
      notice: "Message was successfully updated."
      alert: "Unable to update message."
  posts:
    update:
      notice: "Post was successfully updated."
      alert: "Unable to update post."


If the helpers: path is not available, i18n will fallback to the activerecord: path. Very clear when using the excellent ** i18n-debug ** gem.
https://github.com/fphilipe/i18n-debug

https://mikerogers.io/2016/01/10/i18n-rails-internationalisation-i18n-cheatsheet.html

https://webuild.envato.com/blog/how-to-organise-i18n-without-losing-your-translation-not-found/

https://stackoverflow.com/questions/16977371/submit-button-helper-with-i18n-t

https://stackoverflow.com/questions/36810203/list-of-available-i18n-translations-for-helpers-in-ruby-on-rails-4-and-simple
