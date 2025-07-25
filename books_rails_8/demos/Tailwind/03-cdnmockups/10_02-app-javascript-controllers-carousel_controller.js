import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]

  connect() {
    console.log("Stimulus carousel controller connected")
  }

  scrollLeft() {
    console.log("scrollLeft triggered")
    this.containerTarget.scrollBy({ left: -300, behavior: "smooth" })
  }

  scrollRight() {
    console.log("scrollRight triggered")
    this.containerTarget.scrollBy({ left: 300, behavior: "smooth" })
  }
}

