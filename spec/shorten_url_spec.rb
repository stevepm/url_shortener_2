require 'spec_helper'

feature 'URL Shortening' do
  before do
    Migrator.new(DB).run
  end

  scenario 'Shorten a URL' do
    visit '/'
    fill_in('url_to_shorten', :with => 'http://google.com')
    click_button('Shorten')
    expect(page).to have_content('http://google.com')
    expect(page).to have_content("http://www.example.com/#{id_of_created_url(current_path)}")

    visit "/#{id_of_created_url(current_path)}"

    expect(current_url).to eq 'http://google.com/'
  end

  scenario 'User enters a blank url' do

    visit '/'
    fill_in('url_to_shorten', :with => '')
    click_button('Shorten')
    expect(page).to have_content('Please enter a valid URL')
  end

  scenario 'User enters an incorrect url' do

    visit '/'
    fill_in('url_to_shorten', :with => 'test')
    click_button('Shorten')
    expect(page).to have_content('Please enter a valid URL')
  end
  scenario 'User enters an url without http://' do

    visit '/'
    fill_in('url_to_shorten', :with => 'google.com')
    click_button('Shorten')
    expect(page).to have_content('http://google.com')
  end
end