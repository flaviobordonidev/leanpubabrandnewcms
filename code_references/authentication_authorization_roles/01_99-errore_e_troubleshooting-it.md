# <a name="top"></a> Cap 11.98 - ERRORE E TROUBLESHOOTING

Un piccolo errore non faceva funzionare l'applicativo su Heroku. Vediamo cosa era successo.



## In locale funziona ma in produzione no.

Anche se in locale funzionava tutto su heroku avevo un errore quando premevo link per creare nuovo articolo.
guardando le log di heroku ho visto che il problema era sul controller per l'azione new. (Alquanto ovvio ^_^)
L'indizio importante è stato "unknown attribute 'author_id' for Post"

{caption: "terminal", format: bash, line-numbers: false}
```
$ heroku logs
  Completed 500 Internal Server Error in 12ms (ActiveRecord: 3.1ms)
  ActiveModel::UnknownAttributeError (unknown attribute 'author_id' for Post.):
  app/controllers/authors/posts_controller.rb:20:in `new'
```

Ho fatto un po' di prove da terminale e sembrava tutto ok, quando si è accesa la lampadina! Ci siamo scordati di aggiungere :author_id alla lista bianca per il massive assignment. Aggiunta la voce, problema risolto! :)

{title=".../app/controllers/authors/posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=61}
```
      # Never trust parameters from the scary internet, only allow the white list through.
      def post_params
        params.require(:post).permit(:title, :body, :description, :author_id)
      end
```

