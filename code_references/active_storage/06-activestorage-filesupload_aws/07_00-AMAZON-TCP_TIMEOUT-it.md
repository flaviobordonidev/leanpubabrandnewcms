


## Problema di connessione tra Rails e Amazon S3.

Tutto stava lavorando per bene quando improvvisamente ho ricevuto questo errore:

Failed to open TCP connection to ubuntudream-dev.s3.amazonaws.com:443 (Connection timed out - user specified timeout)

L'applicazione in produzione chiaramente ha craschato anche prima perché non riusciva a visualizzare le immagini. (potrebbe essere stato variant che non poteva ridimensionare...)

> Questo vuol dire implementare controlli aggiuntivi per gestire le immagini e forse anche sidekick 7 che è una gemma che lavora in background, probabilmente proprio per gestire qeusti problemi e per accellerare i tempi. Infatti ultimamente il caricamento dell'immagine era parecchio lento.