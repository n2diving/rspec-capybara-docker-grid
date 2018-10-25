require 'rspec'
require 'capybara/rspec'
require 'capybara/dsl'
require 'selenium-webdriver'

RSpec.configure do |config|
  config.include Capybara::DSL
  config.color = true
  config.tty = true
  config.default_formatter = 'doc'
end

Capybara.configure do |config|
  config.default_max_wait_time = 5

  config.app_host = "https://weblinc.dev.bouqs.com/flowers/all"
  config.run_server = false

  config.default_driver = :remote_browser
  config.javascript_driver = :remote_browser
end
