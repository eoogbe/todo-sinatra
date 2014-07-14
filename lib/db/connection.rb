require 'arrayfields'
require 'sqlite3'
require File.expand_path '../../config/app', __dir__

module Todo
  module Db
    class Connection
      def self.open &block
        yield new 
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
      
      def truncate_all
        execute "SELECT name FROM sqlite_master WHERE type='table'" do |row|
          execute %Q(DELETE FROM "#{row[:name].gsub '"', '""'}") unless row[:name] == 'schema_version'
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
