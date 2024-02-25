import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form", "submit"];
  static COMMENT_INPUT_SELECTOR = "trix-editor";

  connect() {
    this.initialize();
    this.setupFormEventListener();
    this.setupTurboSubmitEventListener();
  }

  initialize() {
    this.initialValue = this.getCommentInputValue().trim();
    this.updateSubmitButtonState();
  }

  setupFormEventListener() {
    this.commentInputTarget.addEventListener("trix-change", () => {
      this.updateSubmitButtonState();
    });
  }

  setupTurboSubmitEventListener() {
    document.addEventListener("turbo:submit-end", () => {
      this.resetForm();
    });
  }

  updateSubmitButtonState() {
    const trimmedValue = this.getCommentInputValue().trim();
    this.submitTarget.disabled = trimmedValue === this.initialValue || trimmedValue === "";
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