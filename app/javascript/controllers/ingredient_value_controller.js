import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ingredient-value"
export default class extends Controller {
  static targets = ['name']
  connect() {
    console.log(this.element)
  }
}
