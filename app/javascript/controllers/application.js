import { Application } from "@hotwired/stimulus"
import {
  Alert,
  Autosave,
  Dropdown,
  Modal,
  Tabs,
  Toggle,
} from "tailwindcss-stimulus-components"
import Slideover from "./slideover_controller"
import { setupConfirmMethod } from "../turbo_confirm_logic"

const application = Application.start()

application.register("alert", Alert)
application.register("autosave", Autosave)
application.register("dropdown", Dropdown)
application.register("modal", Modal)
application.register("tabs", Tabs)
application.register("toggle", Toggle)
application.register("slideover", Slideover)

setupConfirmMethod()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export { application }
