# <a name="top"></a> Le barre di navigazione

Introduciamo le barre id navigazione nel menu principale con anche un sottomenu a cascata (dropdown)



## Iniziamo 


- iniziamo la barra del menu, poi aggiungiamo javascript per far aprire il sottomenu
- poi separiamo lo script javascript in un file separato che mettiamo direttamente su una cartella temporanea in public

vedi http://127.0.0.1:3000/mockups/tw_navbarjs

- poi aggiungiamo la chiamata ad impormaps per poter usare stimulus


```html
    <%= javascript_importmap_tags %>
```

e creiamo il controller stimulus navbar_controller


