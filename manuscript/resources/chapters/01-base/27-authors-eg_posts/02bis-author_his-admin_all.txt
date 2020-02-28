# Nella dashboard l'indice di tutti gli articoli varia a secondo di chi è loggato

Adesso che abbiamo creato la dashboard le autorizzazioni sono differenziate.

i post "normali" hanno le autorizzazioni che abbiamo già impostato.
invece gli "author/posts" hanno delle autorizzazioni differenti.

Infatti dentro la dashboard:
 
* Se siamo loggati come autore vediamo solo i nostri articoli (non abbiamo bisogno di vedere anche quelli degli altri)
* Se siamo loggati come amministratore vediamo tutti gli articoli. Inoltre l'amministratore avrà la capacità di cambiare l'autore di un articolo.

Questa condizione l'abbiamo già soddisfatta con il codice al capitolo 01-authors-posts alla linea 228
[...]
Per authors/posts l'elenco di tutti gli articoli è filtrato per l'autore che si è loggato.
(L'amministratore invece vede tutti gli articoli

.
.
.

  def index
    @posts = current_user.posts unless current_user.admin?
    @posts = Post.all if current_user.admin?
    authorize @posts
[...]

Questo codice è da vedere con attenzione.
E' giusto dare le autorizzazioni di pundit scritte nelle policies "post_policy" anche per "author/posts" ?
La risposta è sì perchè il Model, su cui si basano le policies, è uno solo.
Tutte le autorizzazioni sono definite su post_policy e differenziate per i vari ruoli.

--- Questo capitolo può essere eliminato. Serve solo come spunto per risistemare meglio il libro ---