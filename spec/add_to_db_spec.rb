require 'rspec'
require 'sequel'
require_relative '../url_shortener'
require './urls'

describe 'Add urls to db' do
  DB = Sequel.connect('postgres://gschool_user:password@localhost/url_shortener')
  before do
    DB.create_table!(:urls) do
      primary_key :id
      String :url, :null=>false, :size => 255
      Integer :stats, :default => 0
    end
  end

  after do
    DB.drop_table(:urls)
  end

  it 'Can add a URL and read by ID' do
    new = Urls.new

    new.add('http://google.com')
    expect(new.find_url(1)).to eq('http://google.com')
  end

  it 'can find an id from a URL' do
    new = Urls.new
    new.add('http://google.com')
    expect(new.find_id('http://google.com')).to eq(1)
  end

  it 'can find the views the page has gotten' do
    new = Urls.new
    new.add('http://google.com')
    expect(new.find_stats(1)).to eq(0)
  end

end