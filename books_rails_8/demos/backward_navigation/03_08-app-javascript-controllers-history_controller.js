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
}
