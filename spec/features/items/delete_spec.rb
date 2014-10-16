require 'app_helper'

feature 'Delete list item' do
  given!(:item) { create_item }
  given(:new_item_page) { @new_item_page }
  
  background do
    SignInPage.sign_in item.user
    @new_item_page = NewItemPage.visit
  end
  
  scenario 'when deleting' do
    new_item_page.delete_item
    expect(new_item_page).to be_current_page
    expect(new_item_page).to have_no_items
  end
end
