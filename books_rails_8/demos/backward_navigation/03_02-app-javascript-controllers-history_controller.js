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
