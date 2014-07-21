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
  
  def all
    connection.execute('SELECT item_id, text FROM item').map do |row|
      Item.new id: row[:item_id], text: row[:text]
    end
  end
  
  def delete id
    connection.execute "DELETE FROM item WHERE item_id=?", [id]
  end
  
  def insert item
    connection.execute 'INSERT INTO item (text) VALUES (?)', [item.text]
    item.id = connection.last_insert_row_id
  end
  
  private
  attr_reader :connection
end
