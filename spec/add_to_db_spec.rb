require 'spec_helper'

describe 'Add urls to db' do
  before do
    Migrator.new(DB).run
  end

  it 'Can add a URL and read by vanity name' do
    Urls.create?('http://google.com')
    expect(Urls.find?('1').url).to eq('http://google.com')
  end

  it 'can find the views the page has gotten' do
    Urls.create?('http://google.com')
    expect(Urls.find?('1').stats).to eq(0)
  end

  it 'can increase the views' do
    Urls.create?('http://google.com')
    Urls.find?('1').increase_views
    expect(Urls.find?('1').stats).to eq(1)
    Urls.find?('1').increase_views
    expect(Urls.find?('1').stats).to eq(2)
  end

  it 'Can add a vanity name' do
    Urls.create?('http://google.com', 'google')
    Urls.create?('http://google.com')
    expect(Urls.find?('google').vanity_name).to eq('google')
    expect(Urls.find?('2').vanity_name).to eq('2')
  end

  it 'can return false if vanity is taken' do
    Urls.create?('http://google.com', 'google')
    expect(Urls.create?('http://google.com', 'google')).to eq(false)
  end

  it 'can return false on find if vanity doesnt exist' do
    actual = false
    if Urls.find?('google') != false
      actual = Urls.find?('google').vanity_name
    end
    expect(actual).to eq(false)
  end

end