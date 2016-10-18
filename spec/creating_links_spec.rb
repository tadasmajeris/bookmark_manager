require "spec_helper"

feature 'Creating Links' do

  scenario 'creating a new link' do
    visit '/links/new'

    fill_in :title, with: 'Makers Academy'
    fill_in :url,   with: 'http://www.makersacademy.com'
    click_button 'Add link'

    expect(current_path).to eq '/links'

    within 'ul#links' do
      expect(page).to have_content 'Makers Academy'
    end
  end
end
