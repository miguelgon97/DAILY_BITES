import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favorite"
export default class extends Controller {
  static target = ["icon"]
  toggle() {
    this.iconTarget.classList.toggle()
  }
}
