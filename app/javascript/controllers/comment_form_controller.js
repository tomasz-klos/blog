import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form", "submit"];
  static COMMENT_INPUT_SELECTOR = "trix-editor";

  connect() {
    this.setOnLoad();
    this.setupFormEventListener();
    this.setupTurboSubmitEventListener();
  }

  setOnLoad() {
    this.initialValue = this.getCommentInputValue().trim();
    this.updateButtonsState();
  }

  setupFormEventListener() {
    this.commentInputTarget.addEventListener("trix-change", () => {
      this.updateButtonsState();
    });
  }

  setupTurboSubmitEventListener() {
    document.addEventListener("turbo:submit-end", (event) => {
      this.resetForm();

      console.log(this.formTarget.parentElement);
      if (this.formTarget.parentElement.id === "content_reply") {
        this.closeForm(event);
      }
    });
  }

  updateButtonsState() {
    const commentContent = this.getCommentInputValue().trim();

    const cleanedContent = commentContent
      .replace(/<[^>]+>/g, "")
      .replace(/&nbsp;/g, " ");

    this.submitTarget.disabled =
      cleanedContent === this.initialValue || !cleanedContent.trim();
  }

  resetForm() {
    this.formTarget.reset();
  }

  closeForm(event) {
    event.preventDefault();
    this.formTarget.parentElement.remove();
  }

  getCommentInputValue() {
    return this.commentInputTarget.value;
  }

  get commentInputTarget() {
    return this.formTarget.querySelector(
      this.constructor.COMMENT_INPUT_SELECTOR
    );
  }
}
