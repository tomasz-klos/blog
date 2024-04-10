import { Application } from "@hotwired/stimulus";
import { setupConfirmMethod } from "../confirm_logic";

const application = Application.start();

import {
  Alert,
  Dropdown,
  Modal,
  Toggle,
} from "tailwindcss-stimulus-components";

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

application.register("alert", Alert);
application.register("dropdown", Dropdown);
application.register("modal", Modal);
application.register("toggle", Toggle);

setupConfirmMethod();

export { application };
