require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CampHood
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # データベースとアプリケーションのtimezone設定を合わせる
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    # デフォルトのlocaleを日本語(:ja)にする
		config.i18n.default_locale = :ja
    # パスを通す
		config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.generators do |g|
      g.skip_routes true
      g.assets false
      g.helper false
      g.test_framework false
		end
  end
end
