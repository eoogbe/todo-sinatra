require 'feature_helper'

feature 'Create list item' do
  background do
    visit '/'
  end
  
  scenario 'when valid' do
    fill_in 'Item', with: 'The text'
    click_on 'Add Item'
    expect(page).to have_selector 'td', text: 'The text'
  end
  
  scenario 'when invalid' do
    click_on 'Add Item'
    expect(page).not_to have_selector 'ol'
    expect(page).to have_selector 'form .errors li', text: 'Text must not be blank'
  end
end
