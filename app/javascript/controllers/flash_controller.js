import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['message']

  // Remove flash alerts before 10 seconds.
  connect() {
    setTimeout(() => {
      this.messageTarget.remove()
    }, 10 * 1000)
  }
}
