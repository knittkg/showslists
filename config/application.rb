require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AudioUploaderTestApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    # Setting namespave see also https://qiita.com/joooee0000/items/3ab0f3d791e0d0beb639
    # config.eager_load_paths += Dir["#{config.root}/lib/"]
    # see https://qiita.com/K_Yagi/items/edc46fd976526279312b
    config.paths.add 'lib', eager_load: true
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
