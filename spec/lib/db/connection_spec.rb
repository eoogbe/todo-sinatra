require 'rspec/given'
require 'spec_helper'
require './lib/db/connection'

describe Todo::Db::Connection do
  describe '::escape' do
    When(:result) { Todo::Db::Connection.escape_quotes '"weird"_table_name' }
    Then { result == '""weird""_table_name' }
  end
end
