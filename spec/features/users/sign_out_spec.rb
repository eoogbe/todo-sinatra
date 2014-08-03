require 'app_helper'

feature 'User sign out' do
  scenario 'when signing out' do
    SignInPage.sign_in create_user
    new_item_page = NewItemPage.visit
    new_item_page.sign_out
    expect(page.current_path).to eq SignInPage.path
  end
end
