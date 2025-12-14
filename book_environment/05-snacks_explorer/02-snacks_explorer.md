# Explorer

Comandi:

- a --> add file or folder
- y --> copy (yank) file
- p --> paste file
- d --> delete file
- r --> rename file (to rename folder ../newname)

## Per rinominare una cartella
https://vi.stackexchange.com/questions/46746/how-do-i-rename-a-directory-with-snacks-vim

You need to use the folder's relative path. To change the name of a folder name1 to name2 you need to write ../name2 in the "new file name" window.

Come funziona davvero il rename delle cartelle in Snacks Explorer
Situazione:
sei in Snacks Explorer
il cursore è sul nome della cartella
premi r
si apre il riquadro “new file name” vuoto
Quello che verrebbe spontaneo fare è scrivere:
newname
…ma così fallisce.
Per farlo funzionare, devi invece scrivere:
../newname

È una specie di hack:
Snacks si aspetta un percorso (path), non solo un “nuovo nome”, e senza ../ interpreta male il rename della directory. Con ../newname lo “forzi” a considerare il nuovo nome come un path relativo valido e l’operazione va a buon fine.


## Per muovere un file
Lo copi e passi nella nuova cartella e poi cancelli il principale.
