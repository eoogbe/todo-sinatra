class ItemMapper
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
  def connection
    @connection ||= Todo::Db::Connection.new
  end
end
