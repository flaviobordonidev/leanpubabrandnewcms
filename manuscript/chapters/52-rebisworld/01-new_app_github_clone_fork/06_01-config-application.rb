require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rebisworld
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    #---
    # il codice qui in basso andrebbe su config/initializers/assets.rb

    # precompile assets login stylesheets                                                             
    config.assets.precompile += ['login.css'
                                ]

    # precompile assets pofo stylesheets                                                             
    config.assets.precompile += ['pofo/css/animate.css',
                                 'pofo/css/bootstrap.min.css',
                                 'pofo/css/et-line-icons.css',
                                 'pofo/css/font-awesome-via_gem.css',
                                 'pofo/css/themify-icons.css',
                                 'pofo/css/swiper.min.css',
                                 'pofo/css/justified-gallery.min.css',
                                 'pofo/css/magnific-popup.css',
                                 'pofo/revolution/css/settings.css',
                                 'pofo/revolution/css/layers.css',
                                 'pofo/revolution/css/navigation.css',
                                 'pofo/css/bootsnav.css',
                                 'pofo/css/style.css',
                                 'pofo/css/responsive.css'
                                ]

    # precompile assets pofo javascripts                                                             
    config.assets.precompile += ['pofo/js/jquery.js',
                                 'pofo/js/modernizr.js',
                                 'pofo/js/bootstrap.min.js',
                                 'pofo/js/jquery.easing.1.3.js',
                                 'pofo/js/skrollr.min.js',
                                 'pofo/js/smooth-scroll.js',
                                 'pofo/js/jquery.appear.js',
                                 'pofo/js/bootsnav.js',
                                 'pofo/js/jquery.nav.js',
                                 'pofo/js/wow.min.js',
                                 'pofo/js/page-scroll.js',
                                 'pofo/js/swiper.min.js',
                                 'pofo/js/jquery.count-to.js',
                                 'pofo/js/jquery.stellar.js',
                                 'pofo/js/jquery.magnific-popup.min.js',
                                 'pofo/js/isotope.pkgd.min.js',
                                 'pofo/js/imagesloaded.pkgd.min.js',
                                 'pofo/js/classie.js',
                                 'pofo/js/hamburger-menu.js',
                                 'pofo/js/counter.js',
                                 'pofo/js/jquery.fitvids.js',
                                 'pofo/js/equalize.min.js',
                                 'pofo/js/skill.bars.jquery.js',
                                 'pofo/js/justified-gallery.min.js',
                                 'pofo/js/jquery.easypiechart.min.js',
                                 'pofo/js/instafeed.min.js',
                                 'pofo/js/retina.min.js',
                                 'pofo/revolution/js/jquery.themepunch.tools.min.js',
                                 'pofo/revolution/js/jquery.themepunch.revolution.min.js',
                                 'pofo/js/main.js'
                                ]
  end
end
