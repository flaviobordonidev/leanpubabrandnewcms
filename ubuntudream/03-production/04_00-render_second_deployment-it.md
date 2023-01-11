# <a name="top"></a> Cap 2.4 - Una modifica riportata in produzione con Render

Adesso facciamo una piccola modifica e la riportiamo in produzione



## Risorse interne

- []()



## Risorse esterne

- []()



## Modifica sul view

Modifichiamo la nostra homepage aggiungendo semplicemente un paragrafo.

***Code 01 - .../app/mockups/index.html.erb - line:3***

```html+erb
<p>this is a change</p>
```



## Archiviamo su git


```bash
$ git add -A
$ git commit -m "A change after deployment"
```



## Archiviamo su github

```bash
$ git push origin main
```



## Pubblichiamo su render.com

Dal nostro Web Service su render.com selezioniamo Manual Deploy -> `Deploy latest commit`.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/04_fig01-deploy_latest_commit.png)



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/03_00-render_first_deployment-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/05_00-production_with_render-it.md)
