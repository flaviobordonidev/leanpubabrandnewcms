import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = [ "output" ]

  static values = {
    characterCount: Number,
  }

  connect() {
    this.outputTarget.textContent = "Hello World!"
    console.log(this.characterCountValue)
  }
}
