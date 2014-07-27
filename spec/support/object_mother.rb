module ObjectMother
  def new_item
    Item.new text: 'The text'
  end
  
  def create_item
    create_model new_item, ItemMapper
  end
  
  def new_user
    User.new email: 'user1@example.com', password: 'foobar'
  end
  
  def create_user
    create_model new_user, UserMapper
  end
  
  private
  def create_model model, mapper
    mapper.insert model
    model
  end
end
