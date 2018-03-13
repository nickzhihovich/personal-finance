# Load the Rails application.
require_relative 'application'
require 'carrierwave/orm/activerecord'
# Initialize the Rails application.
Rails.application.routes.default_url_options[:host] = 'localhost:3000'
Rails.application.initialize!
