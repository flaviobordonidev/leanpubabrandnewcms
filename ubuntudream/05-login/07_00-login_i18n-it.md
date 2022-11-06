# <a name="top"></a> Cap 4.7 - Login i18n

Traduciamo la pagina di login.



## Risorse interne

- []()



## Risorse esterne

- []()



## traduciamo i vari testi

Mettiamo dei *segnaposto* dove ci sono i *testi statici* nella pagina di login.

***Codice 01 - .../app/views/users/sessions/new.html.erb - linea:12***

```html+erb
							<h2 class="fw-bold"><%= t "users.sessions.new.welcome_title" %></h2>
							<p class="mb-0 h6 fw-light"><%= t "users.sessions.new.welcome_subtitle" %></p>
```

***Codice 01 - ...continua - linea:37***

```html+erb
							<p class="mb-0 h6 fw-light ms-0 ms-sm-3"><%= t "users.sessions.new.social_proof" %></p>
```

***Codice 01 - ...continua - linea:48***

```html+erb
							<h1 class="fs-2"><%= t "users.sessions.new.login_title" %></h1>
							<p class="lead mb-4"><%= t "users.sessions.new.login_subtitle" %></p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/04_04-views-users-session-new.html.erb)


Aggiorniamo i files *locales*.<br/>
`it:` -> `users:` -> `sessions:` -> `new:`

***Codice 02 - .../app/config/locales/it.yml - linea:357***

```yaml
    sessions:
      new:
        welcome_title: "Benvenuto a UbuntuDream"
        welcome_subtitle: "Lavoriamo un po' con la nostra immaginazione ^_^"
        social_proof: "Molti studenti si sono già uniti a noi, ora tocca a te."
        login_title: "Accedi a UbuntuDream!"
        login_subtitle: "Felice di vederti! Accedi con il tuo account."
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/04_04-views-users-session-new.html.erb)


`en:` -> `users:` -> `sessions:` -> `new:`

***Codice 03 - .../app/config/locales/en.yml - linea:357***

```yaml
    sessions:
      new:
        welcome_title: "Welcome to UbuntuDream"
        welcome_subtitle: "Let's work a little with our imagination ^ _ ^"
        social_proof: "Many students have already joined us, now it's your turn."
        login_title: "Login into UbuntuDream!"
        login_subtitle: "Nice to see you! Please log in with your account."
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/04_04-views-users-session-new.html.erb)

