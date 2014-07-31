require 'capybara'
require 'capybara/dsl'

class SignInPage
  include Capybara::DSL
  
  def self.visit
    new.tap {|page| page.visit_page }
  end
  
  def self.path
    '/session/new'
  end
  
  def self.sign_in email, password = nil
    visit.sign_in email, password
  end
  
  def sign_in email, password = nil
    if password.nil?
      user = email
      email = user.email
      password = user.password
    end
    
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
    visit self.class.path
  end
end
