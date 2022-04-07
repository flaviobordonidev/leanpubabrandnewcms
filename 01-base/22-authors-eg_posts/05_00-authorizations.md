# <a name="top"></a> Cap 22.5 - Vediamo le autorizzazioni con Pundit

Le autorizzazioni sono a livello di MODEL ed essendo unico per eg_post ed authors/eg_post le abbiamo già definite nei capitoli precedenti.

> Saltiamo questo capitolo


## Rivediamo come assegnare le autorizzazioni ai ruoli

Ruoli:
- Utente non loggato
- Amministratore
- Autore

Autorizzazioni "Utente non loggato"
- Se non siamo loggati vediamo tutti gli articoli pubblicati.

Autorizzazioni "Amministratore"
- Se siamo loggati come amministratore vediamo tutti gli articoli. Inoltre l'amministratore può cambiare l'autore di un articolo.

Autorizzazioni "Autore"
- Se siamo loggati come autore tutti gli articoli pubblicati e i nostri articoli non pubblicati


Vedi capitolo 01-authors-posts alla linea 228
[...]
Per authors/posts l'elenco di tutti gli articoli è filtrato per l'autore che si è loggato.
(L'amministratore invece vede tutti gli articoli

  def index
    @posts = current_user.posts unless current_user.admin?
    @posts = Post.all if current_user.admin?
    authorize @posts
[...]



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/04_00-readers-eg_posts-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/23-trace_read_eg_posts/01_00-todo.md)
