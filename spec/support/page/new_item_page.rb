require 'capybara'
require 'capybara/dsl'

class NewItemPage
  include Capybara::DSL
  
  def self.visit
    new.tap {|page| page.visit_page }
  end
  
  def add_item text
    fill_in 'Item', with: text
    click_on 'Add Item'
  end
  
  def delete_item
    find('table').click_on 'delete'
  end
  
  def has_item? text
    has_selector? 'td', text: text
  end
  
  def has_no_items?
    has_no_selector? 'table'
  end
  
  def has_error?
    has_content? 'Item must not be blank'
  end
  
  def visit_page
    visit '/'
  end
end
