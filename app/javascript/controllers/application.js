import { Application } from "@hotwired/stimulus"
import { setupConfirmMethod } from "../confirm_logic"
import {
  Alert,
  Autosave,
  Dropdown,
  Modal,
  Tabs,
  Toggle,
} from "tailwindcss-stimulus-components"

const application = Application.start()

application.register("alert", Alert)
application.register("autosave", Autosave)
application.register("dropdown", Dropdown)
application.register("modal", Modal)
application.register("tabs", Tabs)
application.register("toggle", Toggle)

setupConfirmMethod()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export { application }
