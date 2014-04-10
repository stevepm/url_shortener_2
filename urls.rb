class Urls

  class << self
    attr_reader :db

    def attach_db(db)
      @db = db
    end

    def create?(url, vanity_name = nil)
      errors = [Sequel::UniqueConstraintViolation, Sequel::DatabaseError]
      url.prepend('http://') unless url.start_with?('http://','https://')

      begin
        if vanity_name && !vanity_name.strip.empty?
          db.insert(:url => url, :vanity_name => vanity_name.to_s)
          vanity_name
        else
          id = db.insert(:url => url)
          db.where(:id => id).update(:vanity_name => id.to_s)
          id.to_s
        end
      rescue *errors
        false
      end
    end

    def find?(vanity_name)
      if db[:vanity_name => vanity_name]
        new(db.where(:vanity_name => vanity_name))
      else
        false
      end
    end
  end

  attr_reader :id, :stats, :url, :vanity_name

  def initialize(record)
    @record = record

    data = record.first
    @id = data[:id]
    @stats = data[:stats]
    @url = data[:url]
    @vanity_name = data[:vanity_name]
  end

  def increase_views
    @record.update(:stats => Sequel.+(:stats,1))
  end
end