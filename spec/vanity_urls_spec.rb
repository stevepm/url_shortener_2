require 'spec_helper'

feature 'Vanity URLs' do
  before do
    Migrator.new(DB).run
  end

  scenario 'Shorten a URL with specific vanity URL' do
    pending

    visit '/'
    fill_in('url', :with => 'http://google.com')
    fill_in('vanity', :with => 'google')
    click_button('Shorten')
    expect(page).to have_content('http://google.com')
    expect(page).to have_content("http://www.example.com/google")

    visit "/google"

    expect(current_url).to eq 'http://google.com/'
  end
end