require 'rspec'
require 'capybara'
require 'selenium-webdriver'

module Grid
  class TestRunner
    BROWSERS = ['firefox', 'chrome'].freeze

    def run
      BROWSERS.each do |browser|
        setup(browser)
        yield
      end
    end

    def setup(browser)
      puts "\n\n############################"
      puts "Starting #{browser.capitalize} test run..."
      puts "############################\n\n"

      Capybara.configure do |config|
        capabilities = Selenium::WebDriver::Remote::Capabilities.firefox

        config.register_driver :remote_browser do |app|
          Capybara::Selenium::Driver.new(
            app, {
              :browser => :remote,
              url: "http://#{ENV['HUB_HOST']}/wd/hub",
              desired_capabilities: capabilities
            }
          )
        end
      end
    end
  end
end

testrunner = Grid::TestRunner.new
testrunner.run do
  RSpec::Core::Runner.run ['spec']
  RSpec.clear_examples
end
