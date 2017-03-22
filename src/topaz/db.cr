require "singleton"
require "db"

module Topaz
  class Db
    @@shared : DB::Database?

    # Setup a database by connection uri
    # See official sample for detail
    # For MySQL https://github.com/crystal-lang/crystal-mysql
    # For SQLite3 https://github.com/crystal-lang/crystal-sqlite3
    # For PostgreSQL https://github.com/will/crystal-pg
    def self.setup(connection : String)
      setup(URI.parse(connection))
    end

    # Setup a database by connection uri
    def self.setup(uri : URI)
      @@shared = DB.open(uri)
    end

    # Get shared db instance
    def self.shared
      check
      @@shared.as(DB::Database)
    end

    # Close the database
    def self.close
      check
      @@shared.as(DB::Database).close
      @@shared = nil
    end

    def self.show_query(set : Bool)
      Topaz::Log.show_query(set)
    end

    def self.scheme
      check
      @@shared.as(DB::Database).uri.scheme
    end

    # Return time_format for each platform
    def self.time_format : String
      if instance = @@shared
        case instance.uri.scheme
        when "mysql", "sqlite3"
          return "%F %T:%L %z"
        when "postgres"
          return "%F %T.%L %z"
        end
      end
      ""
    end

    protected def self.check
      raise "Database is not initialized, please call Topaz::Db.setup(String|URI)" if @@shared.nil?
    end
  end
end
