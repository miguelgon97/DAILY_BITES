import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-delay"
export default class extends Controller {
  static targets = ["page", "spinner", "button"]

  toggle(e) {
    e.preventDefault()
    this.spinnerTarget.classList.remove("d-none")
    this.buttonTarget.classList.add("d-none")
    function delay(page, spinner) {
      page.classList.remove("d-none")
      spinner.classList.add("d-none")
    }

    setTimeout(() => {
      delay(this.pageTarget, this.spinnerTarget)
    }, 1500);
  }
}
