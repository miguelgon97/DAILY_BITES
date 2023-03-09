import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favorite-toggle"
export default class extends Controller {
  static targets = ["container"]

  connect() {
  }

  toggle(e) {
    e.preventDefault()
    this.containerTarget.classList.toggle("transition")
    this.containerTarget.classList.toggle("d-none")

  }
}
