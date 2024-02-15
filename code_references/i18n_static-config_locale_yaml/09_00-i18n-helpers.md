# <a name="top"></a> Cap i18n_static.9 - helpers

Mi sembra siano le traduzioni per i campi dei Forms...



## Risorse interne

- [ubuntudream/04-i18n_static/04_00-default_format_i18n-mockups-test_a]()



## Risorse esterne

- [guida ufficiale di Rails](https://guides.rubyonrails.org/i18n.html)



## activerecord -> attributes

Mi sembra siano le traduzioni per i campi dei Forms...

[Codice 01 - .../config/locales/it.yml - linea: 30]()

```yaml
#---
# Repository di Rails: dati di traduzione allineati (in ordine alfabetico)

it:
  activerecord:
    attributes:
      user:
        name: "Nome utente" # fallback for when label is nil
        email: "Email" # fallback for when label is nil
        password: "Password" # fallback for when label is nil
        password_confirmation: "Conferma password" # fallback for when label is nil
    errors:
      messages:
        record_invalid: 'Validazione fallita: %{errors}'
```

[Codice 02 - .../config/locales/en.yml - line: 30]()

```yaml
#---
# Rail repository: translations data allined (in alphabetical order)

en-US:
  activerecord:
    attributes:
      user:
        name: "User name" # fallback for when label is nil
        email: "Email" # fallback for when label is nil
        password: "Password" # fallback for when label is nil
        password_confirmation: "Password confirmation" # fallback for when label is nil
    errors:
      messages:
        record_invalid: 'Validation failed: %{errors}'
```



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s -b 192.168.64.3
```

apriamolo il browser all'URL:

- http://192.168.64.3:3000/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/11-eg_posts/04_00-eg_redirect_after_login-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/12-format_i18n/02_00-format_date_time_i18n-it.md)
