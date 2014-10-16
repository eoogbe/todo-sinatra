class ItemMapper
  def self.all
    new.all
  end
  
  def self.delete id
    new.delete id
  end
  
  def self.insert item
    new.insert item
  end
  
  def initialize connection = nil
    @connection = connection || Todo::Db::Connection.new
  end
  
  def where_user user
    connection.execute(where_user_sql, [user.id]).map do |row|
      Item.new id: row[:item_id], text: row[:text], user: user
    end
  end
  
  def delete id
    connection.execute "DELETE FROM item WHERE item_id = ?", [id]
  end
  
  def insert item
    connection.execute 'INSERT INTO item (text, user_id) VALUES (?, ?)',
      [item.text, item.user.id]
    item.id = connection.last_insert_row_id
  end
  
  private
  attr_reader :connection
  
  def where_user_sql
    'SELECT item_id, text FROM item WHERE user_id = ?'
  end
end
