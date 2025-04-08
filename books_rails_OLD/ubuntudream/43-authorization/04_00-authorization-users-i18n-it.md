# <a name="top"></a> Cap 11.4 - Internazionaliziamo (i18n)

Attiviamo l'internazionalizzazione.



## Traduciamo il messaggio di pundit di *non autorizzato*

Implementiamo i18n per il messaggio di non autorizzato.

***codice n/a - .../config/locales/it.yml - line:311***

```yaml
#-------------------------------------------------------------------------------
# Gems (in ordine alfabetico)

  pundit:
    you_are_not_authorized: "Non sei autorizzato a eseguire questa azione."
```


***codice n/a - .../config/locales/en.yml - line: 279***

```yaml
#-------------------------------------------------------------------------------
# Gems (in alphabetical order)

  pundit:
    you_are_not_authorized: "You are not authorized to perform this action."
```

> Si potevano creare anche due nuovi files `pundit.it.yml` è `pundit.en.yml` mettendo li dentro la traduzione. (come fa *devise*)


## Aggiorniamo application_controller

***codice n/a - .../app/controllers/application_controller.rb - line. 56***

```ruby
    def user_not_authorized
      redirect_to request.referrer || root_path, notice: t("pundit.you_are_not_authorized")
    end
```



## verifichiamo

```bash
$ rails s -b 192.168.64.3
```

Se non siamo loggati come amministratori, tentando violare le autorizzazioni impostate, riceveremo il messaggio "You are not authorized to perform this action." ("Non sei autorizzato ad eseguire questa azione.").



## Aggiorniamo git 

```bash
$ git add -A
$ git commit -m "Pundit authorized users i18n"
```



## Chiudiamo il branch

Se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge au
$ git branch -d au
```



## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```



## Publichiamo su render.com

lo fa in automatico




---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/02_00-roles-admin-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/04_00-implement_roles-it.md)
