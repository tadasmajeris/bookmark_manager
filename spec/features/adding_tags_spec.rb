require 'spec_helper'

feature 'Adding a link with a tag' do
  scenario 'User can tag a link' do
    fill_in_makers_link
    fill_in :tags, with: 'Ruby'
    click_button 'Add link'
    link = Link.first
    expect(link.tags.map(&:name)).to include('Ruby')
  end

  scenario 'I can add multiple tags to a link' do
    fill_in_makers_link
    fill_in :tags, with: 'ruby education'
    click_button 'Add link'
    link = Link.first
    expect(link.tags.map(&:name)).to include('ruby', 'education')
  end
end