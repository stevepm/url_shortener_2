require 'sinatra/base'
require 'uri'
require_relative 'urls'

class UrlShortener < Sinatra::Application

  INVALID_URL_ERROR = 'Please+enter+a+valid+URL'

  class << self
    attr_accessor :urls
  end

  get '/' do
    error = params[:error]
    url_to_shorten = params[:url]
    vanity = params[:vanity]
    erb :index, :locals => {:error => error, :url_to_shorten => url_to_shorten, :vanity => vanity}
  end

  post '/shorten' do
    url_to_shorten = params[:url]
    vanity = params[:vanity]
    if !is_valid_url?(url_to_shorten)
      redirect "/?url=#{url_to_shorten}&error=#{INVALID_URL_ERROR}&vanity=#{vanity}"
    else
      id = self.class.urls.add(url_to_shorten, vanity)
      get_vanity = self.class.urls.find_vanity(id)
      redirect to("/#{get_vanity}?stats=true")
    end

  end

  get '/:id' do
    stats = params[:stats] == 'true'
    id = params[:id]
    original_url = self.class.urls.find_url(id)
    new_url = "#{request.base_url}/#{id}"
    views = self.class.urls.find_stats(id)
    if stats
      erb :stats, :locals => {:original_url => original_url, :new_url => new_url, :views => views}
    else
      self.class.urls.increase_views(id)
      redirect original_url
    end
  end

  private
  def is_valid_url?(url_to_shorten)
    url = false
    if url_to_shorten.empty? || url_to_shorten.split(' ').count > 1 || url_to_shorten.nil?
    elsif url_to_shorten
      if url_to_shorten =~ /^#{URI::regexp}$/
        url = true
      end
      url
    end
  end

end