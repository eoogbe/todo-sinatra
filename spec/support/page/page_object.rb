require 'capybara'
require 'capybara/dsl'

class PageObject
  include Capybara::DSL
  
  def self.visit
    new.tap {|page| page.visit_page }
  end
  
  def visit_page
    visit self.class.path
  end
end
