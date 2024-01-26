import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
import 'bootstrap';
import 'bootstrap/dist/css/bootstrap.min.css';
