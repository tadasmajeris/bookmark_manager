require "spec_helper"

feature 'Creating Links' do

  scenario 'creating a new link' do
    fill_in_makers_link
    click_button 'Add link'
    expect(current_path).to eq '/links'

    within 'ul#links' do
      expect(page).to have_content 'Makers Academy'
    end
  end
end
