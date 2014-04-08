require 'capybara/rspec'
require 'spec_helper'
require_relative '../url_shortener'

Capybara.app = UrlShortener

feature 'Counts views to each page' do
  scenario 'it increases views when pages are visited' do
    visit '/'
    fill_in('url', :with => 'http://google.com')
    click_button('Shorten')
    id = id_of_created_url(current_path)
    visit "/#{id_of_created_url(current_path)}"
    visit "/#{id}?stats=true"
    visit "/#{id_of_created_url(current_path)}"
    visit "/#{id}?stats=true"
    expect(page).to have_content('Views: 2')
  end
end