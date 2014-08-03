require_relative 'page_object'

class SignInPage < PageObject
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
  
  def has_error?
    has_content? 'Invalid email or password'
  end
end
