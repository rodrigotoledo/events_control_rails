# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.1'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.3', '>= 7.1.3.2'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

gem 'pg'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.2'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'dotenv-rails'
  gem 'pry'
  # Gera dados falsos para testes
  gem 'faker', '~> 3.2'
  # Analisa a cobertura de código dos testes
  gem 'rubocop', require: false
  # Extensão do RuboCop para Rails
  gem 'rubocop-rails', require: false
  gem 'rufo'
end

group :development do
  # Anota os modelos com informações do schema do banco de dados
  gem 'annotate'
  # Ferramenta de segurança para Rails
  gem 'brakeman'
  # Ajuda a detectar queries N+1 em ActiveRecord
  gem 'bullet'
end

gem 'devise', '~> 4.9'
# Configuração de CORS para Rack
gem 'rack-cors', '~> 2.0'
# Banco de dados chave-valor em memória
gem 'email_validator'
gem 'friendly_id', '~> 5.5.0'
gem 'heroicon'
gem 'inline_svg'
gem 'redis', '>= 4.0.1'
gem 'tailwindcss-rails'
gem 'jwt'

gem 'rails_admin', '~> 3.0.beta2'
gem 'sassc-rails'
gem 'sidekiq', '~> 7.2'
