require 'app_helper'

feature 'Association with user' do
  scenario 'when creating' do
    sign_in_page = SignInPage.visit
    new_item_page = sign_in_page.sign_in create_user
    new_item_page.add_item 'The text'
    new_item_page.sign_out
    sign_in_page.sign_in create_user
    expect(new_item_page).to have_no_item 'The text'
  end
end
