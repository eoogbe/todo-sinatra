require 'capybara'
require 'capybara/dsl'

class SignInPage
  include Capybara::DSL
  
  def self.visit
    new.tap {|page| page.visit_page }
  end
  
  def sign_in email, password
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_on 'Sign In'
  end
  
  def has_success?
    has_content? 'Welcome user!'
  end
  
  def has_error?
    has_content? 'Invalid email or password'
  end
  
  def visit_page
    visit '/sessions/new'
  end
end
