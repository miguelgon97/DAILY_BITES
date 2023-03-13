import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reviews"
export default class extends Controller {
  connect() {
    console.log("hello")
  }

  toggleForm(e) {
    e.preventDefault()
    console.log(e)
  }
}
