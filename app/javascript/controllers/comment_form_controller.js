import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form", "submit", "cancel"];
  static COMMENT_INPUT_SELECTOR = "trix-editor";

  connect() {
    this.setOnLoad();
    this.setupFormEventListener();
    this.setupTurboSubmitEventListener();
  }

  setOnLoad() {
    this.initialValue = this.getCommentInputValue().trim();
    this.cancelHref = this.cancelTarget.href;
    this.updateButtonsState();
  }

  setupFormEventListener() {
    this.commentInputTarget.addEventListener("trix-change", () => {
      this.updateButtonsState();
    });
  }

  setupTurboSubmitEventListener() {
    document.addEventListener("turbo:submit-end", () => {
      this.resetForm();
    });
  }

  updateButtonsState() {
    const trimmedValue = this.getCommentInputValue().trim();

    this.submitTarget.disabled = trimmedValue === this.initialValue || trimmedValue === "";
    this.cancelTarget.href = trimmedValue === "" ? "javascript:void(0)" : this.cancelHref;
  }

  resetForm() {
    this.formTarget.reset();
  }

  getCommentInputValue() {
    return this.commentInputTarget.value;
  }

  get commentInputTarget() {
    return this.formTarget.querySelector(this.constructor.COMMENT_INPUT_SELECTOR);
  }
}