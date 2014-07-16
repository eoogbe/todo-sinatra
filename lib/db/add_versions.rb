require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'

module Todo
  module Db
    class AddVersions
      def initialize connection
        @connection = connection
      end
      
      def exec
        connection.execute create_schema_version_table_sql
        
        new_versions.each do |version|
          run_version version
          save_version version
        end
      end
      
      private
      attr_reader :connection
      
      def versions
        @versions ||= Dir[File.join Todo::App.settings.root, 'db', 'versions', '*.rb']
      end
      
      def last_version_id
        @last_version_id ||= begin
          rows = connection.execute select_last_version_id_sql
          rows.present? ? rows.first[:id] : 0
        end
      end
      
      def new_versions
        @new_versions ||= versions.select do |version|
          version_id = version[::Todo::Db::Version::REGEX, 1].to_i
          version_id > last_version_id
        end
      end
      
      def run_version version
        require version
        version_class = version[::Todo::Db::Version::REGEX, 2].camelize.constantize
        version_class.new(connection).change
      end
      
      def save_version version
        version_id = version[::Todo::Db::Version::REGEX, 1].to_i
        connection.execute insert_into_schema_version_table_sql, [version_id]
      end
      
      def create_schema_version_table_sql
        'CREATE TABLE IF NOT EXISTS schema_version (id INTEGER PRIMARY KEY)'
      end
      
      def select_last_version_id_sql
        'SELECT id FROM schema_version ORDER BY id DESC LIMIT 1'
      end
      
      def insert_into_schema_version_table_sql
        'INSERT INTO schema_version VALUES (?)'
      end
    end
  end
end
