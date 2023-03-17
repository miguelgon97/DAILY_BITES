import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal-transition"
export default class extends Controller {
  static targets = ["openBtn", "closeBtn", "reviews"]

  transition(e) {
    e.preventDefault()

    fetch(e.target.action, {
      method: "POST",
      headers: {
        "Accept": "text/plain"
      },
      body: new FormData(e.target)
    })
      .then(response => response.text())
      .then(data => {
        this.reviewsTarget.innerHTML = data
        this.closeBtnTarget.click()
        this.openBtnTarget.click()
      })
  }
}
//this.listTarget.outerHTML = data
