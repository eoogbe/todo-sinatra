class ItemMapper
  def all
    connection.execute('SELECT text FROM item').map do |row|
      Item.new text: row[:text]
    end
  end
  
  def insert item
    connection.execute insert_item_sql, [find_next_id, item.text]
  end
  
  private
  def connection
    @connection ||= Todo::Db::Connection.new
  end
  
  def find_next_id
    rows = connection.execute 'SELECT MAX(item_id) FROM item'
    id = rows.first[:item_id] || 0
    id + 1
  end
  
  def insert_item_sql
    'INSERT INTO item (item_id, text) VALUES (?, ?)'
  end
end
