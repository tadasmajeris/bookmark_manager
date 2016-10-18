def fill_in_makers_link
  visit '/links/new'

  fill_in :title, with: 'Makers Academy'
  fill_in :url,   with: 'http://www.makersacademy.com'
  # click_button 'Add link'
end
