require 'simplecov'
SimpleCov.start

ENV['RACK_ENV'] = 'test'

require_relative '../boot'
require 'capybara/rspec'
require_relative 'support/migrator'

DB = Sequel.connect(ENV['TEST_DATABASE_URL'])
Migrator.new(DB).run
Urls.attach_db(DB[:urls])
Capybara.app = UrlShortener

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end

def id_of_created_url(current_path)
  current_path.gsub('/', '')
end