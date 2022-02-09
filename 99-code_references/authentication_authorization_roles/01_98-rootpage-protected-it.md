# <a name="top"></a> Cap 11.98 - Protezione della homepage (root_path)

> Attenzione se Proteggiamo anche la pagina root (homepage) con devise abbiamo un comportamento "strano"

In questo caso al primo login si entra nella homepage. 
Se si riprova a fare login - http://localhost:3000/users/sign_in - quando si è già loggati allora si viene reinstradati su users/show.

Meglio lasciare la homepage pubblica con il link che ti fa fare login all'area riservata (protetta da devise + pundit).



[TODO]

