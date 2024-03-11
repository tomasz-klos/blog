import { Application } from "@hotwired/stimulus";

const application = Application.start();

import { Toggle } from "tailwindcss-stimulus-components";

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

application.register("toggle", Toggle);

export { application };
