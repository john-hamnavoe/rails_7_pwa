// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/service-worker.js', { scope: './' })
                         .then(function(registration) {
                           console.log('[Companion]', 'Service worker registered!')
                           console.log(registration)
                         })
}