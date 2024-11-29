// Import controllers for Stimulus (if using)
import "controllers"

// Import Turbo for enhanced navigation
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = true // เปิดใช้งาน Turbo Drive

// Import Rails UJS for handling methods like `data-method` and remote forms
import * as Rails from './rails-ujs';
Rails.start();

// Import Bootstrap for UI components
import "bootstrap"

