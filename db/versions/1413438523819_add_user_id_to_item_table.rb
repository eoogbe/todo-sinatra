class AddUserIdToItemTable < Todo::Db::Version
  def change
    execute "ALTER TABLE item
      ADD COLUMN user_id INTEGER REFERENCES user(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE"
  end
end
