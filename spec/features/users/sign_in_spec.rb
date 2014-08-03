require 'app_helper'

feature 'Sign in user' do
  given!(:user) { create_user }
  given(:sign_in_page) { @sign_in_page }
  
  background do
    @sign_in_page = SignInPage.visit
  end
  
  scenario 'when valid' do
    sign_in_page.sign_in user.email, user.password
    expect(page.current_path).to eq NewItemPage.path
  end
  
  scenario 'when invalid' do
    sign_in_page.sign_in user.email, 'wrong password'
    expect(sign_in_page).to have_error
  end
end
