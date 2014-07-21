module ViewHelper
  BASE_TITLE = 'Todo'
  
  def t *args
    I18n.t(*args)
  end
  
  def pluralize count, str
    "#{count} #{str.pluralize count}"
  end
  
  def full_title
    page_title = t "titles.#{view_name}", default: ''
    page_title.present? ? "#{page_title} | #{BASE_TITLE}" : BASE_TITLE
  end
end
