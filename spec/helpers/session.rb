module SessionHelpers

  def sign_up(email: 'alice@example.com', password: 'oranges!', password_confirmation: 'oranges!')
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email,    with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button 'Sign up'
  end

  def sign_in(email: 'alice@example.com', password: 'oranges!')
    User.create(email: email, password: password, password_confirmation: password)
    visit '/sessions/new'
    fill_in :email, with: email
    fill_in :password, with: password
    click_button 'Sign in'
  end

  def recover_password(email = 'alice@example.com')
    visit '/users/recovery'
    fill_in :email, with: email
    click_button 'Send a recovery email'
  end

  def recover_and_enter_new_password(new_password)
    recover_password
    set_password(password: new_password, password_confirmation: new_password)
  end

  def set_password(password: 'pass', password_confirmation: 'confirm')
    visit("/users/reset_password?token=#{User.first.password_token}")
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button 'Submit'
  end

end
