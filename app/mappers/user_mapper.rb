class UserMapper
  def self.insert user
    new.insert user
  end
  
  def self.find conditions
    new.find conditions
  end
  
  def initialize connection = nil
    @connection = connection || Todo::Db::Connection.new
  end
  
  def insert user
    connection.execute insert_sql, [user.email, user.encrypted_password]
  end
  
  def find conditions
    conditions = {user_id: conditions} unless conditions.is_a? Hash
    rows = connection.execute find_sql(conditions), conditions.values
    return User::Nil.new if rows.empty?
    User.new id: rows.first[:user_id], email: rows.first[:email],
      encrypted_password: rows.first[:encrypted_password]
  end
  
  private
  attr_reader :connection
  
  def insert_sql
    'INSERT INTO user (email, encrypted_password) VALUES (?, ?)'
  end
  
  def find_sql conditions
    conditions_sql = conditions.keys.map do |type|
      Todo::Db::Connection.escape_quotes(type) + '=?'
    end.join(' AND ')
    
    "SELECT user_id, email, encrypted_password FROM user WHERE #{conditions_sql}"
  end
end
