class Item
  include Todo::Models::Validations
  attr_accessor :id, :text, :user
  
  def initialize args = {}
    @id = args[:id]
    @text = args[:text]
    @user = args[:user]
  end
  
  def validate
    validates_presence_of :text, :user
    
    errors.blank?
  end
  
  def errors
    @errors ||= Todo::Models::Errors.new
  end
end
