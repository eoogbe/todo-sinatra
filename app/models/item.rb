class Item
  attr_accessor :id, :text
  
  def initialize args = {}
    @text = args[:text]
  end
  
  def validate
    errors.add(:text, :blank) if text.blank?
    errors.blank?
  end
  
  def errors
    @errors ||= Todo::Models::Errors.new
  end
end
