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
    user.id = connection.last_insert_row_id
  end
  
  def find conditions
    conditions = { user_id: conditions } unless conditions.is_a? Hash
    rows = connection.execute find_sql(conditions), conditions.values
    return User::Nil.new if rows.empty?
    User.new id: rows.first[:user_id], email: rows.first[:email],
      encrypted_password: rows.first[:encrypted_password]
  end
  
  def exists? conditions
    connection.execute(exists_sql(conditions), conditions.values).present?
  end
  
  private
  attr_reader :connection
  
  def conditions_to_sql conditions
    conditions.keys.map do |type|
      %Q["#{Todo::Db::Connection.escape_quotes(type)}"=?]
    end.join(' AND ')
  end
  
  def insert_sql
    'INSERT INTO user (email, encrypted_password) VALUES (?, ?)'
  end
  
  def find_sql conditions
    "SELECT user_id, email, encrypted_password
      FROM user
      WHERE #{conditions_to_sql(conditions)}"
  end
  
  def exists_sql conditions
    "SELECT 1 FROM user WHERE #{conditions_to_sql(conditions)} LIMIT 1"
  end
end
