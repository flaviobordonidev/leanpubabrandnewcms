# <a name="top"></a> Cap favicon.1 - Inseriamo il favicon



## Risorse interne

- [code_references/]



## Risorse esterne

- [how-to-add-a-favicon-to-your-rails-ap](https://josephcardillo.medium.com/how-to-add-a-favicon-to-your-rails-app-9676336f7006)



## To add a favicon to your Rails app

1. Save the image to your assets folder:

2. Open your views/layouts/application.html.erb file.

3. Add <%= favicon_link_tag asset_path('image-name.png') %>



***code 01 - .../app/views/layers/application.html.erb - line:8***

```html+erb
		<%= favicon_link_tag asset_path('edu/favicon-ubuntudream.png') %>
```


