feature 'User sign up' do

  scenario 'I can sign up as a new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario 'checks if passwords dont match' do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content "Passwords don't match"
  end

  scenario 'can\'t sign up without an email'do
    expect { sign_up(email: nil) }.not_to change(User, :count)
    expect(page).to have_content "Please enter email address"
  end

  scenario 'can\'t sign up without valid email'do
    expect { sign_up(email: 'invalid@email') }.not_to change(User, :count)
    expect(page).to have_content "Invalid email"
  end

end
