require 'sqlite3'

module IPAM
  class Sqlite < IPlist::DB
    def initialize
      @db = SQLITE3::Database.open("db/#{name}.db")
    end
  end
end