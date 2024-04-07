import { Application } from "@hotwired/stimulus";

const application = Application.start();

import { Alert, Toggle, Dropdown } from "tailwindcss-stimulus-components";

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

application.register('alert', Alert)
application.register("toggle", Toggle);
application.register('dropdown', Dropdown);

export { application };
