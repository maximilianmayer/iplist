module IPAM
  class DB
    # @param [Object] name
    # @param [Object] config
    def initialize (name,config)
      @driver = config['driver']
      @dbname = name
    end

    case @driver
    when 'sqlite'
      @db = IPAM::DB::Sqlite.new(dbname)
    when 'pstore'
      @db = IPAM::DB::Pstore.new(dbname)
    else
      #raise StandardError.new "Unsupported DB driver."
      puts @driver
    end
  end
end