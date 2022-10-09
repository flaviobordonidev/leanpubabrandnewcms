# <a name="top"></a> Cap 8.2 - Users web gui

Attiviamo la web gui per gli utenti.



## Risorse interne

- [01-base/09-manage_users/02_00-users_protected-it.md - Working Around Rails 7’s Turbo]()
- [01-base/18-activestorage-filesupload/02_00-activestorage-install-it.md - Attiviamo upload immagine per il model eg_post]()
- [01-base/02-bootstrap/03-users_layout/03_00-users_add_fields_round_image-it.md - Aggiungiamo i campi Immagine e Bio agli utenti]()



## Aggiorniamo il Controller e le views

Adesso che abbiamo la tabella users attiviamo il 4 passo di devise che abbiamo lasciato in sospeso così possiamo preparare la web gui per la gestione degli utenti.








***code 03 - .../app/controllers/users_controller.rb - line:85***

```ruby
    # Only allow a list of trusted parameters through.
    def user_params
      if params[:user][:password].blank?
        params.require(:user).permit(:username, :email, :language, :role, :profile_image, :first_name, :last_name, :location, :bio, :phone_number)
      else
        params.require(:user).permit(:username, :email, :password, :password_confirmation, :language, :role, :profile_image, :first_name, :last_name, :location, :bio, :phone_number)
      end
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/08-user/02_03-controllers-users_controller.rb)

