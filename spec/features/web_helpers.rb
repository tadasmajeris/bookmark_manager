def fill_in_makers_link
  visit '/links/new'
  fill_in :title, with: 'Makers Academy'
  fill_in :url,   with: 'http://www.makersacademy.com'
end

def add_bubbles_link
  fill_in_makers_link
  fill_in :tags, with: 'bubbles'
  click_button 'Add link'
end

def add_google_link
  visit '/links/new'
  fill_in :title, with: 'Google'
  fill_in :url,   with: 'http://www.google.com'
  fill_in :tags,  with: 'Search'
  click_button 'Add link'
end

def sign_up(email: 'alice@example.com',
            password: 'oranges!',
            password_confirmation: 'oranges!')
  visit '/users/new'
  expect(page.status_code).to eq(200)
  fill_in :email,    with: email
  fill_in :password, with: password
  fill_in :password_confirmation, with: password_confirmation
  click_button 'Sign up'
end
