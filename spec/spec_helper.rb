ENV['RACK_ENV'] = 'test'
require 'sequel'
database = if !ENV['HEROKU_POSTGRESQL_JADE_URL'].nil?
             ENV['HEROKU_POSTGRESQL_JADE_URL']
           else
             'postgres://gschool_user:password@localhost/url_shortener'
           end

DB = Sequel.connect(database)

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end

def id_of_created_url(current_path)
  current_path.gsub('/','')
end