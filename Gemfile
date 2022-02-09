source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.8'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.0.4'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'better_errors'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  gem 'rubocop', require: false
  gem 'rubocop-rails'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'pry-rails'
  # メーラー確認
  gem 'letter_opener_web', '~> 1.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  # Rspec導入
  gem 'rspec-rails'
  gem "factory_bot_rails"
  gem 'faker'
  gem 'simplecov'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# views
gem 'bootstrap', '~> 4.4.1'
gem 'carrierwave', '2.0.2'
gem 'enum_help'
gem 'fog-aws' #amazon s3
gem 'font-awesome-sass', '~> 5.12.0'
gem 'gretel' #パンクズリスト
gem 'kaminari'
gem 'jp_prefecture'
gem 'meta-tags' #メタタグ管理
gem 'ransack'

# login
gem 'sorcery', '0.14.0'

# 国際化
gem 'rails-i18n'

# 定数管理
gem 'config'

# 住所から緯度と経度を変換
gem 'geocoder'

# RailsとJavascriptの連携
gem 'gon'
