import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="video"
export default class extends Controller {
  connect() {
    this.element.addEventListener("ended", this.onEnded)
  }

  disconnect() {
    this.element.removeEventListener("ended", this.onEnded)
  }

  onEnded = () => {
    console.log("🎬 Il video è finito!")
    // qui puoi fare altro: ad es. inviare un evento, mostrare un messaggio, ecc.
  }
}