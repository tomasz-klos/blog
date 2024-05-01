require 'capybara/rspec'
require 'selenium/webdriver'

Capybara.javascript_driver = :selenium_chrome_headless

RSpec.configure do |config|
  if ENV['HEADLESS']
    config.before(type: :system) do
      driven_by :selenium_chrome
    end
  else
    config.before(type: :system) do
      driven_by :selenium_chrome_headless
    end
  end

  config.before(:each, type: :system, js: true) do
    page.driver.browser.manage.window.resize_to(1920, 1080)
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    # :rack_test driver's Rack app under test shares database connection
    # with the specs, so continue to use transaction strategy for speed.
    driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test

    unless driver_shares_db_connection_with_specs
      # Driver is probably for an external browser with an app
      # under test that does *not* share a database connection with the
      # specs, so use truncation strategy.
      DatabaseCleaner.strategy = :truncation
    end
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end
end
