require_relative 'db/sqlite'
require_relative 'db/pstore'

module IPAM
  class DB

    attr_reader :db
    def initialize (name='ipam',config={'driver' => 'sqlite'})
      @dbname = name
      @driver = config['driver']
      select_db
    end

    def select_db
      case @driver
      when 'sqlite'
        @db = IPAM::Sqlite.new(@dbname)
      when 'pstore'
        @db = DB::Pstore.new(@dbname)
      else
        #raise StandardError.new "Unsupported DB driver."
        puts @driver
      end
    end

  end
end