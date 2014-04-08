require 'sequel'

database = 'postgres://gschool_user:password@localhost/url_shortener'

DB = Sequel.connect(database)

require './url_shortener'

run UrlShortener