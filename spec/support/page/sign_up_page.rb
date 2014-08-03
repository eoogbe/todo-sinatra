require_relative 'page_object'

class SignUpPage < PageObject
  def self.path
    '/users/new'
  end
  
  def sign_up email, password
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password
    click_on 'Sign Up'
    
    SignInPage.new
  end
  
  def has_error?
    has_content? 'Password must be at least 12 characters'
  end
end
