# <a name="top"></a> Cap 2.2 - pagina di login

Prima di entrare nella nostra applicazione si presenta la sola pagina di login.
Questo ci permette di filtrare tutti i "curiosi" che soddisferanno la loro curiosità sul sito web `ubuntudream.com`. Invece chi arriva sulla nostra applicazione Rails `ubuntudream` sono utenti che hanno già la password di accesso ed entrano per fare gli esercizi di visualizzazione.
In questo modo non appesantiamo l'applicazione con persone solo curiose e rendiamo l'esperienza degli esercizi più veloce e fluida.



## Pagina di login

Questa è la pagina di mockup che nella nostra applicazione diventerà `views/users/sessions/new.html.erb` perché questa è creata da *devise*.

***code 01 - .../app/views/mockups/login.html.erb - line:321***

```html+erb
<!-- **************** MAIN CONTENT START **************** -->
<main>
	<section class="p-0 d-flex align-items-center position-relative overflow-hidden">
	
		<div class="container-fluid">
			<div class="row">
				<!-- left -->
				<div class="col-12 col-lg-6 d-md-flex align-items-center justify-content-center bg-primary bg-opacity-10 vh-lg-100">
					<div class="p-3 p-lg-5">
						<!-- Title -->
						<div class="text-center">
							<h2 class="fw-bold">Welcome to our largest community</h2>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-mokups/02_01-mockups-login.html.erb)



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

Andiamo con il browser sull'URL:

- http://192.168.64.3:3000
- oppure: http://192.168.64.3:3000/mockups/index

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-mockups/02_fig01-mockup_login.png)



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Mockup login"
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_00-import_page.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/02_00-theme_stylesheet-it.md)
