begin
  require 'dotenv'
  Dotenv.load
  rescue LoadError
end
require 'sequel'
require_relative 'url_shortener'