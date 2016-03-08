require 'rspec'
require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'

RSpec.configure do |config|
  config.include Capybara::DSL
end

Capybara.configure do |config|
  config.default_max_wait_time = 5

  # Changing these settings will affect the Selenium grid:
  ### <grid_settings> ###

  capabilities = Selenium::WebDriver::Remote::Capabilities.firefox

  config.app_host = "http://#{ENV['APP_HOST']}"
  config.run_server = false

  config.register_driver :remote_browser do |app|
    Capybara::Selenium::Driver.new(
      app, {
        :browser => :remote,
        url: "http://#{ENV['HUB_HOST']}/wd/hub",
        desired_capabilities: capabilities
      }
    )
  end

  config.default_driver = :remote_browser
  config.javascript_driver = :remote_browser

  ### </grid_settings> ###
end
