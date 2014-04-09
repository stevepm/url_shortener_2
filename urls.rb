class Urls
  def initialize(db)
    @urls = db[:urls]
  end

  def add(url, vanity = '')
    id = @urls.insert(:url => url)
    if vanity.empty?
      @urls.where(:id => id).update(:vanity => id.to_s)
    else
      @urls.where(:id => id).update(:vanity => vanity)
    end
  end

  def find_url(id)
    @urls.where(:id => id.to_i).select(:url).first[:url]
  end

  def find_stats(id)
    @urls.where(:id => id.to_i).select(:stats).first[:stats]
  end

  def increase_views(id)
    @urls.where(:id => id.to_i).update(:stats => Sequel.+(:stats,1))
  end

  def find_vanity(id)
    @urls.where(:id => id.to_i).select(:vanity).first[:vanity]
  end

  # def vanity_exists?(vanity)
  #   @urls.where(:)
  # end
end