require 'sinatra/base'
require 'uri'
require_relative 'urls'

class UrlShortener < Sinatra::Application

  INVALID_URL_ERROR = 'Please+enter+a+valid+URL'
  INVALID_VANITY_ERROR = 'That+vanity+name+is+already+taken'
  INCORRECT_URL_ERROR = 'You+have+entered+an+incorrect+url'

  class << self
    attr_accessor :urls
  end

  helpers do
    include Rack::Utils
    alias_method :h, :escape_html
  end

  get '/' do
    error = params[:error]
    url_to_shorten = params[:url]
    vanity_name = params[:vanity_name]
    erb :index, :locals => {:error => error, :url_to_shorten => url_to_shorten, :vanity_name => vanity_name}
  end

  post '/shorten' do
    url_to_shorten = params[:url_to_shorten]
    vanity_name = params[:vanity_name]
    if is_valid_url?(url_to_shorten)
      vanity_url = Urls.create?(url_to_shorten, vanity_name)
      if vanity_url
        redirect to("/#{vanity_url}?stats=true")
      else
        redirect to(URI.parse(URI.encode("/?url=#{url_to_shorten}&error=#{INVALID_VANITY_ERROR}&vanity_name=#{vanity_name}")))
      end
    else
      redirect to(URI.parse(URI.encode("/?url=#{url_to_shorten}&error=#{INVALID_URL_ERROR}&vanity_name=#{vanity_name}")))
    end

  end

  get '/:id' do
    view_stats = params[:stats] == 'true'
    url_record = Urls.find?(params[:id])
    new_url = "#{request.base_url}/#{params[:id]}"
    if url_record && view_stats
      erb :stats, :locals => {:url_record => url_record, :new_url => new_url}
    elsif !url_record
      redirect '/'
    else
      url_record.increase_views
      redirect url_record.url
    end
  end

  not_found do
    redirect to(URI.parse(URI.encode("/?error=#{INCORRECT_URL_ERROR}")))
  end

  private
  def is_valid_url?(url_to_shorten)
    url = false
    if url_to_shorten.empty? || url_to_shorten.split(' ').count > 1 || url_to_shorten.nil?
    elsif url_to_shorten
      if url_to_shorten =~ /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/
        url = true
      end
      url
    end
  end

end