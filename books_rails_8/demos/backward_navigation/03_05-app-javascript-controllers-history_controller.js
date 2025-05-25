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
