import { Application } from "@hotwired/stimulus"
import MobileMenuController from "./mobile_menu_controller"
import DropdownController from "./dropdown_controller"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

application.register("mobile-menu", MobileMenuController)
application.register("dropdown", DropdownController)

export { application }
