require 'bundler/setup'

require 'capybara/rspec'
require 'capybara-screenshot'
require 'capybara-screenshot/rspec'
require 'capybara/poltergeist'

Capybara.configure do |c|
  c.run_server = false
  c.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new app, js_errors: false
  end
  c.default_driver = :poltergeist
  c.save_and_open_page_path = 'tmp'
end

Dir.glob('spec/support/**/*.rb') {|f| load f, true }
