# <a name="top"></a> Le barre di navigazione

La nostra app è "mobile first" quindi deve funzionare bene sui cellulari prima di tutto e poi impostiamo anche la grafica per PC con monitor più grandi.


## Navbars / menu

Nell'applicazione ci sono 3 tipi di menu che sono all'interno delle seguenti barre di navigazione:
- `navbar_top`     (visualizzata sempre)
- `navbar_bottom`  (visualizzata solo su mobile)
- `navbar_lateral` (visualizzata solo su PC)



## Navbars su mobile

Prendendo ispirazione da Airbnb e da DropBox, sul cellulare ho deciso di creare due barre di navigazione, una in alto ed una in basso.

La barra di navigazione in basso (`navbar_bottom`) è quella principale ed ha 5 pulsanti:
- Cerca
- Favoriti
- UbuntuDream (home)
- Messaggi
- Profilo

I primi quattro caricano delle nuove pagine invece il "profilo" apre un sotto menu con i seguenti pulsanti:
- <<Foto e nome utente>>
- Edit profile
- Account settings
- Help
- Sign out
- [light | dark | auto]


La barra di navigazione in alto (`navbar_top`) invece cambia da pagina a pagina in funzione del contenuto.
Normalmente comunque ha la "barra di ricerca" ed un pulsante per i "filtri".



## Navbars su PC

La barra di navigazione in alto (`navbar_top`) è identica a quella del mobile. (una differenza potrebbe essere quella di avere i filtri già aperti)

La barra di navigazione laterale (`navbar_lateral`) rimpiazza la `navbar_bottom` ed ha la differenza che il pulsante "profilo" è sostituito da un sottomenu a cascata che risulta di default già aperto.



## La view `mockups/ud_navbars`

come abbiamo visto in precedenza nel capitolo xxx abbiamo già creato mockups_controller ed alcune views.
Adesso aggiungiamo la view `mockups/ud_navbars.html.erb`


## Prepariamo le navbars


***Codice 01 - .../app/views/mockups/ud_navbars.html.erb - linea:1***

```html

```
