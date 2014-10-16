require 'app_helper'

feature 'User authorization' do
  scenario 'when new item page' do
    NewItemPage.visit
    expect(page.current_path).to eq SignInPage.path
  end
  
  scenario 'when sign in page' do
    sign_in_page = SignInPage.visit
    sign_in_page.sign_in create_user
    sign_in_page.visit_page
    expect(page.current_path).to eq NewItemPage.path
  end
  
  scenario 'when sign up page' do
    SignInPage.sign_in create_user
    SignUpPage.visit
    expect(page.current_path).to eq NewItemPage.path
  end
end
