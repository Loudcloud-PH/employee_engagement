source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.0"
# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"
# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# env var
gem "dotenv", groups: [ :development, :test ]

gem "pg"

# Admin interface
gem "activeadmin"

gem "devise"
gem "cancancan"
gem "draper"
gem "pundit"

gem "sassc-rails"
gem "arctic_admin", "~> 4.3", ">= 4.3.1"

# bundlers
gem "cssbundling-rails", "~> 1.4"

gem "jsbundling-rails", "~> 1.3"

#
gem "rspec", "~> 3.13"
gem "rubocop", "~> 1.68"

# Active Storage
gem "image_processing", "~> 1.13"
gem "active_storage_validations", "~> 1.3"

# Export
gem "rubyzip", "~> 2.3", ">= 2.3.2"
gem "prawn", "~> 2.5"
gem "prawn-table", "~> 0.2.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  gem "capistrano"
  gem "capistrano-bundler"
  gem "capistrano-db-tasks", require: false, git: "https://github.com/rystraum/capistrano-db-tasks", branch: "master"
  gem "capistrano-rails"
  gem "capistrano-rbenv"

  gem "net-ssh", ">= 6.0.2"
  gem "ed25519", ">= 1.2", "< 2.0"
  gem "bcrypt_pbkdf", ">= 1.0", "< 2.0"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "rspec-rails", "~> 8.0"
end
