module ViewHelper
  BASE_TITLE = 'Todo'
  
  def translate *args
    I18n.translate(*args)
  end
  alias_method :t, :translate
  
  def full_title
    page_title = t view_name, default: '', scope: :titles
    page_title.present? ? "#{page_title} | #{BASE_TITLE}" : BASE_TITLE
  end
  
  def form_for obj_or_sym, action = nil
    action ||= send default_path_for obj_or_sym
    tag :form, action: action, method: :post do
      yield Todo::Forms::FormBuilder.new obj_or_sym, self
    end
  end
  
  def button_to text, url, options = {}
    method = options.delete(:method) || :post
    form_method = method.to_s == 'get' ? :get : :post
    form_attrs = { action: url, method: form_method, class: options.delete(:form_class) }
    button_attrs = { type: :submit }.merge options
    
    tag :form, form_attrs do
      if %w(get post).include? method.to_s
        tag(:button, text, button_attrs)
      else
        tag(:input, type: :hidden, name: '_method', value: method) +
        tag(:button, text, button_attrs)
      end
    end
  end
  
  def link_to text, url, options = {}
    html_attrs = { href: url }.merge options
    tag :a, text, html_attrs
  end
  
  private
  def default_path_for obj_or_sym
    obj_or_sym.is_a?(Symbol) ? symbol_default_path(obj_or_sym) :
      object_default_path(obj_or_sym)
  end
  
  def object_default_path obj
    "#{obj.model_class.underscore.tr('/', '_').pluralize}_path"
  end
  
  def symbol_default_path sym
    "#{sym.to_s.pluralize}_path"
  end
end
