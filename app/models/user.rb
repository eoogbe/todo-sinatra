class User
  class Nil
    def valid_password? password
      false
    end
    
    def email
      ''
    end
    
    def password
      ''
    end
  end
  
  attr_accessor :id, :email, :password
  
  def initialize args = {}
    mass_assign args
  end
  
  def valid_password? password
    self.password ? self.password == password
      : self.encrypted_password == password + pepper
  end
  
  def encrypted_password
    @encrypted_password ||= BCrypt::Password.create password + pepper
  end
  
  def encrypted_password= password
    @encrypted_password = BCrypt::Password.new password
  end
  
  def errors
    @errors ||= Todo::Models::Errors.new
  end
  
  private
  def pepper
    Todo::App.settings.pepper
  end
end
