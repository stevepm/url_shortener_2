require 'capybara/rspec'
require 'spec_helper'
require_relative '../url_shortener'

Capybara.app = UrlShortener

feature 'URL Shortening' do
  scenario 'Shorten a URL' do
    visit '/'
    fill_in('url', :with => 'http://google.com')
    click_button('Shorten')
    expect(page).to have_content('http://google.com')
    expect(page).to have_content("http://www.example.com/#{id_of_created_url(current_path)}")

    visit "/#{id_of_created_url(current_path)}"

    expect(current_url).to eq 'http://google.com/'
  end
end