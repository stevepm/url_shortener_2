require 'spec_helper'


feature 'Counts views to each page' do
  before do
    Migrator.new(DB).run
  end
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