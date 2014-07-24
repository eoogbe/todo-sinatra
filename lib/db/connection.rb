require 'arrayfields'
require 'sqlite3'
require './config/app'

module Todo
  module Db
    class Connection
      def self.open &block
        yield new 
      end
      
      def self.escape_quotes text
        text.to_s.gsub '"', '""'
      end
      
      def initialize connection = nil
        @connection = connection || SQLite3::Database.new(dbname)
      end
      
      def execute sql, params = {}, &block
        results = connection.prepare(sql).execute params
        rows = results.to_a.map do |result|
          result.tap {|r| r.fields = results.columns }
        end
        rows.each {|row| yield row } if block_given?
        rows
      end
      
      def last_insert_row_id
        connection.last_insert_row_id
      end
      
      def truncate_all
        execute "SELECT name FROM sqlite_master WHERE type='table'" do |row|
          unless row[:name] == 'schema_version'
            execute %Q(DELETE FROM "#{self.class.escape_quotes row[:name]}")
          end
        end
      end
      
      def drop_all
        execute drop_all_tables_sql
      end
      
      private
      attr_reader :connection
      
      def dbname
        File.join App.settings.root, 'db', "#{App.settings.database}.sqlite3"
      end
      
      def drop_all_tables_sql
        "SELECT 'DROP TABLE ' || name || ';'
           FROM sqlite_master WHERE type = 'table'"
      end
    end
  end
end
