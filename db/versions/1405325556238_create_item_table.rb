class CreateItemTable < Todo::Db::Version
  def change
    execute 'CREATE TABLE item (item_id INT PRIMARY KEY, text VARCHAR)'
  end
end
