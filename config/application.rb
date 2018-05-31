require_relative 'boot'
require File.expand_path('boot', __dir__)
ENV['RANSACK_FORM_BUILDER'] = '::SimpleForm::FormBuilder'
require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
Bundler.require(*Rails.groups)

module PersonalFinance
  class Application < Rails::Application
    config.load_defaults 5.1

    config.generators.system_tests = nil

    config.to_prepare do
      Devise::SessionsController.layout 'auth'
      Devise::RegistrationsController.layout(proc { user_signed_in? ? 'application' : 'auth' })
      Devise::ConfirmationsController.layout 'auth'
      Devise::UnlocksController.layout 'auth'
      Devise::PasswordsController.layout 'auth'
    end
  end
end
