require 'sinatra/base'
require 'uri'
require './urls'

class UrlShortener < Sinatra::Application

  URLS = Urls.new
  INVALID_URL_ERROR = 'Please+enter+a+valid+URL'
  # set :error => ''
  # set :url_to_shorten => ''

  get '/favicon.ico' do
    "nothing"
  end

  get '/' do
    error = params[:error]
    url_to_shorten = params[:url]
    erb :index, :locals => {:error => error, :url_to_shorten => url_to_shorten}
  end

  post '/shorten' do
    url_to_shorten = params[:url]
    if url_to_shorten.empty? || url_to_shorten.split(' ').count > 1 || !is_valid_url?(url_to_shorten) || url_to_shorten.nil?
      redirect "/?url=#{url_to_shorten}&error=#{INVALID_URL_ERROR}"
    else
      id = URLS.add(url_to_shorten)
      redirect to("/#{id}?stats=true")
    end

  end

  get '/:id' do
    stats = params[:stats] == 'true'
    id = params[:id]
    original_url = URLS.find_url(id)
    new_url = "#{request.base_url}/#{id}"
    views = URLS.find_stats(id)
    if stats
      erb :stats, :locals => {:original_url => original_url, :new_url => new_url, :views => views}
    else
      URLS.increase_views(id)
      redirect original_url
    end
  end

  def is_valid_url?(url_to_shorten)
    url = false
    if url_to_shorten =~ /^#{URI::regexp}$/
      url = true
    end
    url
  end

end