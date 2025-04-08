require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Donamatrails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    
    config.i18n.default_locale = :it
    config.i18n.fallbacks = true

    # precompile assets stylesheets                                                             
    config.assets.precompile += ['bootstrap.css',
                                 'style.css',
                                 'onepage.css',
                                 'dark.css',
                                 'font-icons.css',
                                 'et-line.css',
                                 'animate.css',
                                 'magnific-popup.css',
                                 'fonts.css',
                                 'responsive.css'
                                ]

    # precompile assets javascripts                                                             
    config.assets.precompile += ['jquery.js',
                                 'plugins.js',
                                 'jquery.gmap.js',
                                 'functions.js'
                                ]

  end
end
