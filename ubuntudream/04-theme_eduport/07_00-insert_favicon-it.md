# <a name="top"></a> Cap 8.1 - Inseriamo il favicon



## Risorse interne

- [code_references/favicon/]




Impostiamo il favicon che si visualizza sul tab del browser

{id: "11-02-04_01", caption: ".../app/views/layouts/mockup_pofo.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 18}
```
  <!-- favicon -->
  <link rel="shortcut icon" href="<%=image_path('pofo/favicon.png')%>">
  <link rel="apple-touch-icon" href="<%=image_path('pofo/apple-touch-icon-57x57.png')%>">
  <link rel="apple-touch-icon" sizes="72x72" href="<%=image_path('pofo/apple-touch-icon-72x72.png')%>">
  <link rel="apple-touch-icon" sizes="114x114" href="<%=image_path('pofo/apple-touch-icon-114x114.png')%>">
```

