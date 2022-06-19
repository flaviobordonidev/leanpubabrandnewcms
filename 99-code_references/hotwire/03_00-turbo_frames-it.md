# Turbo frame

Approfondiamo

## Risorse esterne

- [hotwire calculator](bit.ly/hotwire-calc)



## Vediamo come funziona Turbo Frame

Abbiamo il Turbo Frame tag con un id che deve essere univoco nella pagina: `<turbo-frame id="frame-id">`.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/03_fig01-turbo_frame_code.png)

In questo esempio abbiamo il link con titolo "Click" `<a href="/something">Click</a>` e quando clicchiamo sul link abbiamo la fetch/request che va al server.

Il server render un *template* (*view*) e quel template viene reinviato come fetch/response al browser e sostituisce il frame presente. Tutto il resto della pagina resta uguale.


## Come gestire componenti correlati

Finora abbiamo visto che Turbo Frames cambia un solo componente alla volta (per componente intendiamo del codice html dentro il turbo frame). Ma ci sono molti casi in cui dobbiamo cambiare anche in un altra parte della pagina. 

Ad esempio abbiamo un contatore (counter) da una parte della pagina ed interagiamo con un turbo frame in un'altra parte della pagina. Se vogliamo che al request del turbo frame il server ci dia un response che aggiorni anche il contatore... questo Turbo Frame **non** riesce a farlo. 

Ed è per questo che esiste Turbo Stream.