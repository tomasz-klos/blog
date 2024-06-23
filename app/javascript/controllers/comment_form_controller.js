import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "submit"]
  static COMMENT_INPUT_SELECTOR = "trix-editor"

  connect() {
    this.setOnLoad()
    this.setupFormEventListener()
    this.setupTurboSubmitEventListener()
  }

  disconnect() {
    this.teardownFormEventListener()
    this.teardownTurboSubmitEventListener()
  }

  setOnLoad() {
    this.initialValue = this.getCommentInputValue().trim()
    this.updateButtonsState()
  }

  setupFormEventListener() {
    this.trixChangeHandler = () => this.updateButtonsState()
    this.commentInputTarget.addEventListener(
      "trix-change",
      this.trixChangeHandler,
    )
  }

  teardownFormEventListener() {
    this.commentInputTarget.removeEventListener(
      "trix-change",
      this.trixChangeHandler,
    )
  }

  setupTurboSubmitEventListener() {
    this.turboSubmitEndHandler = (event) => {
      this.resetForm()
      if (this.formTarget.parentElement.id === "content_reply") {
        this.closeForm(event)
      }
    }
    document.addEventListener("turbo:submit-end", this.turboSubmitEndHandler)
  }

  teardownTurboSubmitEventListener() {
    document.removeEventListener("turbo:submit-end", this.turboSubmitEndHandler)
  }

  updateButtonsState() {
    const commentContent = this.getCommentInputValue().trim()

    const cleanedContent = commentContent
      .replace(/<[^>]+>/g, "")
      .replace(/&nbsp;/g, " ")

    this.submitTarget.disabled =
      cleanedContent === this.initialValue || !cleanedContent.trim()
  }

  resetForm() {
    this.formTarget.reset()
  }

  closeForm(event) {
    event.preventDefault()
    this.formTarget.parentElement.remove()
  }

  getCommentInputValue() {
    return this.commentInputTarget.value
  }

  get commentInputTarget() {
    return this.formTarget.querySelector(
      this.constructor.COMMENT_INPUT_SELECTOR,
    )
  }
}
