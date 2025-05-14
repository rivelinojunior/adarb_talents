import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['message']

  connect() {
    let timeToHideInSeconds = 10_000

    setTimeout(() => {
      console.log('rempver')
      this.messageTarget.remove()
    }, timeToHideInSeconds)
  }
}
