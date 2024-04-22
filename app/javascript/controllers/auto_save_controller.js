import { Autosave } from "tailwindcss-stimulus-components"

export default class extends Autosave {
  static targets = ["form"]

  success(event) {
    super.success()

    this.redirect(event)
  }

  async redirect(event) {
    if (!event.detail.success) return

    try {
      const response = await event.detail.fetchResponse.response.json()
      const redirectionPath = response.redirect_path

      if (!redirectionPath) return

      history.pushState({ turbo_frame_history: true }, "", redirectionPath)

      Turbo.visit(redirectionPath)
    } catch (error) {}
  }
}
