require File.expand_path '../../../config/app', __FILE__

module Todo
  module Db
    class Connection
      def self.open &block
        new.open(&block)
      end
      
      def open
        self.session = Moped::Session.new ['localhost:27017']
        session.use App.settings.database
        yield self
      end
      
      def truncate_all
        session.collection_names.each do |collection|
          session[collection].find.remove_all
        end
      end
      
      private
      attr_accessor :session
    end
  end
end
