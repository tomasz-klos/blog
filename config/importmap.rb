# Pin npm packages by running ./bin/importmap

pin 'application'
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js' # @3.2.2
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js'
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin 'trix'
pin '@rails/actiontext', to: 'actiontext.js'
pin 'tailwindcss-stimulus-components' # @4.0.4
