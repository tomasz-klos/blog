import { Dropdown } from "tailwindcss-stimulus-components"

export default class extends Dropdown {
  static targets = ["button"]

  connect() {
    super.connect()
    this.updateButtonState()
  }

  toggle(event) {
    super.toggle(event)
    this.updateButtonState()
  }

  hide(event) {
    super.hide(event)
    this.updateButtonState()
  }

  updateButtonState() {
    const isOpen =
      this.data.scope.element.hasAttribute("data-custom-dropdown-open-value") &&
      this.data.scope.element.getAttribute(
        "data-custom-dropdown-open-value",
      ) === "true"

    this.buttonTarget.setAttribute("aria-expanded", isOpen)
  }
}
