# <a name="top"></a> Cap 8.1 - Inseriamo il favicon



## Risorse interne

- [code_references/favicon/]


## Risorse esterne

- [Adding a Favicon to Your Rails 7 App](https://www.railscoder.com/articles/adding-a-favicon-to-your-rails-7-app)



## To add a favicon to your Rails app

1. Save the image to your assets folder:

2. Open your views/layouts/application.html.erb file.

3. Add <%= favicon_link_tag asset_path('image-name.png') %>



***code 01 - .../app/views/layers/application.html.erb - line:8***

```html+erb
		<%= favicon_link_tag asset_path('edu/favicon-ubuntudream.png') %>
```

Siccome il layout che stiamo usando per mockups/index è edu_demo, lo inseriamo anche qui.

***code n/a - .../app/views/layouts/edu_demo.html.erb - line:18***

```html+erb
		<%= favicon_link_tag asset_path('edu/favicon-ubuntudream.png') %>
```


## Inseriamo il favicon

Impostiamo il favicon che si visualizza sul tab del browser.
It's super easy to do with Rails. Just make the image you would like to be your favicon. I would suggest a square png file.

Then, upload the file to your app/assets/images folder.

Next, add the code to display your favicon in the head section of your application layout file. In my case, I have a scripts partial that gets called in the head of multiple layouts that I use. That way, I just need to add any new code that needs to be in the head section of every page in the scripts partial. But, if you just have the main application layout, simply **add this to your head section**.


```html+erb
```

And that's it.



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```







## Il favicon nel tema Pofo

Il tema pofo ha un modo differente di inserire il favicon.

***code n/a - .../app/views/layouts/mockup_pofo.html.erb - line:18***

```html+erb
  <!-- favicon -->
  <link rel="shortcut icon" href="<%=image_path('pofo/favicon.png')%>">
  <link rel="apple-touch-icon" href="<%=image_path('pofo/apple-touch-icon-57x57.png')%>">
  <link rel="apple-touch-icon" sizes="72x72" href="<%=image_path('pofo/apple-touch-icon-72x72.png')%>">
  <link rel="apple-touch-icon" sizes="114x114" href="<%=image_path('pofo/apple-touch-icon-114x114.png')%>">
```

