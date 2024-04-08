import { Toggle } from "tailwindcss-stimulus-components";

export default class extends Toggle {
  static targets = ["button"];

  connect() {
    console.log("CustomToggle#connect");
    super.connect();
    this.updateToggleState();
  }

  toggle(event) {
    console.log("CustomToggle#toggle");
    super.toggle(event);
    this.updateToggleState();
  }

  updateToggleState() {
    const isOpen =
      this.data.scope.element.hasAttribute("data-custom-toggle-open-value") &&
      this.data.scope.element.getAttribute("data-custom-toggle-open-value") ===
        "true";

    this.buttonTarget.classList.toggle("bg-violet-500", isOpen);
  }
}
