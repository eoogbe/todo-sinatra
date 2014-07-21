require 'active_support/core_ext/string/inflections'
require './config/app'

module Todo
  module Tasks
    module Db
      class Version < ::Thor
        include Thor::Actions
        namespace "db:version"
        
        def self.source_root
          File.expand_path( '../..', __FILE__)
        end
        
        desc 'add', 'adds new versions to the database'
        def add
          ::Todo::Db::Connection.open do |connection|
            ::Todo::Db::AddVersions.new(connection).exec
          end
        end
        
        desc 'new VERSION_NAME', 'creates a new database version'
        def new version_name
          self.version_class = version_name.camelize
          timestamp = DateTime.now.strftime '%Q'
          filename = "db/versions/#{timestamp}_#{version_name.underscore}.rb"
          template "templates/version.tt", filename
        end
        
        private
        attr_accessor :version_class
        
        def create_schema_version_table_sql
          'CREATE TABLE IF NOT EXISTS schema_version (id INT PRIMARY KEY)'
        end
      end
    end
  end
end
