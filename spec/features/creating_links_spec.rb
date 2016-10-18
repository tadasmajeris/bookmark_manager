require 'spec_helper'

feature 'Submitting links' do

  scenario 'I can submit a link' do
    visit '/links/new'
    fill_in('link_name', with: 'The Stephen Gregory, OBE')
    fill_in('link_url', with: 'http://www.stephengregory.co.uk/')
    click_button('Submit')
    expect(current_path).to eq '/links'
    within 'ul#links' do
      expect(page).to have_content('The Stephen Gregory, OBE')
    end
  end
end
