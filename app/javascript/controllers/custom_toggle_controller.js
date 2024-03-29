import { Toggle } from "tailwindcss-stimulus-components";

export default class CustomToggle extends Toggle {
 static targets = ["hide", "show"];

 connect() {
    super.connect();
    this.updateToggleState();
 }

 toggle(event) {
    super.toggle(event);
    this.updateToggleState();
 }

 updateToggleState() {
    const isOpen = this.data.scope.element.hasAttribute("data-custom-toggle-open-value") &&
      this.data.scope.element.getAttribute("data-custom-toggle-open-value") === "true";

    this.showTarget.classList.toggle("hidden", isOpen);
    this.hideTarget.classList.toggle("hidden", !isOpen);
 }
}