require 'feature_helper'

feature 'Sign in user' do
  given!(:user) { User.new email: 'user1@example.com', password: 'foobar' }
  given(:sign_in_page) { @sign_in_page }
  
  background do
    UserMapper.insert user
    @sign_in_page = SignInPage.visit
  end
  
  scenario 'when valid' do
    sign_in_page.sign_in user.email, user.password
    expect(sign_in_page).to have_success
  end
  
  scenario 'when invalid' do
    sign_in_page.sign_in user.email, 'wrong password'
    expect(sign_in_page).to have_error
  end
end
