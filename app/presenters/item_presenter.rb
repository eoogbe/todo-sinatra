require 'delegate'

class ItemPresenter < SimpleDelegator
  include Todo::Presenters::Conversion
  alias_method :model, :__getobj__
  
  def initialize model = nil
    super model || Item.new
  end
end
