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
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  MIN_PASSWORD_LENGTH = 12
  
  attr_accessor :id, :email, :password
  attr_accessor :repository
  attr_writer :password_confirmation
  
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
  
  def password_confirmation
    @password_confirmation ||= password
  end
  
  def validate
    errors.add :email, :blank if email.blank?
    errors.add :email, :duplicate if repository.exists? email: email
    errors.add :email, :format unless email =~ VALID_EMAIL_REGEX
    
    errors.add :password, :blank if password.blank?
    errors.add :password, :confirmation if password != password_confirmation
    if password.present? && password.length < MIN_PASSWORD_LENGTH
      errors.add :password, :too_short, count: MIN_PASSWORD_LENGTH
    end
    
    errors.blank?
  end
  
  def errors
    @errors ||= Todo::Models::Errors.new
  end
  
  private
  def pepper
    Todo::App.settings.pepper
  end
  
  def repository
    @repository ||= UserMapper.new
  end
end
