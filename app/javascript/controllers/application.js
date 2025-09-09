import { Application } from "@hotwired/stimulus"
import MobileMenuController from "./mobile_menu_controller"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

application.register("mobile-menu", MobileMenuController)

export { application }
