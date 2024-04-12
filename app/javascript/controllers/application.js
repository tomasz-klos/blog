import { Application } from "@hotwired/stimulus";
import { setupConfirmMethod } from "../confirm_logic";

const application = Application.start();

import {
  Alert,
  Dropdown,
  Modal,
  Tabs,
  Toggle,
} from "tailwindcss-stimulus-components";

application.register("alert", Alert);
application.register("dropdown", Dropdown);
application.register("modal", Modal);
application.register("tabs", Tabs);
application.register("toggle", Toggle);

setupConfirmMethod();

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };
