require "spec_helper"

feature 'Password recovery' do
  let(:email) { 'alice@example.com' }
  before do
    sign_up(email: email)
    Capybara.reset!
  end

  scenario 'User can ask for password recovery' do
    visit '/sessions/new'
    click_link 'Forgot your password?'
    expect(page).to have_content "Fill in your email"
    expect(current_path).to eq '/users/recovery'
  end

  scenario 'User can submit their email and get acknowledgment message' do
    recover_password(email)
    expect(page).to have_content "Email was sent to #{email}"
  end

  scenario 'assign a reset token to the user when they recover' do
    expect { recover_password(email) }.to change { User.first.password_token }
  end

  scenario 'it doesnt allow you to use the token after an hour' do
    recover_password
    Timecop.travel(60 * 60 * 60) do
      visit("/users/reset_password?token=#{User.first.password_token}")
      expect(page).to have_content "Your token is invalid"
    end
  end

  scenario 'it asks for your new password when token is valid' do
    recover_password
    visit("/users/reset_password?token=#{User.first.password_token}")
    expect(page).to have_content "Please enter your new password"
  end

  scenario 'it lets you enter a new password with a valid token' do
    recover_and_enter_new_password('newpassword')
    expect(page).to have_content("Please sign in")
    expect(current_path).to eq '/sessions/new'
  end

  scenario 'it lets you sign in after password reset' do
    recover_and_enter_new_password('newpassword')
    sign_in(email: "alice@example.com", password: 'newpassword')
    expect(page).to have_content "Welcome, alice@example.com"
  end

  scenario 'it lets you know if your passwords dont match' do
    recover_password
    set_password(password: 'newpassword', password_confirmation: 'wrong_pass')
    expect(page).to have_content "Password does not match the confirmation"
  end

  scenario 'it immediately resets token upon successful password update' do
    recover_and_enter_new_password('newpassword')
    visit("/users/reset_password?token=#{User.first.password_token}")
    expect(page).to have_content "Your token is invalid"
  end
end
