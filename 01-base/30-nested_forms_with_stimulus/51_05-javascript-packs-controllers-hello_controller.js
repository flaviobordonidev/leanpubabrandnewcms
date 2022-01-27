import { Controller } from "stimulus"

export default class extends Controller {
  log(event){
    event.preventDefault()
    console.log(this.targets.find("name").value)
  }
}