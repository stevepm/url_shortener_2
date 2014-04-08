require 'sequel'

database = if !ENV['HEROKU_POSTGRESQL_JADE_URL'].nil?
             ENV['HEROKU_POSTGRESQL_JADE_URL']
           else
             'postgres://gschool_user:password@localhost/url_shortener'
           end

DB = Sequel.connect(database)

require './url_shortener'

run UrlShortener