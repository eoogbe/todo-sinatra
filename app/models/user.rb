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
  
  include Todo::Models::Validations
  
  attr_accessor :id, :email, :password
  attr_accessor :repository
  attr_writer :password_confirmation
  
  def initialize args = {}
    @id = args[:id]
    @email = args[:email]
    @password = args[:password]
    @password_confirmation = args[:password_confirmation]
    if args[:encrypted_password]
      self.encrypted_password = args[:encrypted_password]
    end
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
    validates_presence_of :email, :password
    
    validates_uniqueness_of :email
    validates_format_of :email, VALID_EMAIL_REGEX
    
    validates_confirmation_of :password
    validates_length_of :password, min: MIN_PASSWORD_LENGTH
    
    errors.blank?
  end
  
  def errors
    @errors ||= Todo::Models::Errors.new
  end
  
  def inspect
    "#<User id:#{id}, email:#{email}, password:#{password}>"
  end
  
  private
  def pepper
    Todo::App.settings.pepper
  end
  
  def repository
    @repository ||= UserMapper.new
  end
end
