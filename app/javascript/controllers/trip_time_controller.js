import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["departure", "arrival"]

  connect() {
    this.syncTimes()
    if (this.hasDepartureTarget) {
      this.departureTarget.addEventListener("change", () => this.syncTimes())
    }
  }

  syncTimes() {
    const dep = this.departureTarget
    const arr = this.arrivalTarget
    if (!dep || !arr) return

    const now = new Date()
    const pad = n => String(n).padStart(2, "0")
    const nowLocal = `${now.getFullYear()}-${pad(now.getMonth()+1)}-${pad(now.getDate())}T${pad(now.getHours())}:${pad(now.getMinutes())}`

    if (!dep.min || dep.min < nowLocal) dep.min = nowLocal

    if (dep.value) {
      arr.min = dep.value
      if (arr.value && arr.value < dep.value) {
        arr.value = dep.value
      }
    }
  }
}
