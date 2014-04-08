class Urls
  def initialize
    @urls = DB[:urls]
  end

  def add(url)
    @urls.insert(:url => url)
  end

  def find_url(id)
    @urls.where(:id => id).select(:url).first[:url]
  end

  def find_id(url)
    @urls.where(:url => url).select(:id).first[:id]
  end

  def find_stats(id)
    @urls.where(:id => id).select(:stats).first[:stats]
  end

  def increase_views(id)
    @urls.where(:id => id).update(:stats => Sequel.+(:stats,1))
  end
end