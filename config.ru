require_relative 'boot'
db = Sequel.connect(ENV['DATABASE_URL'])
Urls.attach_db(db[:urls])
run UrlShortener