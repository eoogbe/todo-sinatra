module ObjectMother
  def new_item attrs = {}
    text = attrs[:text] || 'The text'
    user = attrs[:user] || create_user
    
    Item.new text: text, user: user
  end
  
  def create_item attrs = {}
    create_model new_item(attrs), ItemMapper
  end
  
  def new_user attrs = {}
    email = attrs[:email] || "user#{new_user_counter}@example.com"
    password = attrs[:password] || "foobarfoobar"
    
    User.new email: email, password: password
  end
  
  def create_user attrs = {}
    create_model new_user(attrs), UserMapper
  end
  
  private
  def create_model model, mapper
    mapper.insert model
    model
  end
  
  def new_user_counter
    @new_user_counter ||= 0
    @new_user_counter += 1
  end
end
