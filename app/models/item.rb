class Item
  attr_accessor :text
  
  def initialize args = {}
    @text = args[:text]
  end
  
  def validate
    errors[:text] = :blank if text.blank?
    errors.blank?
  end
  
  def errors
    @errors ||= {}
  end
end
