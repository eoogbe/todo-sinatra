class CreateUserTable < Todo::Db::Version
  def change
    execute 'CREATE TABLE user (
      user_id INTEGER PRIMARY KEY AUTOINCREMENT,
      email VARCHAR UNIQUE,
      encrypted_password VARCHAR
    )'
  end
end
