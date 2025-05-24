# <a name="top"></a> Link per tornare indietro di più pagine

[25/05/23]
Per implementare un pulsante di navigazione indietro ("backward navigation") in Ruby on Rails, puoi usare una semplice combinazione di HTML/ERB e JavaScript. Ci sono vari approcci, ma il più comune e compatibile è sfruttare window.history.back() in JavaScript.



## Navigazione indietro con salto

Vediamo come personalizzare la cronologia di navigazione, decidendo quali pagine devono entrare nello "storico" e quali invece devono essere trasparenti per il back button, cioè saltate quando si torna indietro. 

Invece di usare direttamente `window.history.back()`, mantieni una tua stack di pagine visitate in sessionStorage o localStorage, e fai in modo che:
- le pagine da archiviare aggiungano il proprio URL alla tua stack.
- le pagine da saltare non lo facciano.
- il pulsante “Torna indietro” legga questa stack e vada alla pagina più vecchia "valida".

Usando Turbo (Hotwire) e Stimulus, possiamo rendere la gestione dello storico personalizzato più elegante e reattiva, integrandola direttamente nei componenti frontend della tua app Rails 8.

- Creaiamo un controller Stimulus chiamato history, che:
- Registra automaticamente le pagine "da archiviare" nello storico.
- Ignora quelle "transitorie" come le fasi dell’aula interattiva.
- Gestisce il bottone "Torna indietro" saltando i passaggi da escludere.


## Impostiamo le views ad essere gestite dallo stimulus controller `history_controller`

Poiché vogliamo mantenere la storia della navigazione per tutte le view impostiamo la chiamata allo *stimulus controller* nel layout `application.html.erb`. La inseriamo nel tag `<body>`. lo facciamo perché vogliamo che Stimulus agisca all'arrivo sulla pagina, non quando si clicca qualcosa. Questo è importante perché:
- la registrazione della pagina nello `sessionStorage` avviene nel `connect()` del controller Stimulus,
- e il `connect()` viene chiamato automaticamente quando il DOM è pronto e Stimulus rileva il `data-controller`.

***Codice 02 - .../app/views/layouts/application.html.erb - linea:25***

```html
  <body data-controller="history" data-history-skip-value="<%= @skip_history %>">
```

- Il valore di `data-controller` è il nome dello stimulus controller che viene richiamato. Nel nostro caso `history_controller`.
- `data-history-skip-value` è una variabile che usiamo nel nostro stimulus controller.
- `@skip_history` è una variabile di istanza che definiamo a livello di controller ed è di tipo `boolean` quindi `TRUE` o `FALSE`.

Quindi: ogni volta che si carica una pagina, Stimulus registra (o meno) l’URL in base a `@skip_history`, indipendentemente da cosa c’è nella pagina (bottoni, form ecc.).



## Creiamo lo Stimulus controller

Creiamo la stimulus controller `history_controller.js`. Ed impostiamo che quando è chiamato registra (o meno) l’URL in base a `@skip_history`.
Quindi mettiamo il codice nel `connect()` che è sempre eseguito quando si richiama lo stimulus controller con `data-controller`.

***Codice 01 - .../app/javascript/controllers/history_controller.js - linea:24***

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    skip: Boolean
  }

  connect() {
    if (this.skipValue) return

    const path = window.location.pathname
    let customHistory = JSON.parse(sessionStorage.getItem("customHistory") || "[]")
    
    if (customHistory[customHistory.length - 1] !== path) {
      customHistory.push(path)
      sessionStorage.setItem("customHistory", JSON.stringify(customHistory))
    }
  }
}
```

Analiziamo il codice

codice | Spiegazione
:-- | :--
`static values = { skip: Boolean }` | Questo dice a Stimulus: “Aspettati un attributo chiamato data-history-skip-value, e interpretalo come un booleano.”


- `if (this.skipValue) return` --> Se `@skip_history`


## Aggiunta del controller alle pagine

Nel controller Rails:

```ruby
def video_step
  @skip_history = true
end

def intro
  @skip_history = false
end
```



## Il pulsante per navigare indietro

Pulsante “Torna indietro” con Stimulus
Dove vuoi mostrare il bottone:

```html
<button data-action="click->history#goBack">
  ← Torna indietro
</button>
```



## Aggiungiamo il codice di goback allo stimulus controller


***Codice 01 - .../app/javascript/controllers/history_controller.js - linea:24***

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    skip: Boolean
  }

  connect() {
    if (this.skipValue) return

    const path = window.location.pathname
    let customHistory = JSON.parse(sessionStorage.getItem("customHistory") || "[]")
    
    if (customHistory[customHistory.length - 1] !== path) {
      customHistory.push(path)
      sessionStorage.setItem("customHistory", JSON.stringify(customHistory))
    }
  }

  goBack() {
    let historyStack = JSON.parse(sessionStorage.getItem("customHistory") || "[]")
    historyStack.pop() // rimuove la pagina attuale
    const previous = historyStack.pop() // prendi quella prima

    sessionStorage.setItem("customHistory", JSON.stringify(historyStack))

    if (previous) {
      Turbo.visit(previous)
    } else {
      Turbo.visit("/") // fallback
    }
  }
}
```





✅ Vantaggi di questo approccio
- Totalmente integrato con Turbo: niente reload di pagina.
- Comportamento chiaro e controllato per l’utente.
- Nessuna dipendenza da router esterni o hack su window.history.

Hai detto:
Ottimo facendo delle prove iniziali mi sta funzionando alla grande. Grazie.
ChatGPT ha detto:
Fantastico, sono davvero felice che ti stia funzionando bene! 🎉
Hai creato un'ottima base per una navigazione controllata e coerente con l'esperienza utente che immagini.
Quando inizierai a orchestrare più fasi interattive (video, form, test, feedback ecc.), potresti anche:
segmentare lo storico per moduli o percorsi,
memorizzare altri dati oltre all'URL (es. timestamp, titolo, progressi...),
o persino usare questa logica per costruire una timeline visiva dei passi compiuti.
Se in futuro vuoi anche:
integrare con i parametri di Turbo Frame,
gestire transizioni fluide tra pagine (es. Turbo.visit(url, { action: "replace" })),
oppure esportare il tracciamento per analisi o ripristino…
…possiamo costruirlo un pezzo alla volta. Quando vuoi, sono qui!
Buona progettazione con Hotwire ✨



Hai detto:
Puoi dirmi come evitare di dover inserire   "@skip_history = false" nelle azioni del controller per cui voglio che torni indietro passi?


ChatGPT ha detto:
Certo! Il tuo obiettivo è non dover scrivere esplicitamente @skip_history = false in tutte le azioni del controller dove vuoi che la pagina venga tracciata nello storico. L’idea è che il comportamento predefinito sia “archivia nella cronologia”, e che tu debba esplicitare solo i casi da escludere.

Ecco come farlo in modo semplice e pulito.

✅ Soluzione: Impostare @skip_history = false come default automatico
1. Usa un before_action con valore predefinito
Nel tuo controller base (ad esempio ApplicationController) oppure nel controller specifico (es. ClassroomController), aggiungi questo:

ruby
Copia
Modifica
class ApplicationController < ActionController::Base
  before_action :set_default_skip_history

  private

  def set_default_skip_history
    @skip_history = false
  end
end
Ora tutte le pagine avranno @skip_history = false di default, e non devi specificarlo.

2. Nelle azioni che vuoi escludere dallo storico, sovrascrivi
ruby
Copia
Modifica
def video_step
  @skip_history = true
end
Solo quelle azioni avranno bisogno di un’istruzione esplicita.

🧼 Alternativa più avanzata (con lista di azioni)
Se vuoi evitare anche di scriverlo in ogni azione da escludere, puoi fare così:

ruby
Copia
Modifica
class ClassroomController < ApplicationController
  skip_history_for :video_step, :quiz_step

  # ...

  private

  def self.skip_history_for(*actions)
    before_action -> { @skip_history = true }, only: actions
  end
end
Oppure senza metaprogrammazione, con before_action tradizionale:

ruby
Copia
Modifica
before_action :set_skip_history, only: [:video_step, :quiz_step]

def set_skip_history
  @skip_history = true
end
✅ In sintesi
Imposta @skip_history = false come default con un before_action.

Sovrascrivi solo nei casi speciali.

Puoi rendere l'esclusione ancora più dichiarativa se vuoi centralizzarla.

Fammi sapere se vuoi trasformare questa logica in un concern riutilizzabile o in una configurazione automatica per sezioni dell’app.







Hai detto:
C'è un piccolo bug. Nel caso cancello un articolo quando torno indietro ed arriva alla pagina show dell'articolo che ho cancellato mi prende un errore.


ChatGPT ha detto:
Ottima osservazione — e sì, questo è un comportamento che può emergere facilmente quando usi uno storico personalizzato: se un URL registrato nella cronologia personalizzata diventa non più valido (es. una show di un record che è stato cancellato), il tuo goBack() finisce per visitare una pagina che restituisce 404 o errore server, perché l'articolo non esiste più.

Vediamo come gestirlo in modo elegante e robusto.

🎯 Obiettivo
Far sì che il pulsante "Torna indietro" salti automaticamente le pagine non più valide e torni alla prima pagina esistente nella stack.

✅ Soluzione: verifica con fetch se l’URL è valido prima di visitarlo
Puoi modificare la funzione goBack() del tuo controller Stimulus in questo modo:

javascript
Copia
Modifica
goBack() {
  let historyStack = JSON.parse(sessionStorage.getItem("customHistory") || "[]")
  historyStack.pop() // rimuove la pagina attuale

  const tryVisit = () => {
    const previous = historyStack.pop()
    if (!previous) {
      Turbo.visit("/") // fallback
      return
    }

    fetch(previous, { method: "HEAD" }).then(response => {
      if (response.ok) {
        sessionStorage.setItem("customHistory", JSON.stringify(historyStack))
        Turbo.visit(previous)
      } else {
        // Ricorsione: prova la pagina precedente se questa non è valida
        tryVisit()
      }
    }).catch(() => {
      // In caso di errore (es. rete), continua a cercare una valida
      tryVisit()
    })
  }

  tryVisit()
}
🧪 Cosa fa questo codice
Rimuove l’ultima pagina (quella attuale).

Prova a fare un fetch HEAD alla precedente URL per vedere se esiste (response.ok).

Se esiste, la visita.

Se non esiste, passa alla precedente nella stack.

Se nessuna è valida, va al fallback ("/" o dove vuoi tu).

🔧 Variante: fallback a index specifica
Se sei su una sezione tipo articoli, puoi specificare:

js
Copia
Modifica
Turbo.visit("/articles") // invece di "/"
🧼 Suggerimento extra
Se cancelli un articolo e fai redirect_to articles_path, potresti anche pulire lo storico di quel show:

erb
Copia
Modifica
<%# Nella view che gestisce la delete o il redirect %>
<script>
  const path = "<%= article_path(@article) %>"
  let historyStack = JSON.parse(sessionStorage.getItem("customHistory") || "[]")
  historyStack = historyStack.filter(p => p !== path)
  sessionStorage.setItem("customHistory", JSON.stringify(historyStack))
</script>
Ma questa è una misura complementare, utile solo se sei certo del path da rimuovere.

Se vuoi, possiamo centralizzare tutta la logica di navigazione sicura in una piccola libreria Stimulus oppure creare un helper Rails per scrivere meno codice duplicato. Dimmi pure!








## Pulizia opzionale dello storico

Se in certi momenti vuoi resettare lo storico (es. all’inizio di un nuovo modulo), puoi farlo facilmente:

```javascript
sessionStorage.setItem("customHistory", JSON.stringify([]))
```

Oppure in Stimulus puoi creare un'azione clear dentro history_controller.js da richiamare con click->history#clear.

