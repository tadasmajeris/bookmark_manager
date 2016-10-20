feature 'User sign up' do

  scenario 'I can sign up as a new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario 'checks if passwords dont match' do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content "Password does not match the confirmation"
  end

  scenario 'can\'t sign up without an email'do
    expect { sign_up(email: nil) }.not_to change(User, :count)
    expect(page).to have_content "Email must not be blank"
  end

  scenario 'can\'t sign up without valid email'do
    expect { sign_up(email: 'invalid@email') }.not_to change(User, :count)
    expect(page).to have_content "Email has an invalid format"
  end

  scenario 'user can\'t sign up twice' do
    sign_up
    expect { sign_up }.not_to change(User, :count)
    expect(page).to have_content "Email is already taken"
  end

end

feature 'User sign in' do
    scenario 'I can sign in as an existing user' do
      User.create(email: 'alice@example.com', password: 'oranges!', password_confirmation: 'oranges!')
      visit '/sessions/new'
      fill_in :email, with: 'alice@example.com'
      fill_in :password, with: 'oranges!'
      click_button 'Sign in'
      expect(current_path).to eq '/links'
      expect(page).to have_content "Welcome, alice@example.com"
    end
end
