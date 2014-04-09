require 'spec_helper'


feature 'Counts views to each page' do
  before do
    Migrator.new(DB).run
  end
  scenario 'it increases views when pages are visited' do
    pending

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

  scenario 'users goes to a page that doesnt exist' do
    visit '/2'
    expect(current_url).to eq("http://www.example.com")
  end
end