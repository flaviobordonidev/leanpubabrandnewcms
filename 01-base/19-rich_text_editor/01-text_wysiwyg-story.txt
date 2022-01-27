{id: 01-base-19-rich_text_editor-01-story}
# Cap 19.1 -- Storia dei "rich text editors"

In rails 6 la gemma "trix" è incorporata e diventa Action Text!
Action Text è un nuovissimo framework su Rails 6 che rende la creazione, la modifica e la visualizzazione di contenuti RTF (Rich Text Content) nelle applicazioni super facili. È un'integrazione tra l'editor di Trix, l'elaborazione di file ActiveStorage e processamento immagini, e un flusso di elaborazione di testo che lega tutto insieme.

Risorse interne:

* 99-rails_references/Action_text/overview


## Gestione del testo con WYSIWYG

Per gestire il testo con un editor visuale (What You See Is What You Get) fino a Rails 5.2 si installavano delle gemme.
Le più note erano:

* TRIX - Open source gratuito sviluppato da BaseCamp
* FROALA - Eccellente WYSIWYG a pagamento una tantum
* TinyMCE - Ottimo WYSIWYG a pagamento continuativo

Ma da Rail 6.0 è stato introdotto un nuovo framework nativo basato su Trix. Il suo nome è Action Text.
