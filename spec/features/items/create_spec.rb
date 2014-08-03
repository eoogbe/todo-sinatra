require 'app_helper'

feature 'Create list item' do
  given(:new_item_page) { @new_item_page }
  
  background do
    SignInPage.sign_in create_user
    @new_item_page = NewItemPage.visit
  end
  
  scenario 'when valid' do
    new_item_page.add_item 'The text'
    expect(new_item_page).to have_item 'The text'
  end
  
  scenario 'when invalid' do
    new_item_page.add_item ''
    expect(new_item_page).to have_no_items
    expect(new_item_page).to have_error
  end
end
