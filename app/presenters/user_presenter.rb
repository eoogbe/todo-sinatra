require 'delegate'

class UserPresenter < SimpleDelegator
  include Todo::Presenters::Conversion
  alias_method :model, :__getobj__
  
  def initialize model = nil
    super model || User.new
  end
end
