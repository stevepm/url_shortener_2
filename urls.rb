class Urls
  def initialize(db)
    @urls = db[:urls]
  end

  def add(url)
    @urls.insert(:url => url)
  end

  def find_url(id)
    @urls.where(:id => id.to_i).select(:url).first[:url]
  end

  def find_id(url)
    @urls.where(:url => url).select(:id).first[:id]
  end

  def find_stats(id)
    @urls.where(:id => id.to_i).select(:stats).first[:stats]
  end

  def increase_views(id)
    @urls.where(:id => id.to_i).update(:stats => Sequel.+(:stats,1))
  end
end