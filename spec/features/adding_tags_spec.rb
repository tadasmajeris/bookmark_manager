# require 'adding_tags'

feature 'Adding tags' do

  scenario 'I can add a single tag to a new link' do
    visit '/links/new'
    fill_in('link_name', with: 'The Stephen Gregory, OBE')
    fill_in('link_url', with: 'http://www.stephengregory.co.uk/')
    fill_in 'tags',  with: 'actor'

    click_button('Submit')
    link = Link.first
    expect(link.tags.map(&:name)).to include('actor')
  end

  scenario 'I can add multiple tags to a new link' do
    visit '/links/new'
    fill_in('link_url', with: 'http://www.makersacademy.co.uk')
    fill_in('link_name', with: 'Makers Academy')
    fill_in('tags', with: 'education ruby sinatra')
    click_button 'Submit'
    link = Link.first
    expect(link.tags.map(&:name)).to include('education', 'ruby', 'sinatra')

  end
end
