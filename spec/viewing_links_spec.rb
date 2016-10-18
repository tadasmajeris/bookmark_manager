require "spec_helper"

feature 'Viewing Links' do

  scenario 'I can view links on the link page' do
    Link.create(url: 'http://www.google.com', title: 'Google')

    visit '/links'

    within 'ul#links' do
      expect(page).to have_content 'Google'
    end
  end
end