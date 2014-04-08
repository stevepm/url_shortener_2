require_relative 'boot'
db = Sequel.connect(ENV['DATABASE_URL'])
UrlShortener.urls = Urls.new(db)
run UrlShortener