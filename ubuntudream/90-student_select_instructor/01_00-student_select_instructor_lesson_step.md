# bla

In questo scenario permettiamo allo studente di scegliersi un istruttore differente per seguire la lezione.

Ad esempio la lezione del dipinto Wermont ha varie versioni:
- Italiano
  - Prof. Flavio
  - Prof. Elisa
  - Prof. Alice
- Portoghese
  - Prof. Elisa
  - Prof. Jesy
- Spagnolo
  - Prof. Joly
  - Prof. Fabrizio
  - Prof. Elisa
  - Prof. Miguel

La gestione di più lingue l'abbiamo fatta sfruttando la gemma (ex Globalize) e a lingua diversa corrisponde url a youtube differente.

steps/1 -> video_youtube_id + italiano -> url_A
        -> video_youtube_id + inglese -> url_B
  
In questo caso oltre a lingua differente associamo un professore.

stesps/1 -> video_youtube_id + italiano + instructor_id -> url_A
         -> video_youtube_id + italiano + instructor_id -> url_X
         -> video_youtube_id + inglese + instructor_id -> url_B


Per farlo ci serve una tabella molti-a-molti che lega gli steps con gli instructors e presente il video_youtube_id.

Questa tabella la chiamiamo *instructor_step_maps*.

Tabella molti-a-molti

Colonna                   | Descrizione
------------------------- | -----------------------
`instructor:references`   | crea la chiave esterna *instructor_id* (a noi serve *user_id* ?!?)
`step:references`         | crea la chiave esterna *step_id*
`video_youtube_id:string` | per l'url dei video su youtube


Ci conviene usare *instructor* prendendolo dalla tabella *users* ?
- Cosa succede se un utente non è più istruttore?
- Forse i video è meglio legarli ad una tabella differente chiamata *instructors* ?!?
  A livello logico mi sembra più corretto legarla a users ma ho dei dubbi.

Se l'utente loggato è un *users* normale allora fa le lezioni e sceglie i suoi istruttori.
Se chi è loggato è un *instructor* allora può caricare nuove lezioni.