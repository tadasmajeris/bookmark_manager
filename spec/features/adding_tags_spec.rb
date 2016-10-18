# require 'adding_tags'

feature 'Adding tags' do

  scenario 'I can add a single tag to a new link' do
    visit '/links/new'
    fill_in('link_name', with: 'The Stephen Gregory, OBE')
    fill_in('link_url', with: 'http://www.stephengregory.co.uk/')
    fill_in 'tags',  with: 'failed actor'

    click_button('Submit')
    link = Link.first
    expect(link.tags.map(&:name)).to include('failed actor')
  end

end
