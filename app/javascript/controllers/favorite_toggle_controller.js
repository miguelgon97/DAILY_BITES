import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favorite-toggle"
export default class extends Controller {

  static targets = ["link"]

  toggle(e) {
    e.preventDefault()
    const csrf = document.querySelector('meta[name="csrf-token"]').content

    fetch(this.linkTarget.href, {
      method: "POST",
      headers: {
        "Accept": "text/plain",
        "X-CSRF-TOKEN": csrf
      }})
      .then(response => response.text())
      .then(data => {
        this.linkTarget.outerHTML = data
      })
  }
}
