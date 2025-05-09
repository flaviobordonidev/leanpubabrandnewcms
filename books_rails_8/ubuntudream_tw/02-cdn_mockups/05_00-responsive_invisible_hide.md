# <a name="top"></a> Implementiamo Dark

Introduciamo la parte **Responsive** di Tailwind.



## Inseriamo i parametri Responsive

Assicuriamoci che il *meta tag viewport* (`<meta name="viewport"`) sia presente all'interno del tag `<head>` del documento HTML.

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
```

E poi aggiungiamo uno dei break points.


Breakpoint prefix	| Minimum width
| :--- | :---
sm	| 40rem (640px)	
md	| 48rem (768px)	
lg	| 64rem (1024px)
xl	| 80rem (1280px)
2xl	| 96rem (1536px)

