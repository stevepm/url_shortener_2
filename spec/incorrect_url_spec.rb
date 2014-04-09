require 'spec_helper'


feature 'Counts views to each page' do
  before do
    Migrator.new(DB).run
  end

  scenario 'users goes to a page that doesnt exist' do
    visit '/2'
    expect(current_url).to eq("http://www.example.com/")
  end
end