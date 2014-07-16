class CreateItemTable < Todo::Db::Version
  def change
    execute 'CREATE TABLE item (
      item_id INTEGER PRIMARY KEY AUTOINCREMENT,
      text VARCHAR
    )'
  end
end
