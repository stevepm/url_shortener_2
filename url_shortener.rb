require 'sinatra/base'
require './urls'

class UrlShortener < Sinatra::Application

  URLS = Urls.new

  get '/favicon.ico' do
    "nothing"
  end

  get '/' do
    erb :index, :locals => {:url_to_shorten => ''}
  end

  post '/shorten' do
    url_to_shorten = params[:url]
    id = URLS.add(url_to_shorten)

    redirect to("/#{id}?stats=true")
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

end