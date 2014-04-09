require 'spec_helper'

describe 'Add urls to db' do
  before do
    Migrator.new(DB).run
  end

  it 'Can add a URL and read by ID' do
    new = Urls.new(DB)

    new.add('http://google.com', '')
    expect(new.find_url(1)).to eq('http://google.com')
  end

  it 'can find the views the page has gotten' do
    new = Urls.new(DB)
    new.add('http://google.com', '')
    expect(new.find_stats(1)).to eq(0)
  end

  it 'can increase the views' do
    new = Urls.new(DB)
    new.add('http://google.com', '')
    new.increase_views(1)
    expect(new.find_stats(1)).to eq(1)
    new.increase_views(1)
    expect(new.find_stats(1)).to eq(2)
  end

  it 'can find the vanity id' do
    new = Urls.new(DB)
    new.add('http://google.com', 'google')
    expect(new.find_vanity(1)).to eq('google')
    new.add('http://google.com', '')
    expect(new.find_vanity(2)).to eq('2')
  end

  it 'can return false if vanity is taken' do
    new = Urls.new(DB)
    new.add('http://google.com', 'google')
    expect(new.find_vanity(1)).to eq('google')
    new = Urls.new(DB)
    expect(new.add('http://google.com', 'google')).to eq(false)
  end

end