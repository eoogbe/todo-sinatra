require 'app_helper'

feature 'User sign up' do
  scenario 'when valid' do
    sign_up_page = SignUpPage.visit
    sign_up_page.sign_up 'user@example.com', 'foobarfoobar'
    expect(page.current_path).to eq SignInPage.path
  end
  
  scenario 'when invalid' do
    sign_up_page = SignUpPage.visit
    sign_up_page.sign_up 'user@example.com', 'foobar'
    expect(sign_up_page).to have_error
  end
  
  scenario 'when signing in' do
    sign_up_page = SignUpPage.visit
    sign_in_page = sign_up_page.sign_up 'user@example.com', 'foobarfoobar'
    sign_in_page.sign_in 'user@example.com', 'foobarfoobar'
    expect(page.current_path).to eq NewItemPage.path
  end
end
