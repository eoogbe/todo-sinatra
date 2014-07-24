module ViewHelper
  BASE_TITLE = 'Todo'
  
  def translate *args
    I18n.translate(*args)
  end
  alias_method :t, :translate
  
  def full_title
    page_title = t "titles.#{view_name}", default: ''
    page_title.present? ? "#{page_title} | #{BASE_TITLE}" : BASE_TITLE
  end
  
  def form_for object, action = nil
    action ||= send default_path_for object
    tag :form, action: action, method: :post do
      yield Todo::Forms::FormBuilder.new object, self
    end
  end
  
  private
  def default_path_for object
    "#{object.model_class.underscore.tr('/', '_').pluralize}_path"
  end
end
