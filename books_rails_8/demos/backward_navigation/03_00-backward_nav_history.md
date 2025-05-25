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

***Codice 01 - .../app/views/layouts/application.html.erb - linea:25***

```html
  <body data-controller="history" data-history-skip-value="<%= @skip_history %>">
```

- Il valore di `data-controller` è il nome dello stimulus controller che viene richiamato. Nel nostro caso `history_controller`.
- `data-history-skip-value` è una variabile che usiamo nel nostro stimulus controller. `data-` indica che ci stiamo riferendo ad uno stimulus controller. `...-history-...` è il nome dello stimulus controller. `...-skip-...` è il nome di una variabile che definiamo nello stimulus controlelr. `...-value` vuol dire che stiamo assegnando il valore della variabile definita nello stimulus controller.
- `@skip_history` è una variabile di istanza che definiamo a livello di controller ed è di tipo `boolean` quindi `TRUE` o `FALSE`.

Quindi: ogni volta che si carica una pagina, Stimulus registra (o meno) l’URL in base a `@skip_history`, indipendentemente da cosa c’è nella pagina (bottoni, form ecc.).



## Creiamo lo Stimulus controller

Creiamo lo stimulus controller `history_controller.js`. Ed impostiamo che quando è chiamato registra (o meno) l’URL in base a `@skip_history`.
Quindi mettiamo il codice nel `connect()` che è sempre eseguito quando si richiama lo stimulus controller con `data-controller`.

***Codice 02 - .../app/javascript/controllers/history_controller.js - linea:1***

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
    
    // Evita di salvare due volte lo stesso path consecutivamente
    if (customHistory[customHistory.length - 1] !== path) {
      // Aggiunge la pagina corrente allo stack personalizzato
      customHistory.push(path)
      // Salva di nuovo tutto nel sessionStorage come stringa JSON
      sessionStorage.setItem("customHistory", JSON.stringify(customHistory))
    }
  }
}
```

Analiziamo il codice

codice | Spiegazione
:-- | :--
`static values = { skip: Boolean }` | Dice a Stimulus: “Aspettati un attributo chiamato `data-history-skip-value`, e interpretalo come un booleano.”
`if (this.skipValue) return` | Se `@skip_history` è *true* la pagina non è archiviata nello storico perché esco subito con `return`.
`const path = window.location.pathname` | Questa riga estrae il percorso corrente dell’URL, cioè tutto ciò che viene dopo il dominio, escludendo il protocollo `https://` e l’host `www.example.com`.
`let customHistory = JSON.parse(sessionStorage.getItem("customHistory") \|\| "[]")` | Questa riga serve a leggere lo stack di cronologia personalizzata che abbiamo salvato in precedenza, e trasformarlo in un array JavaScript.
`sessionStorage.getItem("customHistory")` | Cerca nel `sessionStorage` (memoria locale del browser che dura finché il tab è aperto) un oggetto con chiave `customHistory`. Se esiste, sarà una stringa JSON, ad esempio: `'["/intro", "/articoli/1", "/articoli/2"]'`
`JSON.parse(...)` | Converte quella stringa JSON in un vero array JavaScript, che potrai manipolare con push(), pop(), filter() ecc.
`sessionStorage.getItem(...) \|\| "[]"` | Se non c’è ancora nulla salvato in sessionStorage (es. prima visita dell’utente), getItem(...) restituisce null. Per evitare errori, si usa `\|\| "[]"` così, se non trova niente, `JSON.parse("[]")` crea un array vuoto, pronto da usare.
`customHistory[customHistory.length - 1] !== path` | Sta verificando se l’ultima pagina registrata nello stack è diversa dalla pagina attuale `path` per evitare duplicati.
`customHistory.push(path)` | Aggiunge l’URL corrente alla fine dello stack.
`sessionStorage.setItem(...)` | Dopo aver aggiornato lo stack, questa riga salva di nuovo tutto nel browser, convertendo l’array in stringa. Per esempio:`["/intro", "/lezione/1", "/domanda/2"]` → `'["/intro","/lezione/1","/domanda/2"]'`



## Aggiunta del controller alle pagine

Adesso andiamo nell'articles_controller ed inseriamo la variabile di instanza `@skip_history` a tutte le azioni che richiamano una view:

***Codice 03 - .../app/controllers/articles_controller.rb - linea:7***

```ruby
  def index
    @articles = Article.all
    @skip_history = false
  end

  # GET /articles/1 or /articles/1.json
  def show
    @skip_history = false
  end

  # GET /articles/new
  def new
    @article = Article.new
    @skip_history = true
  end

  # GET /articles/1/edit
  def edit
    @skip_history = true
  end
```

Premendo il pulsante "torna indietro" vogliamo passare per le views index e show ma non per le views new e edit.



## Il pulsante per navigare indietro

Implementiamo il pulsante “Torna indietro” con Stimulus

***Codice 04 - .../app/views/articles/show.html.erb - linea:14***

```html
<button data-action="click->history#goBack">
  ← Torna indietro
</button>
```

Lo stesso mettiamo anche in `.../app/views/articles/index.html.erb`.

Analiziamo il codice

codice | Spiegazione
:-- | :--
`data-action="click->history#goBack"` | Su `click` del pulsante eseguiamo la funzione `goBack` del controller stimulus `hystory_controller`.



## Due modi diversi di riferirsi allo stimulus_controller

Come mai il riferimento ad history_controller nel <body> lo abbiamo fatto nel nome dell'opzione "data-history-skip-value" ed invece nel <button> lo abbiamo fatto nel valore dell'opzione "data-action="click->history#goBack"?
Domanda eccellente! Questo tocca uno degli aspetti più importanti (e inizialmente un po’ controintuitivi) della sintassi di Stimulus, cioè il modo diverso in cui vengono dichiarati:

- i valori associati al controller `data-<controller>-<value>-value`
- le azioni degli eventi `data-action`

Esempio:

Cosa fai? | Sintassi | Scopo
:-- | :-- | :--
Passi dati a un controller | `data-history-skip-value="true"` | Configurazione
Definisci un’azione evento | `data-action="click->history#goBack"` | Risposta a un evento



### I *valori* associati allo stimulus_controller

Questa è la dichiarazione dei valori per un controller Stimulus.
Struttura:
`data-[nome_controller]-[nome_valore]-value`

Esempio:
`<body data-controller="history" data-history-skip-value="true">`

Questa sintassi passa dati al controller quando viene inizializzato.
Nel nostro caso, nel controller history_controller.js abbiamo scritto:

```javascript
static values = {
  skip: Boolean
}
```

Quindi Stimulus sa che deve leggere un attributo `data-history-skip-value`, convertirlo in booleano e renderlo disponibile come `this.skipValue`.



### Le *azioni* associate allo stimulus_controller

data-action="click->history#goBack"
Questa è la dichiarazione di un'`azione` (o `evento`, o `metodo`) per un controller Stimulus.
Struttura:
`data-action="[evento]->[nome_controller]#[metodo]"`

Esempio:
`<button data-action="click->history#goBack">`

È un meccanismo di interazione: dice “quando succede X, chiama il metodo Y”.
"Quando l'evento `click` avviene *su questo elemento*, chiama il metodo `goBack` del *controller history* che è stato attivato da qualche parte nell'albero DOM."
Questo può essere anche fuori dal bottone stesso, ad esempio se il controller è sul <body> (come nel nostro caso). Stimulus risale il DOM e usa il controller più vicino.



## Aggiungiamo il codice di goback allo stimulus controller

Aggiungiamo l'*azione* `goBack()` al contoller stimulus `history_controller`.

***Codice 05 - .../app/javascript/controllers/history_controller.js - linea:24***

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

Vantaggi di questo approccio
- Totalmente integrato con Turbo: niente reload di pagina.
- Comportamento chiaro e controllato per l’utente.
- Nessuna dipendenza da router esterni o hack su window.history.

Hai creato un'ottima base per una navigazione controllata e coerente con l'esperienza utente che immagini.
Quando inizierai a orchestrare più fasi interattive (video, form, test, feedback ecc.), potresti anche:
- segmentare lo storico per moduli o percorsi,
- memorizzare altri dati oltre all'URL (es. timestamp, titolo, progressi...),
- o persino usare questa logica per costruire una timeline visiva dei passi compiuti.

Se in futuro vuoi anche:
- integrare con i parametri di Turbo Frame,
- gestire transizioni fluide tra pagine (es. Turbo.visit(url, { action: "replace" })),
- oppure esportare il tracciamento per analisi o ripristino…
…possiamo costruirlo un pezzo alla volta.



## Refactoring di articles_controller

Evitiamo di dover scrivere esplicitamente `@skip_history = false` in tutte le azioni del controller dove vogliamo che la pagina venga tracciata nello storico. L’idea è che il comportamento predefinito sia *“archivia nella cronologia”*, e che si debbano esplicitare solo i casi da escludere.
Impostiamo `@skip_history = false` come default.

> Lo potremmo mettere a livello globale in `ApplicationController` ma preferisco metterlo nei singoli controllers.

***Codice 06 - .../app/controllers/articles_controller.rb - linea:1***

```ruby
class ApplicationController < ActionController::Base
  before_action :set_default_skip_history
```

***Codice 06 - .../app/controllers/articles_controller.rb - linea:51***

```ruby
  private

  def set_default_skip_history
    @skip_history = false
  end
end
```

Ora tutte le pagine avranno @skip_history = false di default, e non devi specificarlo.

Nelle azioni che vuoi escludere dallo storico scrivilo esplicitamente.

***Codice 06 - .../app/controllers/articles_controller.rb - linea:7***

```ruby
  def index
    @articles = Article.all
    #@skip_history = false
  end

  # GET /articles/1 or /articles/1.json
  def show
    #@skip_history = false
  end

  # GET /articles/new
  def new
    @article = Article.new
    @skip_history = true
  end

  # GET /articles/1/edit
  def edit
    @skip_history = true
  end
```

Solo quelle azioni avranno bisogno di un’istruzione esplicita.



### Impostiamo anche quelle da saltare su un `before_action`

Se vuoi evitare di inserire ogni azione da escludere nelle varie azioni lo puoi fare una sola volta all'inizio.

***Codice 07 - .../app/controllers/articles_controller.rb - linea:1***

```ruby
class ApplicationController < ActionController::Base
  before_action :set_default_skip_history
  before_action :set_skip_history, only: [:new, :edit]
```

***Codice 07 - .../app/controllers/articles_controller.rb - linea:51***

```ruby
  private

  def set_default_skip_history
    @skip_history = false
  end

  def set_skip_history
    @skip_history = true
  end
```

***Codice 07 - .../app/controllers/articles_controller.rb - linea:7***

```ruby
  def index
    @articles = Article.all
    #@skip_history = false
  end

  # GET /articles/1 or /articles/1.json
  def show
    #@skip_history = false
  end

  # GET /articles/new
  def new
    @article = Article.new
    #@skip_history = true
  end

  # GET /articles/1/edit
  def edit
    #@skip_history = true
  end
```



## Risolviamo BUG su record deleted

C'è un piccolo bug. Nel caso cancello un articolo quando torno indietro ed arriva alla pagina show dell'articolo che ho cancellato mi prende un errore.
Questo è un comportamento che può emergere facilmente quando usi uno storico personalizzato: se un URL registrato nella cronologia personalizzata diventa non più valido (es. un record che è stato cancellato), il tuo goBack() finisce per visitare una pagina che restituisce 404 o errore server, perché l'articolo non esiste più.

Far sì che il pulsante "Torna indietro" salti automaticamente le pagine non più valide e torni alla prima pagina esistente nello stack.

Verifichiamo con `fetch` se l’*URL è valido* prima di visitarlo.

***Codice 08 - .../app/javascript/controllers/history_controller.js - linea:24***

```javascript
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
```

Cosa fa questo codice
- Rimuove l’ultima pagina (quella attuale).
- Prova a fare un fetch HEAD alla precedente URL per vedere se esiste (response.ok).
- Se esiste, la visita.
- Se non esiste, passa alla precedente nello stack.
- Se nessuna è valida, va al fallback ("/" o dove vuoi tu).

Variante: fallback a index specifica
Se sei su una sezione tipo articoli, puoi specificare:

```ruby
Turbo.visit("/articles") // invece di "/"
```

🧼 Suggerimento extra
Se cancelli un articolo e fai `redirect_to articles_path`, potresti anche pulire lo storico di quel show:

```html
<%# Nella view che gestisce la delete o il redirect %>
<script>
  const path = "<%= article_path(@article) %>"
  let historyStack = JSON.parse(sessionStorage.getItem("customHistory") || "[]")
  historyStack = historyStack.filter(p => p !== path)
  sessionStorage.setItem("customHistory", JSON.stringify(historyStack))
</script>
```

Ma questa è una misura complementare, utile solo se sei certo del path da rimuovere.

Se vuoi, possiamo centralizzare tutta la logica di navigazione sicura in una piccola libreria Stimulus oppure creare un helper Rails per scrivere meno codice duplicato. Dimmi pure!



## Pulizia opzionale dello storico

Se in certi momenti vuoi resettare lo storico (es. all’inizio di un nuovo modulo), puoi farlo facilmente:

```javascript
sessionStorage.setItem("customHistory", JSON.stringify([]))
```

Oppure in Stimulus puoi creare un'azione clear dentro history_controller.js da richiamare con click->history#clear.

