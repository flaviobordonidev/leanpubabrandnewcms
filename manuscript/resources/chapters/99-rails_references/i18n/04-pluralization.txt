# Traduzione dei pluralize

Risorse web:

* https://thoughtbot.com/blog/pluralizing-rails-i18n-translations
* https://lokalise.com/blog/rails-i18n/



## Pluralizing I18n Translations in Your Rails Application

Say we have some I18n text that tells users how many notifications they have. One option for dealing with a singular vs plural situation would look like this:

config/locales/en.yml
~~~~~~~~
en:
  single_notification: You have 1 notification
  other_notification_count: You have %{count} notifications
~~~~~~~~


app/views/notifications/index.html.erb
~~~~~~~~
<% if current_user.notifications.count == 1 %>
  <%= t("single_notification") %>
<% else %>
  <%= t("other_notification_count", count: current_user.notifications.count) %>
<% end %>
~~~~~~~~

Kind of ugly, right? Luckily, Rails provides a simple way to deal with pluralization in translations. Let’s try it out:


config/locales/en.yml
~~~~~~~~
en:
  notification:
    one: You have 1 notification
    other: You have %{count} notifications
~~~~~~~~


app/views/notifications/index.html.erb
~~~~~~~~
<%= t("notification", count: current_user.notifications.count) %>
~~~~~~~~

Same result, and no conditionals in our views. Awesome.
