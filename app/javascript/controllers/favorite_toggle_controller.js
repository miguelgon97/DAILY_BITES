import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favorite-toggle"
export default class extends Controller {
  static targets = ["container"]

  connect() {
    console.log(this.containerTarget)
  }

  toggle(e) {
    e.preventDefault()
    console.log(this.containerTarget.classList)
    this.containerTarget.classList.toggle("d-none")
  }
}
