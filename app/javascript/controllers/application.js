import { Application } from "@hotwired/stimulus";

const application = Application.start();

import { Dropdown, Modal, Toggle } from "tailwindcss-stimulus-components";

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

application.register("dropdown", Dropdown);
application.register("modal", Modal);
application.register("toggle", Toggle);

export { application };
